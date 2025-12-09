# Claude Code Skills Best Practices

Based on official Anthropic documentation and community best practices.

## SKILL.md Structure

```yaml
---
name: your-skill-name
description: Brief description of what this Skill does and when to use it.
---

# Your Skill Name

[Instructions that Claude will follow when this skill is active]
```

## Required Fields

| Field | Requirements |
|-------|--------------|
| `name` | Lowercase letters, numbers, hyphens only (max 64 chars) |
| `description` | Max 1024 characters - **critical for discovery** |

## Optional Fields (Claude Code Only)

| Field | Purpose |
|-------|---------|
| `allowed-tools` | Restrict which tools Claude can use (comma-separated) |

## Core Principles

### 1. Concise is Key

The context window is shared. Only add what Claude doesn't already know.

**Good** (~50 tokens):
```markdown
## Extract PDF text
Use pdfplumber:
\`\`\`python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
\`\`\`
```

**Bad** (~150 tokens):
```markdown
PDF files are a common format... There are many libraries...
First install... Then you can use the code below...
```

### 2. Progressive Disclosure

Keep SKILL.md lean (<500 lines). Split detailed content into reference files:

```
my-skill/
├── SKILL.md              # Entry point (overview)
├── REFERENCE.md          # Detailed API docs (loaded when needed)
├── EXAMPLES.md           # Code examples (loaded when needed)
└── scripts/
    └── helper.py         # Utility scripts
```

Claude loads reference files **only when needed**, saving context tokens.

### 3. Effective Descriptions

Include **both** what the skill does AND when to use it:

**Good:**
```yaml
description: Extract text and tables from PDF files, fill forms, merge documents.
Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

**Bad:**
```yaml
description: Helps with documents
```

### 4. Third Person Descriptions

Always write descriptions in third person (injected into system prompt):

- **Good:** "Processes Excel files and generates reports"
- **Bad:** "I can help you process Excel files"
- **Bad:** "You can use this to process Excel files"

## Directory Structure

### Personal Skills
```
~/.claude/skills/my-skill/SKILL.md
```

### Project Skills (shared via git)
```
.claude/skills/my-skill/SKILL.md
```

## Naming Convention

Use **gerund form** (verb + -ing) for skill names:
- `processing-pdfs`
- `analyzing-spreadsheets`
- `managing-databases`
- `testing-code`

## Reference Files Pattern

Keep SKILL.md as overview, link to details:

```markdown
# PDF Processing

## Quick start
[Basic usage here]

## Advanced features
**Form filling**: See [FORMS.md](FORMS.md)
**API reference**: See [REFERENCE.md](REFERENCE.md)
```

## Checklist

### Core Quality
- [ ] Description includes what + when to use
- [ ] SKILL.md body under 500 lines
- [ ] Additional details in separate files
- [ ] Consistent terminology throughout
- [ ] Examples are concrete, not abstract
- [ ] File references one level deep

### Testing
- [ ] Tested with real usage scenarios
- [ ] Works with intended models (Haiku/Sonnet/Opus)

## Sources

- [Skill Authoring Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [GitHub anthropics/skills](https://github.com/anthropics/skills)
- [Agent Skills Overview](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
