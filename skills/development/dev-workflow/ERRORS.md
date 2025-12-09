# Error Recovery

Common errors and how to handle them.

## Build Failures

1. Read error output carefully
2. Fix issues in worktree
3. Re-run tests
4. Continue workflow

```bash
# After fixing
xcodebuild test -scheme MyApp ...
# or
npm test
```

## Codex Review P1 Issues

**NEVER merge with P1 issues.**

1. Read the P1 finding
2. Understand the root cause
3. Implement fix in worktree
4. Commit the fix
5. Re-run `codex review --base main`
6. Verify P1 is resolved
7. Only merge when clean

See [CODEX.md](CODEX.md) for detailed P1 handling.

## Merge Conflicts

1. Pull latest main into worktree:
   ```bash
   cd ../worktrees/feature-{issue}-{slug}
   git fetch origin main
   git merge origin/main
   ```

2. Resolve conflicts in affected files

3. Test after resolution:
   ```bash
   # Run tests to verify fix
   ```

4. Commit merge resolution:
   ```bash
   git add .
   git commit -m "Resolve merge conflicts with main"
   ```

5. Continue with PR

## Worktree Issues

### Worktree already exists
```bash
git worktree remove ../worktrees/feature-{slug}
git worktree add ../worktrees/feature-{slug} feature/{issue}-{slug}
```

### Branch already exists
```bash
git branch -D feature/{issue}-{slug}
git checkout -b feature/{issue}-{slug}
```

### Vendor dependencies missing
```bash
cp -R /path/to/main/repo/Vendor ../worktrees/feature-{slug}/
```

## PR Creation Failures

### Branch not pushed
```bash
git push -u origin feature/{issue}-{slug}
```

### Head branch not found
Verify branch name matches exactly between local and remote.

## Issue Close Failures

### Issue already closed
Check issue state first - may have been closed by another PR.

### Permission denied
Verify MCP authentication and repository permissions.
