---
name: scaffold-api
description: Internal sub-skill for scaffold. Use only when scaffold routes a request to create an API project or add an API service; choose the framework from user requirements and repository evidence.
user-invocable: false
disable-model-invocation: true
---

# Scaffold API

Build an API scaffold that is runnable, testable, and consistent with the selected framework and repository.

## Invocation Notice

When this sub-skill is applied, tell the user: `I'm using scaffold-api`. If it was selected by `scaffold`, include the notice in the next user-facing update before following this workflow.

## Workflow

1. Identify the language, framework, API style, target runtime, and repository location from the request and existing files. Ask about only the unresolved choices that change the result.
2. Prefer the framework's official project generator or templates when suitable. Check available SDKs and template options before selecting commands.
3. Generate the API in the requested location. Preserve existing files and avoid overwriting user changes; inspect any destination conflicts before proceeding.
4. Include only the requested baseline concerns. When appropriate, use the framework's established patterns for routing, request validation, error responses, configuration, and dependency injection.
5. Add or retain a focused health or smoke check and a minimal test project only when requested or conventional for the repository.
6. Validate with the narrowest available project parse, build, or test command. Be explicit about restore, network, or SDK failures.

## Output

Report the project path, framework and API style chosen, generated entry points, commands run, and validation result. Do not describe optional production features as implemented unless they were actually added.