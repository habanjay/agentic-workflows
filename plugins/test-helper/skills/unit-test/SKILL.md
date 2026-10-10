---
name: unit-test
description: "Use when creating, improving, or troubleshooting unit tests for application code. Inspect the existing test framework and conventions, cover meaningful behavior and edge cases, and run the narrowest relevant tests."
---

# Unit Test

## Purpose

Write unit tests that make behavior clear, detect realistic regressions, and remain consistent with the repository's existing test suite.

## Invocation Notice

At the start of the first user-facing update where this skill is applied, say: `I'm using unit-test`.

## When to use

- Creating or improving unit tests for application code.
- Troubleshooting unit-test failures or coverage gaps.

## When not to use

- Requests only to run an existing test suite without creating, improving, or troubleshooting tests.
- Requests primarily about implementing application behavior rather than testing it.

## Workflow

1. Inspect the code under test, related tests, project files, and repository guidance. Identify the language, test framework, assertion library, naming conventions, and relevant test command.
2. Define the behavior to verify from the request and implementation. Prefer observable outcomes over private implementation details.
3. Cover the normal case and the most meaningful boundary, invalid-input, or failure cases for the requested behavior. Avoid redundant cases and unrelated test cleanup.
4. Use existing fixtures, builders, mocks, and test utilities when appropriate. Keep each test focused and deterministic; avoid real network, clock, filesystem, or shared-state dependencies unless that behavior is specifically under test.
5. Make test-only changes by default. Change production code only when the user requests implementation work or a minimal fix is necessary to make the intended behavior testable; explain that choice.
6. Run the narrowest relevant test command. If it fails, distinguish a test assertion failure from build, restore, environment, or unrelated suite failures before proposing changes.

## Decision rules

- Prefer observable behavior over private implementation details.
- Keep tests focused, deterministic, and consistent with existing test conventions.
- Make test-only changes by default; explain any production-code change.
- Avoid redundant cases and unrelated cleanup.

## Examples

**Input:** Add unit tests for a parser that accepts valid input and rejects malformed input.

**Expected result:** Inspect the parser and the existing test conventions, add focused tests for valid and meaningful invalid cases, then run the narrowest relevant test command.

## Verification

- Run the narrowest relevant test command and report its exact result.
- Summarize behavior covered and files changed. State clearly when tests were not run or could not complete.