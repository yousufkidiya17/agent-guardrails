<#
.SYNOPSIS
    Automated installer for Agent Guardrails & Claude Persona.
.DESCRIPTION
    Safely installs AGENTS.md, GEMINI.md, and .gateguard.yml globally to ~/.gemini/config
    and optionally into an active workspace folder, creating timestamped backups of existing files.
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

# 1. Global Installation
$globalDir = "$env:USERPROFILE\.gemini\config"
if (-not (Test-Path $globalDir)) {
    New-Item -ItemType Directory -Force -Path $globalDir | Out-Null
    Write-Host "[+] Created global directory: $globalDir" -ForegroundColor DarkGray
}

Write-Host "`n[1/2] Installing Global Configuration..." -ForegroundColor Cyan
Backup-And-Copy -SourcePath "$PSScriptRoot\AGENTS.md" -DestinationDir $globalDir
Backup-And-Copy -SourcePath "$PSScriptRoot\GEMINI.md" -DestinationDir $globalDir
Backup-And-Copy -SourcePath "$PSScriptRoot\.gateguard.yml" -DestinationDir $globalDir

# 2. Workspace Installation (if specified)
if ($WorkspacePath) {
    Write-Host "`n[2/2] Installing Workspace Configuration ($WorkspacePath)..." -ForegroundColor Cyan
    if (Test-Path $WorkspacePath) {
        Backup-And-Copy -SourcePath "$PSScriptRoot\AGENTS.md" -DestinationDir $WorkspacePath
        Backup-And-Copy -SourcePath "$PSScriptRoot\GEMINI.md" -DestinationDir $WorkspacePath
        Backup-And-Copy -SourcePath "$PSScriptRoot\.gateguard.yml" -DestinationDir $WorkspacePath
        Write-Host "[OK] Workspace rules copied to $WorkspacePath" -ForegroundColor Green
    } else {
        Write-Warning "Workspace path does not exist: $WorkspacePath"
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Setup Complete! Restart Antigravity to activate." -ForegroundColor Green