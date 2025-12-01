#!/bin/bash
# Claude Skills Marketplace Installer

set -e

REPO_URL="https://git.bshk.app/beshkenadze/claude-skills-marketplace"
INSTALL_DIR="$HOME/.claude/plugins/claude-skills-marketplace"
SKILLS_DIR="$HOME/.claude/skills"

echo "Installing Claude Skills Marketplace..."

# Clone or update repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Updating existing installation..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning repository..."
    mkdir -p "$(dirname "$INSTALL_DIR")"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Create skills directory if needed
mkdir -p "$SKILLS_DIR"

# Symlink all skills
echo "Linking skills..."
for skill_dir in "$INSTALL_DIR"/skills/*/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        if [ ! -e "$SKILLS_DIR/$skill_name" ]; then
            ln -s "$skill_dir" "$SKILLS_DIR/$skill_name"
            echo "  + $skill_name"
        else
            echo "  ~ $skill_name (already exists)"
        fi
    fi
done

echo ""
echo "Installation complete!"
echo "Available skills:"
ls -1 "$SKILLS_DIR"
