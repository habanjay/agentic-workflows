# REST reference: Minimal API workflow

This document contains the detailed guidance for REST projects. Use it only when the user selects the REST stack.

## Project shape

```text
Solution Items
|_Docker
src
|_myapp
tests
|_unit
|_integration
|_e2e
```

## Required standards

- Use ASP.NET Core minimal APIs.
- Generate OpenAPI with `AddOpenApi()` and expose it with `MapOpenApi()`.
- Expose Scalar UI in development with `MapScalarApiReference()`.
- Keep health checks in a dedicated endpoint file outside `Program.cs`.
- Prefer `Directory.Packages.props` for central package management.

## Typical startup pattern

```csharp
using Microsoft.AspNetCore.OpenApi;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}

app.MapGet("/", () => "Hello world!");

app.Run();
```

## Health check pattern

```csharp
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.Extensions.Diagnostics.HealthChecks;

public static class HealthCheckEndpoints
{
    public static IEndpointRouteBuilder MapHealthCheckEndpoints(this IEndpointRouteBuilder app)
    {
        app.MapHealthChecks("/health");
        app.MapHealthChecks("/healthz");

        return app;
    }
}
```

```csharp
builder.Services
    .AddHealthChecks()
    .AddCheck("sample", () => HealthCheckResult.Healthy("Sample health check passed."));
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
    <PackageVersion Include="Scalar.AspNetCore" Version="2.x" />
  </ItemGroup>
</Project>
```
