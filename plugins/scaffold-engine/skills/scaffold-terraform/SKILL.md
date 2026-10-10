---
name: scaffold-terraform
description: Internal sub-skill for scaffold. Use only when scaffold routes a request to create Terraform configuration or infrastructure-as-code; identify the provider and deployment scope before generating resources.
user-invocable: false
disable-model-invocation: true
---

# Scaffold Terraform

Create a minimal, reviewable Terraform configuration for the provider and infrastructure scope requested by the user.

## Invocation Notice

When this sub-skill is applied, tell the user: `I'm using scaffold-terraform`. If it was selected by `scaffold`, include the notice in the next user-facing update before following this workflow.

## Workflow

1. Inspect the repository for Terraform files, provider conventions, backend configuration, and existing infrastructure. Do not replace or reformat unrelated configuration.
2. Identify the provider, target environment, and requested resources from the prompt and repository. Ask for missing decisions that affect resource selection or deployment; do not invent account IDs, regions, credentials, or resource names.
3. Create the smallest coherent configuration. Use explicit provider constraints and variables for environment-specific values. Keep secrets out of source control.
4. Keep state and backend decisions explicit. Do not configure a remote backend or run commands that create, update, or destroy infrastructure without user direction.
5. Format and validate the configuration with Terraform when available. Prefer `terraform fmt -check` and `terraform validate`; report initialization requirements and unavailable providers accurately.
6. Never run `terraform apply` or `terraform destroy` unless the user explicitly asks for that operation.

## Output

Report the files created, provider and resources selected, required variables, and validation result. Distinguish local validation from any deployment that was not performed.