# Parallel Workflow for Multiple Issues

When working on multiple independent issues simultaneously.

## Workflow

### 1. Analyze Dependencies
Identify which issues depend on others:
```
Phase 1 (Core) → Must complete first
Phase 2, 3, 4 → Can run in parallel (depend on 1)
Phase 5, 6 → Can run in parallel (depend on 2)
Phase 7 → Depends on all previous
```

### 2. Create All Worktrees
For independent issues, create worktrees upfront:
```bash
git worktree add ../worktrees/feature-74-phase1 feature/74-phase1
git worktree add ../worktrees/feature-75-phase2 feature/75-phase2
git worktree add ../worktrees/feature-76-phase3 feature/76-phase3
```

### 3. Delegate to Sub-Agents
Use Task tool for parallel implementation:
```
Task(subagent_type="typescript-agent", prompt="Implement Phase 2 in worktree...")
Task(subagent_type="typescript-agent", prompt="Implement Phase 3 in worktree...")
```

Run independent tasks in parallel by making multiple Task calls in single message.

### 4. Wait for Results
Use AgentOutputTool to collect results:
```
AgentOutputTool(agentId="...", block=true)
```

### 5. Merge in Dependency Order
1. Merge base issues first
2. Pull main into dependent worktrees
3. Merge dependent issues
4. Continue up the dependency chain

## Example: Audio Pipeline (7 Phases)

```
Execution Order:
├── Phase 1: Core Infrastructure (first)
├── [Parallel] Phase 2, 3, 4 (after Phase 1)
├── [Parallel] Phase 5, 6 (after Phase 2)
└── Phase 7: Integration (last, after all)
```

Merge order: 1 → 2,3,4 → 5,6 → 7

## Tips

- Create TodoWrite entries for each phase
- Mark in_progress only ONE task at a time per agent
- Report completion status after each merge
- Clean up worktrees after successful merge
