# Code Review Guide

## Supported Tools

| Tool | Command | Best For |
|------|---------|----------|
| **Codex CLI** | `codex review --base main` | Detailed P1-P4 priority findings |
| **Gemini CLI** | `gemini -p "/code-review"` | Quick quality analysis |
| **GitHub Copilot** | `gh copilot` (interactive) | Conversational review, requires pushed branch |

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
```

This is a new review cycle. Do NOT run this if:
- You haven't changed any code since the last review
- The previous review is still running
- You're just checking "if it worked"

Only merge when output shows no critical issues.
