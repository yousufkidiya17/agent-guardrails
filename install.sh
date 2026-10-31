#!/usr/bin/env bash
# ==============================================================================
# Agent Guardrails & Claude Persona - Automated Unix Installer
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.gemini/config"
WORKSPACE_DIR="${1:-}"

echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;36m   Agent Guardrails Automated Setup     \033[0m"
echo -e "\033[1;36m========================================\033[0m"

backup_and_copy() {
    local src="$1"
    local dest_dir="$2"
    local filename
    filename="$(basename "$src")"
    local target="$dest_dir/$filename"

    if [ -f "$target" ]; then
        local timestamp
        timestamp="$(date +%Y%m%d_%H%M%S)"
        local backup="${target}.${timestamp}.bak"
        cp -f "$target" "$backup"
        echo -e "  \033[0;33m[*] Backed up existing $filename -> $(basename "$backup")\033[0m"
    fi

    cp -f "$src" "$target"
    echo -e "  \033[0;32m[+] Copied $filename to $dest_dir\033[0m"
}

# 1. Global Installation
mkdir -p "$GLOBAL_DIR"
echo -e "\n\033[1;36m[1/2] Installing Global Configuration...\033[0m"
backup_and_copy "$SCRIPT_DIR/AGENTS.md" "$GLOBAL_DIR"
backup_and_copy "$SCRIPT_DIR/GEMINI.md" "$GLOBAL_DIR"
backup_and_copy "$SCRIPT_DIR/.gateguard.yml" "$GLOBAL_DIR"

# 2. Workspace Installation (if specified)
if [ -n "$WORKSPACE_DIR" ]; then
    echo -e "\n\033[1;36m[2/2] Installing Workspace Configuration ($WORKSPACE_DIR)...\033[0m"
    if [ -d "$WORKSPACE_DIR" ]; then
        backup_and_copy "$SCRIPT_DIR/AGENTS.md" "$WORKSPACE_DIR"
        backup_and_copy "$SCRIPT_DIR/GEMINI.md" "$WORKSPACE_DIR"
        backup_and_copy "$SCRIPT_DIR/.gateguard.yml" "$WORKSPACE_DIR"
        echo -e "\033[0;32m[OK] Workspace rules copied to $WORKSPACE_DIR\033[0m"
    else
        echo -e "\033[0;33m[!] Workspace path not found: $WORKSPACE_DIR\033[0m"
    fi
fi

echo -e "\n\033[1;36m========================================\033[0m"
echo -e "\033[1;32mSetup complete! Restart your IDE to apply.\033[0m"