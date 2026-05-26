---
name: before-you-build
description: Review product and feature risk before implementation. Use when the user wants to build a SaaS, AI app, side project, startup idea, or feature and asks whether to start coding, add a requested feature, or sanity-check requirements before development.
version: 1.0.0
---

# Before You Build

## Overview

Run a short reality check before Claude starts implementation. The goal is to avoid
building the wrong thing faster.

Use this skill to challenge demand, distribution, pricing, retention, trust, and
workflow assumptions before writing code or producing technical plans.

## Instructions

When this skill is active:

1. Do not write code.
2. Do not recommend a tech stack.
3. Do not design implementation details.
4. First review whether the product or feature should be built now.

If the idea is too broad, ask the user to complete this sentence:

```text
This tool is for [specific people], in [specific situation], to solve [specific problem].
```

If the idea is specific enough, produce a short review:

```markdown
## Quick Reality Check

What you want to build:
- [Restate the idea.]

Biggest risk:
- [Name the single most important risk.]

Most likely failure patterns:
- [Pattern 1]
- [Pattern 2]

Validate before building:
1. [Small validation step]
2. [Small validation step]
3. [Small validation step]

Recommendation:
[Build small / Validate first / Pivot first / Don't build yet]
```

## What To Check

- Who the user is and when they would use it
- What they currently do instead
- Whether demand evidence is strong or weak
- How the product would reach users
- Whether users would pay or only try it once
- Why users would come back
- Whether trust or workflow friction blocks adoption
- Whether a feature request reflects repeated demand or one user's edge case

## Common Failure Patterns

- Thin AI wrapper
- Weak willingness to pay
- Low-frequency use
- Free alternative is good enough
- Platform dependency
- Tool without workflow
- User request trap
- Premature team or permissions complexity
- Trust gap

## Verdict Guide

- **Build small**: the user, use case, pain, and validation path are clear enough
  for a small test.
- **Validate first**: the idea may be promising, but the riskiest assumption is
  still untested.
- **Pivot first**: the target user, use case, or positioning is probably wrong.
- **Don't build yet**: the idea is too vague, too crowded, or missing a real
  user/problem.

## Example

**Input:**

```text
I want to build an AI tool that generates a complete MVP from a product idea.
```

**Output:**

```markdown
## Quick Reality Check

What you want to build:
- An AI tool that turns a product idea into a complete MVP.

Biggest risk:
- The user may not need more building speed. They may need sharper idea selection
  before building.

Most likely failure patterns:
- Thin AI wrapper
- Tool without workflow
- Weak willingness to pay

Validate before building:
1. Find 10 recent examples where builders abandoned AI-generated MVPs.
2. Interview 5 builders about what stopped their last project.
3. Test whether they want a risk review before code, not another code generator.

Recommendation:
Validate first.
```

## Source

Full package: https://github.com/bin1874/before-you-build-skill
