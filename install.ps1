<#
.SYNOPSIS
    Automated installer for Agent Guardrails & Claude Persona.
.DESCRIPTION
    Installs AGENTS.md, GEMINI.md, and .gateguard.yml globally to ~/.gemini/config
    and optionally into an active workspace folder.
.PARAMETER WorkspacePath
    Optional path to a target project workspace root.
#>
[CmdletBinding()]
param(
    [string]$WorkspacePath = ""
)

$ErrorActionPreference = "Stop"
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Agent Guardrails Automated Setup     " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. Global Installation
$globalDir = "$env:USERPROFILE\.gemini\config"
if (-not (Test-Path $globalDir)) {
    New-Item -ItemType Directory -Force -Path $globalDir | Out-Null
    Write-Host "[+] Created global directory: $globalDir" -ForegroundColor DarkGray
}

Copy-Item -Path "$PSScriptRoot\AGENTS.md" -Destination "$globalDir\AGENTS.md" -Force
Copy-Item -Path "$PSScriptRoot\GEMINI.md" -Destination "$globalDir\GEMINI.md" -Force
Write-Host "[OK] Global rules successfully installed to $globalDir" -ForegroundColor Green

# 2. Workspace Installation (if specified)
if ($WorkspacePath) {
    if (Test-Path $WorkspacePath) {
        Copy-Item -Path "$PSScriptRoot\AGENTS.md" -Destination "$WorkspacePath\AGENTS.md" -Force
        Copy-Item -Path "$PSScriptRoot\GEMINI.md" -Destination "$WorkspacePath\GEMINI.md" -Force
        Copy-Item -Path "$PSScriptRoot\.gateguard.yml" -Destination "$WorkspacePath\.gateguard.yml" -Force
        Write-Host "[OK] Workspace rules copied to $WorkspacePath" -ForegroundColor Green
    } else {
        Write-Warning "Workspace path does not exist: $WorkspacePath"
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete! Restart Antigravity to activate." -ForegroundColor Green
