---
name: standard-documentation
description: "Use when creating, updating, or reviewing project documentation, including READMEs, guides, reference pages, examples, and API documentation."
---

# Standard Documentation

## Purpose

Write documentation that is accurate, easy to navigate, and consistent with the project.

## Invocation Notice

At the start of the first user-facing update where this skill is applied, say: `I'm using standard-documentation`.

## When to use

- Creating, updating, or reviewing project documentation.
- Working on READMEs, guides, reference pages, examples, or API documentation.

## When not to use

- Requests to implement product behavior without a documentation task.
- Documentation changes that depend on an unresolved product decision; clarify before documenting an assumption.

## Workflow

1. Inspect the relevant implementation, existing documentation, and repository guidance. Identify the audience and the purpose of the requested documentation.
2. Confirm technical details from source code or existing authoritative references. Do not guess at behavior, defaults, prerequisites, commands, or supported options.
3. Make the smallest complete change that answers the documentation request. Follow the repository's terminology, Markdown style, heading structure, and link conventions.
4. Use concise, direct language. Include examples or step-by-step instructions when they help the reader complete a task; ensure examples match the actual implementation.
5. Check links, code fences, paths, and cross-references affected by the change. Run documentation-specific checks if the repository provides them.
6. Keep unrelated cleanup out of the change. If the request depends on an unresolved product decision, ask before documenting an assumption.

## Decision rules

- Lead with what the reader needs to know or do.
- Prefer descriptive headings and meaningful link text.
- Explain prerequisites and expected outcomes for procedural instructions.
- Keep examples minimal, runnable where appropriate, and free of secrets or real sensitive data.
- Preserve existing content that remains correct; update stale statements when they are directly related to the requested change.
- State clearly when validation was not available or was not performed.

## Examples

**Input:** Update a README with the current setup steps and supported commands.

**Expected result:** Verify each documented detail against implementation or authoritative project references, make a focused edit in the repository's Markdown style, and report which affected links or commands were checked.

## Verification

Summarize what documentation changed and the exact validation performed. Do not claim examples, commands, or links were verified unless they were checked.
