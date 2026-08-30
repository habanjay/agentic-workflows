---
name: dotnet-10-api-scaffold
description: "Use when scaffolding one .NET 10 API project at a time. Ask for the API type and project name, apply progressive disclosure, and only reveal the REST or gRPC workflow that matches the selected stack."
---

# .NET 10 API Project Scaffold

## Goal

Create one clean, production-friendly .NET 10 API project at a time using the correct runtime stack for the chosen project type.

Use progressive disclosure throughout the workflow:
- Ask for the API type first: REST or gRPC.
- Ask for the project name second.
- Reveal only the relevant instructions for the selected stack.
- Keep deeper implementation notes in the `/reference` folder instead of cluttering the main scaffold prompt.

Use this rule consistently:
- If the project is REST, use ASP.NET Core Minimal APIs.
- If the project is gRPC, use ASP.NET Core gRPC.

## Required Behavior

- Use .NET 10 for all projects and test runners.
- Ask for the project type before creating folders or files.
- Ask for the project name before scaffolding the solution or app.
- Keep exactly one application project per scaffold run.
- Prefer `Directory.Packages.props` for Central Package Management.
- Always include generated OpenAPI docs and Scalar UI in development when applicable.
- Keep endpoint registration and health checks separated from `Program.cs` when the app exposes routes or health checks.
- Keep e2e tests in a Node/Playwright project under `tests/e2e` using the Playwright CLI workflow.
- Put deeper implementation details in the `/reference` folder and reference them from the main skill.

## Progressive disclosure flow

### 1. Ask for the API type

Before generating any files, ask:

- What API type do you want to scaffold: REST or gRPC?

Apply the following rules based on the answer:

- REST -> Use the Minimal API workflow.
- gRPC -> Use the gRPC workflow.

Do not reveal both stacks at once. Reveal only the stack relevant to the selected project.

### 2. Ask for the project name

After the project type is known, ask:

- What is the project name?

Use that exact name for:
- solution name
- application project name
- folder name under `src/`
- service namespace or proto naming when applicable

If the user does not provide the required information, stop and ask before continuing.

### 3. Choose the correct implementation path

Use the matching project stack:

- REST stack: Minimal API project using `dotnet new web` and `MapGet`, `AddOpenApi()`, and `MapOpenApi()`
- gRPC stack: gRPC project using `dotnet new grpc`, `.proto` contracts, and JSON transcoding when HTTP/JSON access is needed

## Shared workflow

### 1. Create the solution and SDK pin

- Initialize a single solution at the repo root using the user-provided project name.
- Pin the SDK to .NET 10 via `global.json` if the environment requires it.
- Ensure the solution name matches the project name and is easy to discover.

Example commands:

```bash
dotnet new sln -n MyProject
dotnet new globaljson --sdk-version 10.0.100 --force
```

### 2. Create one application project

Create a single app under `src/` named using the user-supplied project name.

- REST: `dotnet new web -n MyProject -o src/MyProject --framework net10.0`
- gRPC: `dotnet new grpc -n MyGrpcService -o src/MyGrpcService --framework net10.0`

Only create one app project in this run.

### 3. Configure Central Package Management

Create a root `Directory.Packages.props` file with central package management enabled.

Example pattern:

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

For gRPC projects, add the relevant gRPC package versions as needed.

### 4. Create the initial test projects

Create the basic test structure for the single project only:

- `tests/unit`: xUnit unit tests
- `tests/integration`: ASP.NET Core integration tests using `WebApplicationFactory` or equivalent
- `tests/e2e`: Playwright CLI project for browser-based end-to-end checks

Example:

```bash
dotnet new xunit -n unit -o tests/unit --framework net10.0
dotnet new xunit -n integration -o tests/integration --framework net10.0
```

For the e2e project:

```bash
mkdir tests/e2e
cd tests/e2e
npm init -y
npm install -D @playwright/test
npx playwright install --with-deps
```

### 5. Add Docker solution items

- Create a root `Docker/` folder.
- Add a minimal `Dockerfile` or compose assets if needed.
- Keep the container assets separate from the application code so they remain easy to discover and standardize.

### 6. Validate the scaffold

Run the minimum verification steps before claiming the scaffold is complete:

```bash
dotnet restore
dotnet build
dotnet test
npx playwright install --with-deps
npx playwright test
```

## Project-specific details

Use the details in the `/reference` folder for the selected stack. Keep the main skill short and decision-oriented.

- REST details: [reference/rest.md](reference/rest.md)
- gRPC details: [reference/grpc.md](reference/grpc.md)
- Reference index: [reference/README.md](reference/README.md)

## REST workflow details

When the user selects REST:

- Use ASP.NET Core Minimal APIs.
- Use `builder.Services.AddOpenApi();` and `app.MapOpenApi();`.
- Expose Scalar UI in development with `app.MapScalarApiReference();`.
- Keep the UI behind `if (app.Environment.IsDevelopment())`.
- Put health checks in a dedicated endpoint file outside `Program.cs`.
- Use a dedicated `Endpoints/` folder when the app exposes route mappings or health checks.

## gRPC workflow details

When the user selects gRPC:

- Use ASP.NET Core gRPC.
- Include a `.proto` contract and a service implementation.
- If HTTP/JSON access is desired, use gRPC JSON transcoding with `AddJsonTranscoding()`.
- Expose OpenAPI and Scalar UI in development for the transcoded HTTP surface.
- Keep service and startup composition separate and clean.
- Add health checks or readiness checks through a lightweight HTTP endpoint if needed.

## Decision points

- Always ask for the project type before generating folders or files.
- Always ask for the project name before scaffolding the solution or project.
- Only create one application project per scaffold run.
- If the user asks for a second project, do not add it in the same run; instead ask them to start a new scaffold.
- If the project is REST, do not perform gRPC-specific configuration.
- If the project is gRPC, do not use the Minimal API workflow.
- Keep the detailed reference material under `/reference` and reveal only what is relevant to the chosen stack.

## Quality criteria

The scaffold is complete only when all of the following are true:

- The solution uses .NET 10 and builds without warnings that indicate a broken template setup.
- `Directory.Packages.props` exists and central package management is enabled.
- Exactly one application project exists under `src/` for this run.
- The user’s chosen project name is used consistently throughout the scaffold.
- The project matches the selected API type: Minimal API for REST, gRPC for gRPC.
- Generated OpenAPI support is enabled where appropriate.
- Scalar UI is enabled only in development.
- Health checks are isolated from `Program.cs` where a route mapping or sample health check is required.
- Playwright is configured for `tests/e2e` and is executable via CLI.
- Docker solution items exist at the root-level `Docker/` folder.
- A restore/build/test verification pass has been run successfully.

## Example prompts to invoke this skill

```text
Scaffold a .NET 10 REST API project for me. My project name is MyProject. Use the minimal API stack and include generated OpenAPI docs and the Scalar UI in development.
```

```text
Scaffold a .NET 10 gRPC API project for me. My project name is MyGrpcService. Use the gRPC stack and include JSON transcoding plus generated OpenAPI docs and the Scalar UI in development.
```

## Related customizations to create next

- A shared `.github/copilot-instructions.md` file to standardize code style, testing, and PR conventions.
- A .NET-specific instruction file for Minimal API or gRPC conventions.
- A Playwright-specific prompt for writing deterministic end-to-end tests against the generated app.
