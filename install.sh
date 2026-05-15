#!/bin/bash
# Install Claude Permission Modes (Sport & Comfort)
# Run: bash install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Claude Permission Modes..."

# Create directories
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/rules

# Copy command files
cp "$SCRIPT_DIR/commands/sport.md" ~/.claude/commands/sport.md
cp "$SCRIPT_DIR/commands/comfort.md" ~/.claude/commands/comfort.md

# Copy settings files
cp "$SCRIPT_DIR/settings/settings.sport.json" ~/.claude/settings.sport.json
cp "$SCRIPT_DIR/settings/settings.comfort.json" ~/.claude/settings.comfort.json

# Copy rules file
cp "$SCRIPT_DIR/rules/permissions.md" ~/.claude/rules/permissions.md

echo ""
echo "Done. Files installed:"
echo "  ~/.claude/commands/sport.md"
echo "  ~/.claude/commands/comfort.md"
echo "  ~/.claude/settings.sport.json"
echo "  ~/.claude/settings.comfort.json"
echo "  ~/.claude/rules/permissions.md"
echo ""
echo "Open Claude Code and type /sport or /comfort to switch modes."
