---
name: scaffold
description: "Use when creating a new project, application, API, or infrastructure scaffold. Inspect the repository first, identify the requested stack and scope, then route API work to scaffold-api and Terraform work to scaffold-terraform."
---

# Scaffold

## Purpose

Create the smallest useful project structure that meets the request and fits the repository's existing conventions.

## Invocation Notice

At the start of the first user-facing update where this skill is applied, say: `I'm using scaffold`. If you route into a sub-skill, announce that sub-skill by its exact name before following its workflow.

## When to use

- Creating a new project, application, API, or infrastructure scaffold.
- Adding a new service or infrastructure foundation when the request requires a scaffold.

## When not to use

- Making a focused change to an existing project that does not require a new scaffold.
- Requests to create API or Terraform scaffolds without following the corresponding sub-skill.

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

## Decision rules

- Inspect the repository before choosing tools or generating files; preserve existing content and changes.
- Route API scaffolds to [scaffold-api](../scaffold-api/SKILL.md) and Terraform scaffolds to [scaffold-terraform](../scaffold-terraform/SKILL.md).
- Ask only about unresolved choices that materially affect the generated structure.
- Avoid adding frameworks, files, or features outside the requested scope.

## Examples

**Input:** Create a new API project in this repository.

**Expected result:** Inspect repository conventions, announce and follow [scaffold-api](../scaffold-api/SKILL.md), generate the requested API scaffold, then report the selected framework and validation result.

## Verification

- Run the narrowest available validation, such as a template listing, formatter, project parse, build, or test.
- Summarize the created structure, key choices, and validation result. Do not claim a scaffold builds or runs unless the corresponding check succeeded.

## Resources

- [scaffold-api](../scaffold-api/SKILL.md) — API project and service scaffolds.
- [scaffold-terraform](../scaffold-terraform/SKILL.md) — Terraform and infrastructure-as-code scaffolds.