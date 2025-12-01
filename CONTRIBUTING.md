# Contributing to Claude Skills Marketplace

Thank you for your interest in contributing skills to the marketplace!

## How to Submit a Skill

### 1. Fork the Repository

Fork this repository and clone it locally.

### 2. Create Your Skill

Create a new directory under the appropriate category in `skills/`:

```
skills/
├── creative/       # Creative & design skills
├── development/    # Development & technical skills
├── enterprise/     # Enterprise & communication skills
└── document/       # Document generation skills
```

### 3. Skill Structure

Your skill must include at minimum a `SKILL.md` file:

```
skills/category/your-skill/
├── SKILL.md           # Required
├── reference.md       # Optional
├── examples.md        # Optional
├── scripts/           # Optional
└── templates/         # Optional
```

### 4. SKILL.md Requirements

Your `SKILL.md` must include:

```yaml
---
name: your-skill-name
description: Clear description of what this skill does and when to use it
version: 1.0.0
---
```

**Name Requirements:**
- Maximum 64 characters
- Lowercase letters, numbers, and hyphens only
- Must be unique in the marketplace

**Description Requirements:**
- Maximum 1024 characters
- Clearly explain what the skill does
- Include trigger conditions (when Claude should use it)

### 5. Quality Guidelines

- **Clear Instructions**: Provide step-by-step guidance
- **Concrete Examples**: Include input/output examples
- **Focused Scope**: One skill, one purpose
- **Tested**: Verify your skill works as expected

### 6. Submit a Pull Request

1. Commit your changes with a clear message
2. Push to your fork
3. Open a pull request with:
   - Skill name and category
   - Brief description of functionality
   - Example use case

## Code of Conduct

- Be respectful and constructive
- Focus on quality over quantity
- Help others improve their submissions

## Security

**Do NOT include:**
- API keys or secrets
- Hardcoded credentials
- Malicious code
- External network calls without documentation

All submissions are reviewed before merging.

## Questions?

Open an issue if you have questions about:
- Skill structure or requirements
- Appropriate category for your skill
- How to implement specific functionality
