<#
.SYNOPSIS
    Automated installer for Agent Guardrails & Claude Opus 3-Stage Lifecycle.
.DESCRIPTION
    Safely installs AGENTS.md, GEMINI.md, .gateguard.yml globally to ~/.gemini/config,
    deploys active prompt & bash hooks to ~/.claude, and optionally sets up target workspaces.
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

function Backup-And-Copy {
    param(
        [string]$SourcePath,
        [string]$DestinationDir
    )
    $fileName = [System.IO.Path]::GetFileName($SourcePath)
    $destFile = Join-Path -Path $DestinationDir -ChildPath $fileName

    if (Test-Path $destFile) {
        $timestamp = (Get-Date).ToString("yyyyMMdd_HHmmss")
        $backupFile = "$destFile.$timestamp.bak"
        Copy-Item -Path $destFile -Destination $backupFile -Force
        Write-Host "  [*] Backed up existing $fileName -> $([System.IO.Path]::GetFileName($backupFile))" -ForegroundColor Yellow
    }

    Copy-Item -Path $SourcePath -Destination $destFile -Force
    Write-Host "  [+] Copied $fileName to $DestinationDir" -ForegroundColor Green
}

# 1. Global Installation (Rules)
$globalDir = "$env:USERPROFILE\.gemini\config"
if (-not (Test-Path $globalDir)) {
    New-Item -ItemType Directory -Force -Path $globalDir | Out-Null
    Write-Host "[+] Created global config directory: $globalDir" -ForegroundColor DarkGray
}

Write-Host "`n[1/3] Installing Global Configuration..." -ForegroundColor Cyan
Backup-And-Copy -SourcePath "$PSScriptRoot\AGENTS.md" -DestinationDir $globalDir
Backup-And-Copy -SourcePath "$PSScriptRoot\GEMINI.md" -DestinationDir $globalDir
Backup-And-Copy -SourcePath "$PSScriptRoot\.gateguard.yml" -DestinationDir $globalDir

# 2. Global Hooks Installation (~/.claude)
$globalClaudeDir = "$env:USERPROFILE\.claude"
if (-not (Test-Path $globalClaudeDir)) {
    New-Item -ItemType Directory -Force -Path $globalClaudeDir | Out-Null
    Write-Host "[+] Created global claude directory: $globalClaudeDir" -ForegroundColor DarkGray
}

Write-Host "`n[2/3] Installing Global Prompt & Bash Hooks..." -ForegroundColor Cyan
if (Test-Path "$PSScriptRoot\hooks") {
    Get-ChildItem -Path "$PSScriptRoot\hooks\*.local.md" | ForEach-Object {
        Backup-And-Copy -SourcePath $_.FullName -DestinationDir $globalClaudeDir
    }
}

# 3. Workspace Installation (if specified)
if ($WorkspacePath) {
    Write-Host "`n[3/3] Installing Workspace Configuration ($WorkspacePath)..." -ForegroundColor Cyan
    if (Test-Path $WorkspacePath) {
        Backup-And-Copy -SourcePath "$PSScriptRoot\AGENTS.md" -DestinationDir $WorkspacePath
        Backup-And-Copy -SourcePath "$PSScriptRoot\GEMINI.md" -DestinationDir $WorkspacePath
        Backup-And-Copy -SourcePath "$PSScriptRoot\.gateguard.yml" -DestinationDir $WorkspacePath

        $workspaceClaudeDir = Join-Path -Path $WorkspacePath -ChildPath ".claude"
        if (-not (Test-Path $workspaceClaudeDir)) {
            New-Item -ItemType Directory -Force -Path $workspaceClaudeDir | Out-Null
        }
        if (Test-Path "$PSScriptRoot\hooks") {
            Get-ChildItem -Path "$PSScriptRoot\hooks\*.local.md" | ForEach-Object {
                Backup-And-Copy -SourcePath $_.FullName -DestinationDir $workspaceClaudeDir
            }
        }
        Write-Host "[OK] Workspace rules and hooks copied to $WorkspacePath" -ForegroundColor Green
    } else {
        Write-Warning "Workspace path does not exist: $WorkspacePath"
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   Agent Guardrails Installed Successfully! " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
