[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium', DefaultParameterSetName = 'User')]
param(
    [Parameter(Mandatory = $true, ParameterSetName = 'Workspace')]
    [string]$WorkspacePath,

    [Parameter(ParameterSetName = 'User')]
    [switch]$User,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repositoryRoot = if (-not [string]::IsNullOrWhiteSpace($PSScriptRoot)) {
    Split-Path -Parent $PSScriptRoot
}

if (-not $repositoryRoot -or -not (Test-Path -LiteralPath (Join-Path $repositoryRoot 'plugins') -PathType Container)) {
    $repositoryDirectory = Join-Path $env:USERPROFILE 'source\repos'
    $repositoryPath = Join-Path $repositoryDirectory 'agentic-workflows'
    $bootstrapInstaller = Join-Path $repositoryPath 'scripts\install.ps1'

    if (-not (Test-Path -LiteralPath $bootstrapInstaller -PathType Leaf)) {
        if (Test-Path -LiteralPath $repositoryPath) {
            throw "The destination already exists but is not an agentic-workflows checkout: $repositoryPath"
        }

        if (-not $PSCmdlet.ShouldProcess($repositoryPath, 'Clone the agentic-workflows repository')) {
            return
        }

        New-Item -ItemType Directory -Path $repositoryDirectory -Force | Out-Null
        git clone https://github.com/habanjay/agentic-workflows.git $repositoryPath
        if ($LASTEXITCODE -ne 0) {
            throw 'Cloning agentic-workflows failed.'
        }
    }

    & $bootstrapInstaller @PSBoundParameters
    return
}

if ($PSCmdlet.ParameterSetName -eq 'Workspace') {
    $workspaceItem = Get-Item -LiteralPath $WorkspacePath
    if (-not $workspaceItem.PSIsContainer) {
        throw "WorkspacePath must be an existing directory: $WorkspacePath"
    }

    $workspace = $workspaceItem.FullName
    $agentDestinations = @((Join-Path $workspace '.github\agents'))
    $skillDestination = Join-Path $workspace '.github\skills'
    $destinationDescription = "$workspace\.github"
}
else {
    $userProfile = Join-Path $HOME '.copilot'
    $agentDestinations = @(
        (Join-Path $userProfile 'agents')
        (Join-Path $HOME '.github\agents')
    )
    $skillDestination = Join-Path $userProfile 'skills'
    $destinationDescription = "$userProfile and $(Join-Path $HOME '.github')"
}

$overwriteExisting = $Force -or ($PSCmdlet.ParameterSetName -eq 'User')

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

$conflicts = @(
    foreach ($agentDestination in $agentDestinations) {
        foreach ($agent in $agents) {
            $target = Join-Path $agentDestination $agent.Name
            if (Test-Path -LiteralPath $target) {
                $target
            }
        }
    }
    foreach ($skill in $skills) {
        $target = Join-Path $skillDestination $skill.Name
        if (Test-Path -LiteralPath $target) {
            $target
        }
    }
)

if ($conflicts.Count -gt 0 -and -not $overwriteExisting) {
    $conflictList = $conflicts -join [Environment]::NewLine
    throw "Existing customizations would be overwritten. Review them, then rerun with -Force to update these items:`n$conflictList"
}

$installedAgentCount = 0
$installedSkillCount = 0

foreach ($agentDestination in $agentDestinations) {
    foreach ($agent in $agents) {
        $target = Join-Path $agentDestination $agent.Name
        if ($PSCmdlet.ShouldProcess($target, "Install agent '$($agent.BaseName)'")) {
            New-Item -ItemType Directory -Path $agentDestination -Force | Out-Null
            Copy-Item -LiteralPath $agent.FullName -Destination $target -Force:$overwriteExisting
            $installedAgentCount++
        }
    }
}

foreach ($skill in $skills) {
    $target = Join-Path $skillDestination $skill.Name
    if ($PSCmdlet.ShouldProcess($target, "Install skill '$($skill.Name)'")) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Get-ChildItem -LiteralPath $skill.FullName -Force |
            Copy-Item -Destination $target -Recurse -Force:$overwriteExisting
        $installedSkillCount++
    }
}

if ($installedAgentCount -eq 0 -and $installedSkillCount -eq 0) {
    Write-Host "No files were installed into $destinationDescription."
}
else {
    Write-Host "Installed $installedAgentCount agent file(s) and $installedSkillCount skill(s) into $destinationDescription"
}
