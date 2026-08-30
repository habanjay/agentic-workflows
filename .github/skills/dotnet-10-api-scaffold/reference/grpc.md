# gRPC reference: ASP.NET Core gRPC workflow

This document contains the detailed guidance for gRPC projects. Use it only when the user selects the gRPC stack.

## Project shape

```text
Solution Items
|_Docker
src
|_mygrpcservice
Protos
|_greeter.proto
tests
|_unit
|_integration
|_e2e
```

## Required standards

- Use ASP.NET Core gRPC.
- Include a `.proto` contract and a service implementation class.
- If HTTP/JSON access is desired, use gRPC JSON transcoding.
- Generate OpenAPI with `AddOpenApi()` and expose it with `MapOpenApi()` for the transcoded surface.
- Expose Scalar UI in development with `MapScalarApiReference()`.
- Keep service registration and startup composition cleanly separated.

## Typical startup pattern

```csharp
using Microsoft.AspNetCore.OpenApi;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddGrpc()
    .AddJsonTranscoding();

builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}

app.MapGrpcService<GreeterService>();

app.Run();
```

## Example proto

```proto
syntax = "proto3";

option csharp_namespace = "MyGrpcService";

package greeter;

service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply);
}

message HelloRequest {
  string name = 1;
}

message HelloReply {
  string message = 1;
}
```

## Example service implementation

```csharp
using Grpc.Core;
using MyGrpcService;

public class GreeterService : Greeter.GreeterBase
{
    public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
    {
        return Task.FromResult(new HelloReply
        {
            Message = $"Hello {request.Name}!"
        });
    }
}
```

## Package guidance

```xml
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>

  <ItemGroup>
    <PackageVersion Include="Microsoft.NET.Test.Sdk" Version="17.12.0" />
    <PackageVersion Include="xunit" Version="2.9.2" />
    <PackageVersion Include="xunit.runner.visualstudio" Version="2.8.2" />
    <PackageVersion Include="coverlet.collector" Version="6.0.2" />
    <PackageVersion Include="Microsoft.AspNetCore.Mvc.Testing" Version="10.0.0" />
    <PackageVersion Include="Grpc.AspNetCore" Version="2.67.0" />
    <PackageVersion Include="Grpc.AspNetCore.Server.Reflection" Version="2.67.0" />
    <PackageVersion Include="Microsoft.AspNetCore.Grpc.JsonTranscoding" Version="10.0.0" />
    <PackageVersion Include="Scalar.AspNetCore" Version="2.x" />
  </ItemGroup>
</Project>
```

## Health check guidance

```csharp
builder.Services.AddHealthChecks();

var app = builder.Build();

app.MapHealthChecks("/health");
app.MapGrpcService<GreeterService>();
```
