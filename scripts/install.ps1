[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [Parameter(Mandatory = $true)]
    [string]$WorkspacePath,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$workspaceItem = Get-Item -LiteralPath $WorkspacePath
if (-not $workspaceItem.PSIsContainer) {
    throw "WorkspacePath must be an existing directory: $WorkspacePath"
}

$workspace = $workspaceItem.FullName
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$pluginDirectories = @(Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'plugins') -Directory)

$agents = @(
    foreach ($pluginDirectory in $pluginDirectories) {
        $agentDirectory = Join-Path $pluginDirectory.FullName 'agents'
        if (Test-Path -LiteralPath $agentDirectory -PathType Container) {
            Get-ChildItem -LiteralPath $agentDirectory -File -Filter '*.agent.md'
        }
    }
)

$skills = @(
    foreach ($pluginDirectory in $pluginDirectories) {
        $skillsDirectory = Join-Path $pluginDirectory.FullName 'skills'
        if (Test-Path -LiteralPath $skillsDirectory -PathType Container) {
            Get-ChildItem -LiteralPath $skillsDirectory -Directory | Where-Object {
                Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf
            }
        }
    }
)

if ($agents.Count -eq 0 -or $skills.Count -eq 0) {
    throw 'The repository must contain at least one agent and one skill to install.'
}

$agentDestination = Join-Path $workspace '.github\agents'
$skillDestination = Join-Path $workspace '.github\skills'
$conflicts = @(
    foreach ($agent in $agents) {
        $target = Join-Path $agentDestination $agent.Name
        if (Test-Path -LiteralPath $target) {
            $target
        }
    }
    foreach ($skill in $skills) {
        $target = Join-Path $skillDestination $skill.Name
        if (Test-Path -LiteralPath $target) {
            $target
        }
    }
)

if ($conflicts.Count -gt 0 -and -not $Force) {
    $conflictList = $conflicts -join [Environment]::NewLine
    throw "Existing customizations would be overwritten. Review them, then rerun with -Force to update these items:`n$conflictList"
}

$installedAgentCount = 0
$installedSkillCount = 0

foreach ($agent in $agents) {
    $target = Join-Path $agentDestination $agent.Name
    if ($PSCmdlet.ShouldProcess($target, "Install agent '$($agent.BaseName)'")) {
        New-Item -ItemType Directory -Path $agentDestination -Force | Out-Null
        Copy-Item -LiteralPath $agent.FullName -Destination $target -Force:$Force
        $installedAgentCount++
    }
}

foreach ($skill in $skills) {
    $target = Join-Path $skillDestination $skill.Name
    if ($PSCmdlet.ShouldProcess($target, "Install skill '$($skill.Name)'")) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Get-ChildItem -LiteralPath $skill.FullName -Force |
            Copy-Item -Destination $target -Recurse -Force:$Force
        $installedSkillCount++
    }
}

if ($installedAgentCount -eq 0 -and $installedSkillCount -eq 0) {
    Write-Host "No files were installed into $workspace."
}
else {
    Write-Host "Installed $installedAgentCount agent(s) and $installedSkillCount skill(s) into $workspace\.github"
}
