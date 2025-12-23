# Research Report: Claude/Codex Skills Best Practices Guide

**Date:** 2025-12-23
**Depth:** Standard
**Confidence:** High

## Executive Summary

Skills are reusable instruction bundles that AI agents (Claude Code, Codex CLI) automatically discover and apply based on context. Unlike slash commands (user-invoked), skills are **model-invoked**—the agent decides when to use them based on the description and task at hand. This guide covers structure, writing best practices, and common patterns for both Claude Code and Codex CLI skills.

---

## Part 1: Skill Fundamentals

### What Are Skills?

| Feature | Slash Command | Skill |
|---------|---------------|-------|
| Invocation | User types `/command` | Model auto-applies |
| Trigger | Explicit | Based on description |
| Structure | Single `.md` file | Directory with SKILL.md + resources |
| Use case | Repeatable workflows | Context-aware capabilities |

### When to Create Skills

**Create a skill when:**
- Enforcing consistent workflows across sessions
- Providing reusable patterns with reference files
- Automating recurring analysis or code tasks
- Standardizing team processes

**Don't create a skill for:**
- One-off prompts or exploratory tasks
- Simple, single-step operations
- Tasks better suited for CLAUDE.md conventions

---

## Part 2: Skill Structure

### Directory Layout

```
skill-name/
├── SKILL.md              # Required: metadata + instructions
├── reference/            # Optional: documentation
│   ├── patterns.md
│   └── examples.md
├── scripts/              # Optional: executable helpers
│   └── validate.sh
└── templates/            # Optional: scaffolds
    └── component.tsx
```

### SKILL.md Format

```yaml
---
name: skill-name
description: Clear description of WHEN to use this skill and WHAT it does
version: 1.0.0
---

# Skill Name

## Overview
Brief purpose statement (1-2 sentences)

## Instructions
Step-by-step guidance for the agent

### Step 1: [Action]
- Bullet points for clarity
- Use imperative language

### Step 2: [Action]
...

## Examples

### Example: [Use Case Name]

**Input:**
[Example user request or trigger]

**Output:**
[Expected response or action]

## Guidelines

### Do
- Specific positive behaviors

### Don't
- Specific behaviors to avoid
```

### Frontmatter Requirements

| Field | Claude Code | Codex CLI | Notes |
|-------|-------------|-----------|-------|
| `name` | Required | Required (≤100 chars) | Lowercase, hyphens |
| `description` | Required | Required (≤500 chars) | **Critical for triggering** |
| `version` | Optional | Optional | Semantic versioning |
| `allowed-tools` | Optional | N/A | Tool restrictions |

---

## Part 3: Writing Effective Descriptions

The description is **the most important field**—it determines when the agent invokes your skill.

### Good Description Patterns

```yaml
# Pattern 1: Action + Context
description: Review code for security vulnerabilities and OWASP top 10 issues. Use when asked to audit code security or find vulnerabilities.

# Pattern 2: Trigger Phrases
description: Create git commits with conventional format. Use when user says "commit", "create commit", or asks to save changes.

# Pattern 3: Technology + Task
description: Develop SwiftUI views following Apple HIG. Use when writing iOS/macOS UI code or managing SwiftUI state.
```

### Bad Descriptions (Avoid)

```yaml
# Too vague - won't trigger correctly
description: Helps with coding

# Too narrow - misses valid triggers
description: Only use when user types exactly "review my python code"

# Missing trigger conditions
description: A skill for documentation
```

### Description Checklist

- [ ] States WHAT the skill does
- [ ] Explains WHEN to use it (trigger conditions)
- [ ] Includes relevant keywords
- [ ] Under 500 characters (Codex) / 1024 (Claude)
- [ ] No redundant phrases ("This skill...")

---

## Part 4: Writing Instructions

### Core Principles

