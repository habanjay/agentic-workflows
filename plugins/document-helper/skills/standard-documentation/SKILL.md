---
name: standard-documentation
description: Use when creating, updating, or reviewing project documentation, including READMEs, guides, reference pages, examples, and API documentation.
---

# Standard Documentation

Write documentation that is accurate, easy to navigate, and consistent with the project.

## Workflow

1. Inspect the relevant implementation, existing documentation, and repository guidance. Identify the audience and the purpose of the requested documentation.
2. Confirm technical details from source code or existing authoritative references. Do not guess at behavior, defaults, prerequisites, commands, or supported options.
3. Make the smallest complete change that answers the documentation request. Follow the repository's terminology, Markdown style, heading structure, and link conventions.
4. Use concise, direct language. Include examples or step-by-step instructions when they help the reader complete a task; ensure examples match the actual implementation.
5. Check links, code fences, paths, and cross-references affected by the change. Run documentation-specific checks if the repository provides them.
6. Keep unrelated cleanup out of the change. If the request depends on an unresolved product decision, ask before documenting an assumption.

## Standards

- Lead with what the reader needs to know or do.
- Prefer descriptive headings and meaningful link text.
- Explain prerequisites and expected outcomes for procedural instructions.
- Keep examples minimal, runnable where appropriate, and free of secrets or real sensitive data.
- Preserve existing content that remains correct; update stale statements when they are directly related to the requested change.
- State clearly when validation was not available or was not performed.

## Completion

Summarize what documentation changed and the exact validation performed. Do not claim examples, commands, or links were verified unless they were checked.
