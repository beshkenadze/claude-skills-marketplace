# Claude Skills Marketplace

## Adding a New Skill

### Step 1: Create Skill Directory

```bash
mkdir -p skills/{category}/{skill-name}
```

Categories: `creative`, `development`, `document`, `enterprise`, `meta`, `utility`

### Step 2: Create SKILL.md

```yaml
---
name: skill-name
description: Clear description with trigger conditions
version: 1.0.0
---

# Skill Name

## Overview
...

## Instructions
...

## Examples
...

## Guidelines
...
```

### Step 3: Add to marketplace.json

Edit `.claude-plugin/marketplace.json` and add entry to `plugins` array:

```json
{
  "name": "skill-name",
  "description": "Same as SKILL.md description",
  "source": "./skills/{category}/{skill-name}",
  "category": "{category}",
  "version": "1.0.0"
}
```

### Step 4: Commit & Push

```bash
git add skills/{category}/{skill-name}/ .claude-plugin/marketplace.json
git commit -m "feat: add {skill-name} skill"
git push
```

### Step 5: Update Installed Marketplace

```bash
cd ~/.claude/plugins/marketplaces/skills-marketplace && git pull
```

## Naming Conventions

- Skill names: lowercase, hyphens, max 64 chars
- Example: `git-worktree-workflow`, `research-guide`

## Optional: Helper Scripts

For skills with scripts:

```
skills/{category}/{skill-name}/
├── SKILL.md
└── scripts/
    └── helper.sh
```

Scripts should be symlinked, not copied:

```bash
ln -s /path/to/skill/scripts/helper.sh .claude/scripts/helper.sh
```
