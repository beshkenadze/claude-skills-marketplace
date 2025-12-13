---
name: gitea-tea
description: Gitea CLI (tea) for managing issues, pull requests, releases, and repositories. Use when user mentions "tea", "gitea cli", or needs to interact with Gitea from terminal.
version: 1.0.0
---

# Gitea CLI (tea)

Official command-line interface for Gitea. Manage issues, PRs, releases, and repos from terminal.

## Installation

```bash
# macOS
brew install tea

# Linux (binary)
curl -sL https://dl.gitea.io/tea/main/tea-main-linux-amd64 -o tea
chmod +x tea && sudo mv tea /usr/local/bin/

# From source
go install code.gitea.io/tea@latest
```

## Authentication

```bash
# Interactive login (recommended)
tea login add
# Select: Application Token
# Enter Gitea URL and token from User Settings → Applications

# List logins
tea login list

# Set default
tea login default gitea.example.com

# Delete login
tea login delete gitea.example.com

# Verify
tea whoami
```

## Issues

### List Issues
```bash
# Open issues in current repo
tea issues list

# All issues (including closed)
tea issues list --state all

# Filter by milestone
tea issues list --milestone "v1.0.0"

# Filter by assignee and labels
tea issues list --assignee username --label bug,critical

# From specific repo
tea issues list --repo owner/repo --login gitea.com
```

### View Issue
```bash
# View issue with comments
tea issue 42

# Without comments
tea issue 42 --comments=false

# Open in browser
tea open 42
```

### Create Issue
```bash
# Interactive
tea issues create

# With arguments
tea issues create \
  --title "Fix authentication bug" \
  --body "Users cannot login with special characters" \
  --label bug,security \
  --assignee developer1 \
  --milestone "v1.2.0"

# From file
tea issues create \
  --title "Feature request" \
  --body "$(cat feature-request.md)"
```

### Modify Issues
```bash
# Close issue
tea issues close 42

# Reopen issue
tea issues reopen 42

# Edit issue
tea issues edit 42 \
  --title "Updated title" \
  --assignee newdev \
  --add-labels "enhancement"
```

## Pull Requests

### List PRs
```bash
# Open PRs
tea pulls

# Closed PRs
tea pulls --state closed

# Filter by reviewer and labels
tea pulls --reviewer username --label "needs-review"
```

### View PR
```bash
# View PR details
tea pr 15

# Without comments
tea pr 15 --comments=false

# Open in browser
tea open 15
```

### Create PR
```bash
# Interactive
tea pulls create

# With arguments
tea pulls create \
  --title "Implement user authentication" \
  --description "Adds OAuth and JWT support" \
  --base main \
  --head feature/auth \
  --assignee reviewer1,reviewer2 \
  --label "enhancement"

# Description from file
tea pulls create \
  --title "Major refactor" \
  --description "$(cat pr-description.md)"
```

### Checkout PR
```bash
# Checkout PR locally
tea pulls checkout 20

# Custom branch name
tea pulls checkout 20 pr-20-custom-name

# Clean up checked out PRs
tea pulls clean
```

### Review & Merge
```bash
# Approve PR
tea pulls approve 20 --comment "LGTM!"

# Request changes
tea pulls reject 20 --comment "Please add tests"

# Leave comment
tea pulls review 20 \
  --state comment \
  --comment "Consider refactoring this section"

# Merge PR (squash)
tea pulls merge 20 --style squash --message "feat: implement auth"

# Merge PR (rebase)
tea pulls merge 20 --style rebase
```

## Releases

### List Releases
```bash
tea releases list
tea releases list --limit 10
tea releases list --repo owner/project
```