1. **Assume no context** - Write as if the agent knows nothing beyond input
2. **Use imperative language** - "Check...", "Verify...", "Create..."
3. **Break into steps** - Numbered or headed sections
4. **Be specific, not rigid** - Guide behavior without brittle rules

### Instruction Altitude

Find the "Goldilocks zone" between:
- **Too rigid**: Hardcoded logic that breaks on edge cases
- **Too vague**: Abstract guidance without concrete direction

```markdown
# TOO RIGID (avoid)
If the file ends in .py, run `ruff check`. If .ts, run `eslint`.
If .go, run `golangci-lint`. If .rs, run `clippy`...

# TOO VAGUE (avoid)
Check the code for issues.

# JUST RIGHT
Identify the project's language and run the appropriate linter:
- Check for existing lint config (pyproject.toml, .eslintrc, etc.)
- Use project's configured linter if present
- Fall back to common defaults (ruff for Python, eslint for TS)
```

### Structured Workflows

For complex skills, use clear phase markers:

```markdown
## Instructions

### Phase 1: Analysis
1. Read the target files
2. Identify patterns and issues
3. Categorize by severity

### Phase 2: Action
1. Apply fixes for critical issues
2. Suggest fixes for warnings
3. Document changes made

### Phase 3: Verification
1. Run tests to confirm fixes
2. Check for regressions
3. Report results
```

---

## Part 5: Examples Section

Examples are "pictures worth a thousand words"—they demonstrate expected behavior better than rules.

### Example Structure

```markdown
## Examples

### Example: [Descriptive Name]

**Input:**
"[Exact user message or context that triggers this]"

**Process:**
1. [What the skill does first]
2. [Second action]
3. [Final action]

**Output:**
[Concrete result - code, text, or action taken]
```

### Example Quality Checklist

- [ ] Shows realistic user input
- [ ] Demonstrates step-by-step processing
- [ ] Includes concrete output (not "generates appropriate response")
- [ ] Covers primary use case
- [ ] Consider adding edge case examples

---

## Part 6: Guidelines Section

### Positive Guidelines (Do)

```markdown
### Do
- Verify file exists before editing
- Include error handling in generated code
- Use project's existing patterns and conventions
- Cite sources when making claims
```

### Negative Guidelines (Don't)

```markdown
### Don't
- Modify files without reading them first
- Add dependencies without checking alternatives
- Make claims about external tools without verification
- Generate code beyond what was requested
```

### Anti-Patterns Table

```markdown
| Don't | Do Instead |
|-------|------------|
| Assume file structure | Check with Glob/LS first |
| Hardcode paths | Use relative paths or discovery |
| Skip error handling | Always handle common failures |
```

---

## Part 7: Supporting Files

### When to Include Reference Files

- **Patterns/conventions**: Code style guides, architecture docs
- **Checklists**: Review criteria, deployment steps
- **Templates**: Scaffolds for common structures
- **Scripts**: Deterministic operations (validation, formatting)

### Reference File Best Practices

```markdown
# reference/patterns.md

## Component Patterns

### Pattern: Container/Presenter
Use when separating data fetching from rendering.

```tsx
// Container
function UserListContainer() {
  const users = useUsers();
  return <UserList users={users} />;
}

// Presenter
function UserList({ users }: Props) {
  return users.map(u => <UserCard key={u.id} {...u} />);
}
```

### When to Use
- Components need data from APIs
- Same data displayed multiple ways
```

### Script Guidelines

- Use scripts for **deterministic** operations only
- Prefer instructions for tasks requiring judgment
- Keep scripts simple and well-documented
- Test scripts independently

---

## Part 8: Platform Differences

### Claude Code

**Locations:**
- Project: `.claude/skills/[name]/SKILL.md`
- User: `~/.claude/skills/[name]/SKILL.md`

**Features:**
- `allowed-tools` field for tool restrictions
- Subagent integration via Task tool
- MCP server prompts as slash commands

### Codex CLI

