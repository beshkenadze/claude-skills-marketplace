---
name: dev-workflow
description: Orchestrates full development workflow with git worktrees and Codex CLI code review. Use when implementing features across issues, starting structured development, or when user mentions "workflow", "implement issues", or needs PR-based development with code review.
---

# Development Workflow

Complete workflow: Issue → Branch → Worktree → Implement → Test → Codex Review → PR → Merge → Close

## Prerequisites

1. Git repository initialized
2. Issue tracker MCP available (Gitea: `mcp__gitea__*`, GitHub: `mcp__github__*`)
3. Codex CLI installed (`codex --version`)
4. Repository owner/name confirmed

## Workflow Steps

### 1. Get Issue Details

**Gitea MCP:**
```
mcp__gitea__get_issue_by_index(owner, repo, index)
```

**GitHub MCP:**
```
mcp__MCP_DOCKER__get_issue(owner, repo, issue_number)
```

**GitHub CLI:**
```bash
gh issue view {issue_number} --repo {owner}/{repo}
```

### 2. Create Branch
```bash
git checkout main && git pull origin main
git checkout -b feature/{issue-number}-{slug}
```

### 3. Create Worktree
```bash
git worktree add ../worktrees/feature-{issue}-{slug} feature/{issue}-{slug}
```

Copy vendor dependencies if present:
```bash
cp -R Vendor ../worktrees/feature-{slug}/
```

### 4. Implement Feature
Work in worktree. For complex tasks, use Task tool with sub-agents.

### 5. Write Integration Tests
Add tests for new functionality. See [TESTING.md](TESTING.md) for testing patterns.

### 6. Run Tests
Project-specific test command (e.g., `xcodebuild test`, `npm test`).

### 7. Codex Code Review

Run **exactly once** per review cycle:
```bash
codex review --base main
```

**IMPORTANT:** Wait for the full output. Do NOT run a second review unless you've made code changes to fix issues.

**If P1/P2 issues found:**
1. Fix all issues in code
2. Commit fixes
3. THEN run `codex review --base main` again (this is a new review cycle)

**If no P1/P2 issues:** Proceed to commit.

See [CODEX.md](CODEX.md) for handling specific findings.

### 8. Commit & Push
```bash
git add . && git commit -m "feat(scope): description"
git push -u origin feature/{issue}-{slug}
```

### 9. Create Pull Request

**Gitea MCP:**
```
mcp__gitea__create_pull_request(owner, repo, title, body, head, base="main")
```

**GitHub MCP:**
```
mcp__MCP_DOCKER__create_pull_request(owner, repo, title, body, head, base)
```

**GitHub CLI:**
```bash
gh pr create --title "title" --body "body" --base main --head feature/{issue}-{slug}
```

### 10. Merge to Main
```bash
git checkout main && git pull origin main
git merge feature/{issue}-{slug} --no-ff && git push origin main
```

### 11. Close Issue

**Gitea MCP:**
```
mcp__gitea__edit_issue(owner, repo, index, state="closed")
```

**GitHub MCP:**
```
mcp__MCP_DOCKER__update_issue(owner, repo, issue_number, state="closed")
```

**GitHub CLI:**
```bash
gh issue close {issue_number} --repo {owner}/{repo}
```

### 12. Cleanup
```bash
git worktree remove ../worktrees/feature-{issue}-{slug}
git branch -d feature/{issue}-{slug}
```

## Parallel Workflow

For multiple independent issues, see [PARALLEL.md](PARALLEL.md).

## Error Recovery

See [ERRORS.md](ERRORS.md) for handling build failures, Codex P1 issues, and merge conflicts.

## Output Format

After completion, report:
- Issues processed
- PRs created/merged
- Issues closed
- Blockers (if any)
