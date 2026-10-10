---
name: scaffold
description: Use when creating a new project, application, API, or infrastructure scaffold. Inspect the repository first, identify the requested stack and scope, then route API work to scaffold-api and Terraform work to scaffold-terraform.
---

# Scaffold

Create the smallest useful project structure that meets the request and fits the repository's existing conventions.

## Invocation Notice

At the start of the first user-facing update where this skill is applied, say: `I'm using scaffold`. If you route into a sub-skill, announce that sub-skill by its exact name before following its workflow.

## Workflow

1. Inspect the repository and identify existing languages, frameworks, project files, naming patterns, and build or test commands. Do not assume the repository is empty.
2. Clarify only decisions that materially change the generated structure, such as the API framework or Terraform provider. Use explicit user choices and repository evidence when available.
3. Route specialized work by reading the matching skill instructions:
   - For an API project or API service, follow [scaffold-api](../scaffold-api/SKILL.md).
   - For Terraform configuration or infrastructure-as-code, follow [scaffold-terraform](../scaffold-terraform/SKILL.md).
   - For requests spanning both, follow both skills and make their provider, configuration, and output assumptions consistent.
4. For other project scaffolds, use the repository's established tooling and conventions. Avoid adding unrelated frameworks or files.
5. Create or update the requested files, preserving existing user content and changes.
6. Run the narrowest available validation, such as a template listing, formatter, project parse, build, or test. Report anything that could not be validated.

## Completion

Summarize the created structure, key choices, and validation result. Do not claim a scaffold builds or runs unless the corresponding check succeeded.