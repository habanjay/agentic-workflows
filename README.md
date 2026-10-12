# Agentic Workflows

This repository contains portable skills and host-specific plugin metadata for
repeatable agentic development workflows. Skills follow the
[Agent Skills](https://agentskills.io) open standard.

## What's Included

| Plugin or skill | Description |
|-----------------|-------------|
| [scaffold-engine](plugins/scaffold-engine/) | Skills for creating project scaffolds, API services, and Terraform configurations. |
| [test-helper](plugins/test-helper/) | A focused unit-testing skill and agent for designing, writing, and validating tests. |
| [standard-documentation](plugins/document-helper/skills/standard-documentation/SKILL.md) | A standalone skill for creating, updating, and reviewing project documentation. |
| [docs-agent](plugins/document-helper/agents/docs-agent.agent.md) | A standalone custom agent for accurate, repository-consistent documentation work. |

The `standard-documentation` skill and `docs-agent` are maintained in the
repository but are not currently listed in the plugin marketplaces.

## Installation

### Install agents and skills in VS Code or Visual Studio

The installer copies the repository's agents and skills into the workspace
locations that GitHub Copilot discovers in both VS Code and Visual Studio.
The target must be an existing project or solution directory.

Requirements:

- **VS Code:** GitHub Copilot Chat with agent mode enabled.
- **Visual Studio Professional:** Visual Studio 2026 version 18.4 or later
  for custom agents; version 18.5 or later is required for agent skills.
  Sign in to GitHub Copilot and use agent mode.

Clone this repository, then run the installer in PowerShell:

```powershell
git clone https://github.com/habanjay/agentic-workflows.git
& ".\agentic-workflows\scripts\install.ps1" -WorkspacePath "C:\path\to\your\project"
```

Run these commands from the directory where you want to clone the repository.
The installer adds `.github/agents/` and `.github/skills/` to the target
workspace. For example, it installs `test-agent.agent.md` to
`<your-project>\.github\agents\test-agent.agent.md` and its `unit-test` skill
to `<your-project>\.github\skills\unit-test\`.

Open the **target project** (the path passed to `-WorkspacePath`) in VS Code or
Visual Studio, then reload the window if it was already open. The installed
agent should appear in Copilot Chat's agent picker; Copilot loads relevant
skills when appropriate. In VS Code, `/skills` lists discovered skills.

If an agent or skill with the same name already exists in the target workspace,
the installer stops and lists the conflicts. Review them, then rerun with
`-Force` to update those matching files. The script does not remove other
customizations or files.

The marketplace plugin installation below is a separate workflow. To install
the GitHub Copilot workspace custom agents in VS Code or Visual Studio, use
the PowerShell installer above.

### 🚀 Plugins - Copilot CLI / Claude Code

1. Launch Copilot CLI or Claude Code.
2. Add this repository as a marketplace:

   ```text
   /plugin marketplace add habanjay/agentic-workflows
   ```

3. Install a plugin:

   ```text
   /plugin install <plugin>@agentic-workflows
   ```

   Available marketplace plugins are `scaffold-engine` and `test-helper`.
4. Restart to load the plugins.
5. View available skills with `/skills` and agents with `/agents`.
6. Update a plugin on demand:

   ```text
   /plugin update <plugin>@agentic-workflows
   ```

### VS Code / VS Code Insiders (Preview)

> [!IMPORTANT]
> VS Code plugin support is a preview feature and subject to change. You may
> need to enable it first.

Add the marketplace to your `settings.json`:

```jsonc
{
  "chat.plugins.enabled": true,
  "chat.plugins.marketplaces": ["habanjay/agentic-workflows"]
}
```

Then type `/plugins` in Copilot Chat or use the `@agentPlugins` filter in
Extensions to browse and install plugins.

### Cursor

This repository includes a
[Cursor plugin marketplace](.cursor-plugin/marketplace.json). For local
development or unpublished changes, import the checkout into Cursor's local
plugins directory:

1. Copy or symlink the checkout to `~/.cursor/plugins/local/agentic-workflows`.
2. Restart Cursor or run **Developer: Reload Window**.

### Codex CLI

The skills follow the [Agent Skills](https://agentskills.io) standard and are
compatible with [OpenAI Codex](https://developers.openai.com/codex/skills).
This repository also includes a Codex marketplace manifest at
[.agents/plugins/marketplace.json](.agents/plugins/marketplace.json).

1. Add the marketplace:

   ```bash
   codex plugin marketplace add habanjay/agentic-workflows
   ```

2. Open the plugin browser with `/plugins`.
3. Browse the `agentic-workflows` marketplace and install a plugin.
4. Update plugins on demand:

   ```bash
   codex plugin marketplace upgrade agentic-workflows
   ```

Codex plugin manifests expose the packaged skills; GitHub Copilot `.agent.md`
custom agents are host-specific and are not installed as native Codex agents.

## Contributing

Use the [skill template](templates/skills.template.md) when adding a skill.
When adding a marketplace plugin, keep its plugin metadata and marketplace
entries consistent across the supported hosts.

## License

See [LICENSE](LICENSE) for details.
