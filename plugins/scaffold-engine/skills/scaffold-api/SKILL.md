---
name: scaffold-api
description: "Internal sub-skill for scaffold. Use only when scaffold routes a request to create an API project or add an API service; choose the framework from user requirements and repository evidence."
user-invocable: false
disable-model-invocation: true
---

# Scaffold API

## Purpose

Build an API scaffold that is runnable, testable, and consistent with the selected framework and repository.

## Invocation Notice

When this sub-skill is applied, tell the user: `I'm using scaffold-api`. If it was selected by `scaffold`, include the notice in the next user-facing update before following this workflow.

## When to use

- Only when [scaffold](../scaffold/SKILL.md) routes a request to create an API project or add an API service.

## When not to use

- Direct user requests that have not been routed by `scaffold`; this is an internal sub-skill.
- Requests for a non-API project scaffold or changes unrelated to creating an API project or service.

## Workflow

1. Identify the language, framework, API style, target runtime, and repository location from the request and existing files. Ask about only the unresolved choices that change the result.
2. Prefer the framework's official project generator or templates when suitable. Check available SDKs and template options before selecting commands.
3. Generate the API in the requested location. Preserve existing files and avoid overwriting user changes; inspect any destination conflicts before proceeding.
4. Include only the requested baseline concerns. When appropriate, use the framework's established patterns for routing, request validation, error responses, configuration, and dependency injection.
5. Add or retain a focused health or smoke check and a minimal test project only when requested or conventional for the repository.
6. Validate with the narrowest available project parse, build, or test command. Be explicit about restore, network, or SDK failures.

## Decision rules

- Choose the framework and API style from user requirements and repository evidence; ask only about unresolved choices that affect the result.
- Generate into the requested location, preserve existing files, and avoid overwriting user changes.
- Include only requested baseline concerns. Add a health check or test project only when requested or conventional for the repository.
- Do not claim optional production features were implemented unless they were actually added.

## Examples

**Input:** `scaffold` routes a request to add an API service to an existing repository.

**Expected result:** Inspect the repository and available framework generators, create the requested API service without overwriting existing files, then report the project path and validation result.

## Verification

- Run the narrowest available project parse, build, or test command.
- Report restore, network, or SDK failures accurately.
- Report the project path, framework and API style chosen, generated entry points, commands run, and validation result.

## Resources

- [scaffold](../scaffold/SKILL.md) — parent workflow that routes API scaffolding requests.