### Create Release
```bash
# Basic release
tea releases create v1.0.0 \
  --title "Version 1.0.0" \
  --note "First stable release"

# From changelog file
tea releases create v1.2.0 \
  --title "Version 1.2.0" \
  --note-file CHANGELOG.md

# Draft release
tea releases create v2.0.0-beta \
  --title "Beta Release" \
  --draft \
  --note "Beta for testing"

# With assets
tea releases create v1.1.0-rc1 \
  --title "Release Candidate 1" \
  --prerelease \
  --asset dist/binary-linux-amd64 \
  --asset dist/binary-darwin-amd64

# Create tag + release
tea releases create v1.3.0 \
  --target main \
  --title "Version 1.3.0" \
  --note "New features"
```

### Edit/Delete Release
```bash
# Update release
tea releases edit v1.0.0 \
  --title "Version 1.0.0 - Updated" \
  --note-file NEW-NOTES.md

# Publish draft
tea releases edit v2.0.0 --draft=false

# Delete release
tea releases delete v0.9.0
tea releases delete v1.0.0-beta --confirm
```

## Labels

```bash
# List labels
tea labels list
tea labels list --repo owner/project

# Create label
tea labels create bug \
  --color "#ff0000" \
  --description "Something isn't working"

tea labels create enhancement \
  --color "0,255,0" \
  --description "New feature"

# Update label
tea labels update bug --color "#cc0000"
tea labels update old-name --name new-name
```

## Milestones

```bash
# List milestones
tea milestones list
tea milestones list --state open

# View milestone issues
tea milestone issues "v1.0.0"

# Create milestone
tea milestones create "v2.0.0" \
  --description "Major version release" \
  --deadline "2024-12-31"
```

## Repositories

```bash
# List repos
tea repos list
tea repos list --org myorg
tea repos list --output yaml

# Search repos
tea repos search "keyword" --login gitea.com

# Clone repo
tea clone owner/repo
```

## Time Tracking

```bash
# List time entries
tea times list
tea times list --issue 42
tea times list --user username
tea times list --from "2024-01-01" --until "2024-12-31"

# Add time
tea times add 42 --time "2h"
tea times add 42 --time "1h30m" --message "Implemented auth logic"

# Delete entry
tea times delete 42 --id 123
```

## Notifications

```bash
# View notifications
tea notifications --mine
```

## Non-Interactive Mode (AI Agents)

**IMPORTANT:** When using tea in AI agent environments (no TTY), avoid interactive prompts:

```bash
# Use --output to disable interactive mode
tea issues --output simple
tea pulls --output json

# Provide ALL required arguments upfront
tea issue create --title "Bug title" --body "Description here"
tea pr create --title "PR title" --head feature-branch --base main

# Use -y or --yes for confirmations
tea pr merge 5 --yes
tea releases delete v0.9.0 --yes

# Set default login to avoid prompts
tea login default <login-name>
```

**Always prefer explicit flags over interactive prompts.**

## Tips

- **Context-aware**: Runs in git repo context, uses remote info automatically
- **Multiple instances**: Use `--login gitea.example.com` for cross-instance ops
- **Output formats**: Use `--output yaml|json|csv|simple` for scripting
- **Shell completions**: `tea shellcompletion bash|zsh|fish`
- **Open in browser**: `tea open 42` opens issue/PR in default browser
- **Non-interactive**: Always use `--output` flag and provide all args

## Common Workflows

### Feature Branch → PR
```bash
git checkout -b feature/new-feature
# ... make changes ...
git add . && git commit -m "feat: add new feature"
git push -u origin feature/new-feature
tea pulls create --title "Add new feature" --base main --head feature/new-feature
```

### Review & Merge PR
```bash
tea pulls checkout 20
# ... review code ...
tea pulls approve 20 --comment "LGTM!"
tea pulls merge 20 --style squash
```

### Create Release with Assets
```bash
git tag v1.0.0
git push origin v1.0.0
tea releases create v1.0.0 \
  --title "v1.0.0" \
  --note-file CHANGELOG.md \
  --asset dist/app-linux \
  --asset dist/app-darwin
```
