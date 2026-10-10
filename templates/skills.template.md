# Agent Skill template

Copy the `SKILL.md` example into a skill directory such as
`.agents/skills/<skill-name>/SKILL.md`. Replace the example values, and make
the directory name match the `name` field. Keep only sections that add useful
task-specific guidance; the body structure below is a starting point, not a
required format.

```text
<skill-name>/
├── SKILL.md                 # Required: metadata and core instructions
├── scripts/                 # Optional: repeatable executable helpers
├── references/              # Optional: detailed material loaded as needed
├── assets/                  # Optional: templates and static resources
└── evals/
    └── evals.json           # Optional: prompts and expected outcomes
```

## `SKILL.md` starter

```markdown
---
name: my-skill
description: "Use this skill when [user intent and task scope], including requests about [specific trigger terms or common phrasing]."
# Optional; include only when relevant:
# license: MIT
# compatibility: Requires [specific runtime, product, packages, or network access].
# metadata:
#   author: example-org
#   version: "1.0"
# allowed-tools: Read Bash(git:*)
---

# <Skill title>

When this skill is invoked, display the message `I'm using <skill name>`,
replacing `<skill name>` with the value of the `name` field.

## Purpose

[In one or two sentences, explain the specialized task this skill enables and
the useful outcome.]

## When to use

- [Concrete in-scope request or trigger]
- [Another in-scope request phrased as users might ask it]

## When not to use

- [A nearby task that should use another workflow or no skill]

## Workflow

1. [First action; include any required inputs or preconditions.]
2. [Next action. Choose a clear default when alternatives exist.]
3. [Produce the requested output and state where it goes.]

## Decision rules

- [Important domain-specific rule, default, or constraint.]
- [Edge case and how to handle it.]

## Examples

**Input:** [Representative user request or input shape]

**Expected result:** [Representative output or observable result]

## Verification

- [How to check the result is correct; prefer objective checks where possible.]

## Resources

- [Reference guide](references/REFERENCE.md) — [When the agent should read it.]
- Run `scripts/validate.py <input>` — [What it checks; list prerequisites.]
```

## Authoring checklist

### Name and frontmatter

- `name` is required, 1–64 characters, lowercase letters, numbers, and single
  hyphens only. Do not start or end with a hyphen or use consecutive hyphens.
- Match `name` exactly to the skill directory name.
- `description` is required, non-empty, and at most 1,024 characters. Describe
  both the skill's capability and when an agent should use it.
- Write the description around user intent, not implementation details. Use
  specific trigger terms and paraphrases; imperative wording such as
  “Use this skill when…” is a useful pattern. Keep it concise and avoid a
  scope so broad that unrelated tasks activate the skill.
- Quote descriptions containing punctuation such as colons to keep YAML valid.
- Optional Agent Skills fields are `license`, `compatibility`, `metadata`, and
  `allowed-tools`. Omit fields that do not apply. `compatibility` is for
  specific environment requirements; `metadata` values should be strings.
- `allowed-tools` is experimental and support varies by agent. Use only tool
  names and syntax supported by the target client; do not assume it is a
  portable capability or permission-control mechanism.
- Client-specific frontmatter (for example, VS Code invocation options) is
  outside the portable Agent Skills specification. Add it only when the
  intended client supports it, and document any compatibility trade-off.

### Instructions and scope

- Base the workflow on real tasks, project artifacts, conventions, and known
  failure cases rather than generic advice.
- Make the skill one coherent unit of work: avoid scopes that are too narrow
  to be useful or broad enough to combine unrelated jobs.
- Give clear, actionable, step-by-step instructions. Be prescriptive for
  fragile steps; allow flexibility where multiple approaches work. State a
  default instead of presenting a long, undecided menu.
- Include only information the agent needs for this specialized task. Prefer
  concise instructions, useful examples, important edge cases, and observable
  outputs over background information the agent already knows.
- Keep `SKILL.md` under 500 lines and about 5,000 tokens where practical.
  Move detailed or conditional material into focused reference files and say
  exactly when to read each one. Use relative paths from the skill directory
  and avoid deep chains of references.

### Tools and scripts

- Name the actual tools or commands required, what each is for, and any
  prerequisites. Do not assume a tool is available in every agent client.
- Bundle a script only when reusable code or a complex command makes execution
  more reliable. Use a short, understandable command for simple one-off work.
- Keep scripts self-contained where practical; document dependencies and
  runtime requirements, pin tool versions when reproducibility matters, and
  provide clear errors and predictable inputs/outputs.
- Reference bundled files with paths relative to the skill root, such as
  `scripts/check.py` or `references/api.md`.

### Evaluate and refine

- Start with 2–3 realistic task cases, each with a prompt and a human-readable
  description of the expected result. Include input files when needed and at
  least one useful edge case as the set grows.
- Run cases with the skill and against a baseline (without it or with the
  previous version). Review actual outputs, refine unclear or unnecessary
  instructions, then rerun.
- For description discovery, test realistic positive and near-miss negative
  prompts. Vary phrasing, explicitness, detail, and user context; a larger set
  can aim for roughly 8–10 examples of each kind.
- Prefer objective assertions for mechanical requirements; use human review
  for qualities that are subjective. Iterate based on misses and false
  activations rather than assuming one successful run proves reliability.

## Optional validation

Use the [skills-ref validator](https://github.com/agentskills/agentskills/tree/main/skills-ref)
when available:

```sh
skills-ref validate .agents/skills/<skill-name>
```

## Official references

- [Agent Skills specification](https://agentskills.io/specification)
- [Quickstart](https://agentskills.io/skill-creation/quickstart)
- [Best practices](https://agentskills.io/skill-creation/best-practices)
- [Optimizing descriptions](https://agentskills.io/skill-creation/optimizing-descriptions)
- [Evaluating skills](https://agentskills.io/skill-creation/evaluating-skills)
- [Using scripts](https://agentskills.io/skill-creation/using-scripts)