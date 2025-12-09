# Codex Code Review Guide

## Running Review

```bash
# Review changes against main branch
codex review --base main

# With custom focus
codex review --base main "Focus on thread safety and memory management"

# Review uncommitted changes
codex review --uncommitted
```

## Priority Levels

| Priority | Severity | Action Required |
|----------|----------|-----------------|
| **P1** | Critical | MUST fix before merge |
| **P2** | High | Should fix before merge |
| **P3** | Medium | Fix if time permits |
| **P4** | Low | Consider for future |

## Handling Findings

### P1 Issues (Critical)
1. **Do NOT merge** until resolved
2. Read and understand the issue
3. Implement fix in worktree
4. Commit the fix
5. Re-run `codex review --base main`
6. Verify P1 is resolved
7. Only proceed when no P1 issues remain

### P2 Issues (High)
1. Should fix before merge
2. Follow same process as P1
3. May proceed with caution if fix is complex and risk is understood

### P3/P4 Issues
1. Document for future improvement
2. Create follow-up issue if warranted
3. May proceed with merge

## Common P1 Patterns

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

After fixing all P1/P2 issues:
```bash
codex review --base main
```

Only merge when output shows no critical issues.