**Locations:**
- Repo: `.codex/skills/[name]/SKILL.md`
- User: `~/.codex/skills/[name]/SKILL.md`

**Features:**
- `$skill-creator` built-in helper
- `/skills` command for selection
- `$skill-name` mention syntax

### Compatibility Tips

- Use standard YAML frontmatter (both support)
- Keep descriptions under 500 chars (Codex limit)
- Avoid platform-specific tool references in portable skills

---

## Part 9: Testing & Debugging

### Testing Triggers

1. **Explicit test**: Ask agent directly about the skill
2. **Natural test**: Use prompts matching your description
3. **Edge test**: Try near-miss prompts that shouldn't trigger

### Common Issues

| Problem | Likely Cause | Fix |
|---------|--------------|-----|
| Skill doesn't trigger | Description too narrow | Add trigger phrases |
| Wrong skill triggers | Description overlap | Narrow descriptions |
| Inconsistent behavior | Vague instructions | Add concrete steps |
| Skill not found | Wrong location/filename | Check `SKILL.md` exactly |

### Debug Checklist

- [ ] `SKILL.md` filename exact (case-sensitive)
- [ ] File in correct location (project vs user)
- [ ] Valid YAML frontmatter
- [ ] Description under character limit
- [ ] Restarted agent after changes

---

## Part 10: Complete Example

```yaml
---
name: pr-review
description: Review pull requests for code quality, security, and best practices. Use when asked to review a PR, check changes, or audit code before merge.
version: 1.0.0
---

# PR Review

## Overview

Systematic code review for pull requests focusing on correctness, security, performance, and maintainability.

## Instructions

### Step 1: Gather Context
1. Get PR diff using `git diff main...HEAD`
2. Identify changed files and their purpose
3. Check for related tests

### Step 2: Review Categories

**Correctness**
- Logic errors or bugs
- Missing edge case handling
- Incorrect API usage

**Security**
- Input validation
- Authentication/authorization
- Sensitive data exposure

**Performance**
- N+1 queries
- Unnecessary computation
- Memory leaks

**Maintainability**
- Code clarity
- Consistent patterns
- Adequate documentation

### Step 3: Report Findings

Format findings by severity:
- 🔴 **Critical**: Must fix before merge
- 🟡 **Warning**: Should fix, low risk to defer
- 🔵 **Suggestion**: Optional improvement

## Examples

### Example: Review API Endpoint

**Input:**
"Review this PR adding a new user endpoint"

**Process:**
1. Read changed files in `src/api/users.ts`
2. Check input validation on request body
3. Verify authorization middleware
4. Look for SQL injection risks
5. Check test coverage

**Output:**
```markdown
## PR Review: Add User Endpoint

### 🔴 Critical
- **Line 45**: Missing input validation on `email` field
- **Line 67**: SQL query vulnerable to injection

### 🟡 Warning
- **Line 23**: Consider rate limiting on this endpoint

### 🔵 Suggestion
- Add OpenAPI documentation for new endpoint
```

## Guidelines

### Do
- Read ALL changed files before commenting
- Check for related test changes
- Consider backward compatibility
- Provide specific fix suggestions

### Don't
- Nitpick style issues (leave to linters)
- Block on subjective preferences
- Review generated/vendored code
- Miss the forest for the trees
```

---

## Sources

- [Claude Code Customization Guide](https://alexop.dev/posts/claude-code-customization-guide-claudemd-skills-subagents/)
- [Codex CLI Custom Skills](https://developers.openai.com/codex/skills/create-skill)
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering)
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [Codex Settings Collection](https://github.com/feiskyer/codex-settings)

## Confidence Assessment

| Aspect | Confidence | Notes |
|--------|------------|-------|
| Skill structure | High | Consistent across sources |
| Description importance | High | Confirmed by multiple guides |
| Writing best practices | High | Aligned with prompt engineering research |
| Platform differences | Medium | APIs still evolving |
| Testing guidance | Medium | Based on common patterns |
