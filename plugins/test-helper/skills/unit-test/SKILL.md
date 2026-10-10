---
name: unit-test
description: Use when creating, improving, or troubleshooting unit tests for application code. Inspect the existing test framework and conventions, cover meaningful behavior and edge cases, and run the narrowest relevant tests.
---

# Unit Test

Write tests that make behavior clear, detect realistic regressions, and remain consistent with the repository's existing test suite.

## Invocation Notice

At the start of the first user-facing update where this skill is applied, say: `I'm using unit-test`.

## Workflow

1. Inspect the code under test, related tests, project files, and repository guidance. Identify the language, test framework, assertion library, naming conventions, and relevant test command.
2. Define the behavior to verify from the request and implementation. Prefer observable outcomes over private implementation details.
3. Cover the normal case and the most meaningful boundary, invalid-input, or failure cases for the requested behavior. Avoid redundant cases and unrelated test cleanup.
4. Use existing fixtures, builders, mocks, and test utilities when appropriate. Keep each test focused and deterministic; avoid real network, clock, filesystem, or shared-state dependencies unless that behavior is specifically under test.
5. Make test-only changes by default. Change production code only when the user requests implementation work or a minimal fix is necessary to make the intended behavior testable; explain that choice.
6. Run the narrowest relevant test command. If it fails, distinguish a test assertion failure from build, restore, environment, or unrelated suite failures before proposing changes.

## Completion

Summarize the behavior covered, files changed, and the exact validation result. State clearly when tests were not run or could not complete.