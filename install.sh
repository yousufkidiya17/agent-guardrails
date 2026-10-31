#!/usr/bin/env bash
# ==============================================================================
# Agent Guardrails & Claude Persona - Automated Unix Installer
# ==============================================================================
set -euo pipefail

GLOBAL_DIR="$HOME/.gemini/config"
WORKSPACE_DIR="${1:-}"

echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;36m   Agent Guardrails Automated Setup     \033[0m"
echo -e "\033[1;36m========================================\033[0m"

# 1. Global Installation
mkdir -p "$GLOBAL_DIR"
cp -f "AGENTS.md" "$GLOBAL_DIR/AGENTS.md"
cp -f "GEMINI.md" "$GLOBAL_DIR/GEMINI.md"
echo -e "\033[0;32m[OK] Global rules installed to $GLOBAL_DIR\033[0m"

# 2. Workspace Installation (if specified)
if [ -n "$WORKSPACE_DIR" ]; then
    if [ -d "$WORKSPACE_DIR" ]; then
        cp -f "AGENTS.md" "$WORKSPACE_DIR/AGENTS.md"
        cp -f "GEMINI.md" "$WORKSPACE_DIR/GEMINI.md"
        cp -f ".gateguard.yml" "$WORKSPACE_DIR/.gateguard.yml"
        echo -e "\033[0;32m[OK] Workspace rules copied to $WORKSPACE_DIR\033[0m"
    else
        echo -e "\033[0;33m[!] Workspace path not found: $WORKSPACE_DIR\033[0m"
    fi
fi

echo -e "\033[1;32mSetup complete! Restart your IDE to apply.\033[0m"
