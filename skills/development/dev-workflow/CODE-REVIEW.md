# Code Review Guide

## Context for Review

**Before running code review, provide context documents** to help the reviewer understand intent:

| Document | Purpose | Location |
|----------|---------|----------|
| **SPEC.md** | Requirements, acceptance criteria | Project root or `docs/` |
| **DESIGN.md** | Architecture, data flow, API contracts | Project root or `docs/` |
| **Issue description** | User story, bug report | Issue tracker |

### Providing Context to Review Tools

```bash
# Codex - reference spec in focus prompt
codex review --base main "Review against SPEC.md requirements"

# Gemini - include context in prompt
gemini -p "Read SPEC.md and DESIGN.md first, then /code-review"

# OpenCode - reference docs in prompt
opencode -p "Review changes against SPEC.md requirements and DESIGN.md architecture"
```

### Minimum Context Checklist

Before review, ensure reviewer has access to:
- [ ] **What**: Feature/bug description from issue
- [ ] **Why**: Business requirement or user need
- [ ] **How**: Expected behavior and edge cases
- [ ] **Constraints**: Performance, security, compatibility requirements

## Supported Tools

| Tool | Command | Best For |
|------|---------|----------|
| **Codex CLI** | `codex review --base main` | Detailed P1-P4 priority findings |
| **Gemini CLI** | `gemini -p "/code-review"` | Quick quality analysis |
| **GitHub Copilot** | `gh copilot` (interactive) | Conversational review, requires pushed branch |
| **OpenCode** | `opencode -p "review changes"` | Provider-agnostic, works with any LLM |

**Ask user preference** before running review if not specified.

## Running Review

**Run exactly ONCE per review cycle.** Do not run multiple reviews without code changes between them.

### Codex CLI
```bash
# Review changes against main branch
codex review --base main

# With custom focus
codex review --base main "Focus on thread safety and memory management"

# Review uncommitted changes
codex review --uncommitted
```

### Gemini CLI
```bash
# Non-interactive mode (recommended)
gemini -p "/code-review"

# Interactive mode
gemini
# then type: /code-review
```

### GitHub Copilot CLI
```bash
# Interactive mode - ask for code review
gh copilot
# then ask: "review my changes against main branch"

# Or use new copilot CLI (npm package)
npx @github/copilot
# then ask for review
```

**Note:** GitHub Copilot CLI doesn't have a dedicated `review` subcommand. Use conversational prompts like "review my code changes" or "find bugs in my diff". For automated PR reviews, use GitHub web UI or assign Copilot as reviewer on the PR.

### OpenCode (sst/opencode)
```bash
# Non-interactive mode with prompt
opencode -p "review my code changes against main branch, find bugs and issues"

# Interactive mode (TUI)
opencode
# then ask for review

# Using custom command (if configured)
opencode
# then type: /review
```

**Setup custom /review command:** Create `.opencode/command/review.md`:
```markdown
First, read these context documents if they exist:
- SPEC.md or docs/SPEC.md (requirements)
- DESIGN.md or docs/DESIGN.md (architecture)

Then review the code changes against main branch. Check for:
- Compliance with SPEC.md requirements
- Alignment with DESIGN.md architecture
- Bugs and logic errors
- Security vulnerabilities
- Performance issues
- Code style violations

Use `git diff main` to see the changes.
```

**Note:** OpenCode is provider-agnostic - works with Claude, OpenAI, Gemini, or local models. Configure your preferred provider with `opencode auth login`. Built-in commands: `/init`, `/undo`, `/redo`, `/share`, `/help`.

**Recommended: Add context7 MCP** for up-to-date library documentation during review.

Add to `opencode.json`:
```json
{
  "mcp": {
    "context7": {
      "type": "local",
      "command": ["npx", "-y", "@upstash/context7-mcp"],
      "enabled": true
    }
  }
}
```

Or use remote endpoint (no local install):
```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "enabled": true
    }
  }
}
```

Then reference in review prompts: `"use context7 to check API usage against latest docs"`

**Wait for full output** before proceeding. The review is complete when you see the summary.

## Priority Levels

| Priority | Severity | Action Required |
|----------|----------|-----------------|
| **P1** / Critical | Critical | MUST fix before merge |
| **P2** / High | High | Should fix before merge |
| **P3** / Medium | Medium | Fix if time permits |
| **P4** / Low | Low | Consider for future |

## Handling Findings

### Critical Issues (P1)
1. **Do NOT merge** until resolved
2. Read and understand the issue
3. Implement fix in worktree
4. Commit the fix
5. Re-run review (see Re-verification below)
6. Verify issue is resolved
7. Only proceed when no critical issues remain

### High Issues (P2)
1. Should fix before merge
2. Follow same process as P1
3. May proceed with caution if fix is complex and risk is understood

### Medium/Low Issues (P3/P4)
1. Document for future improvement
2. Create follow-up issue if warranted
3. May proceed with merge

## Common Critical Patterns

### Thread Safety
- NSLock held across `await` calls
- Shared mutable state without synchronization
- Data races in concurrent code

**Fix pattern**: Release lock before await, use local references:
```swift
lock.lock()
let localRef = sharedResource
lock.unlock()
// Now safe to await
try await localRef.doWork()
```

### Memory Management
- Retain cycles in closures
- Missing `[weak self]` in async callbacks
- Unbounded buffer growth

### Security
- Unvalidated input
- SQL/Command injection
- Hardcoded credentials

## Re-verification

**Only after you've made code changes** to fix issues:

```bash
# Codex
codex review --base main

# Gemini
gemini -p "/code-review"

# GitHub Copilot (interactive)
gh copilot  # then ask for review

# OpenCode
opencode -p "review my changes against main"
```

This is a new review cycle. Do NOT run this if:
- You haven't changed any code since the last review
- The previous review is still running
- You're just checking "if it worked"

Only merge when output shows no critical issues.
