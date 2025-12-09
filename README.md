# Claude Skills Marketplace

A marketplace for Claude Agent Skills - organized packages of instructions, scripts, and resources that extend Claude's capabilities.

## What Are Skills?

Agent Skills are directories containing a `SKILL.md` file that packages domain expertise and organizational knowledge for reuse across conversations. They enable Claude to perform specialized tasks by loading instructions, scripts, and resources dynamically.

**Key Characteristics:**
- **Model-invoked**: Claude autonomously decides when to use them based on the description
- **Progressive disclosure**: Only loads content when needed, optimizing token usage
- **Composable**: Multiple focused skills work better together than one comprehensive skill

## Quick Start

### 1. Create Your Skill Directory

```
my-skill/
├── SKILL.md           # Required - core instructions
├── reference.md       # Optional - additional documentation
├── examples.md        # Optional - usage examples
├── scripts/           # Optional - executable code
└── templates/         # Optional - template files
```

### 2. Write Your SKILL.md

```yaml
---
name: your-skill-name
description: Brief description of what this Skill does and when to use it
---

# Your Skill Name

## Instructions
Provide clear, step-by-step guidance for Claude.

## Examples
Show concrete usage examples with inputs and outputs.

## Guidelines
Best practices and constraints.
```

### 3. Install Your Skill

| Location | Scope |
|----------|-------|
| `~/.claude/skills/` | Personal - available across all projects |
| `.claude/skills/` | Project - specific to repository |

## SKILL.md Metadata Reference

| Field | Required | Constraints |
|-------|----------|-------------|
| `name` | Yes | Max 64 chars, lowercase letters, numbers, hyphens only |
| `description` | Yes | Max 1024 chars, explains function and trigger conditions |
| `version` | No | Semantic versioning (e.g., 1.0.0) |
| `dependencies` | No | List of required packages |

## Progressive Disclosure Architecture

Skills implement three levels of information loading:

1. **Level 1 (Metadata)**: Name/description loaded into system prompt at startup
2. **Level 2 (Instructions)**: Full SKILL.md loads when Claude determines relevance
3. **Level 3+ (Resources)**: Additional files load only when referenced

This design keeps context consumption minimal while enabling unbounded skill complexity.

## Best Practices

- **Focus**: Create separate skills for different workflows
- **Clarity**: Write specific descriptions for proper invocation
- **Simplicity**: Start with markdown; add code only when needed
- **Examples**: Include sample inputs and outputs
- **Versioning**: Track changes systematically
- **Incremental Testing**: Test after each significant change
- **Scale Structure**: Split into separate files when SKILL.md grows unwieldy

## Security Considerations

- Install skills only from trusted sources
- Audit bundled files and dependencies
- Never hardcode sensitive information (API keys, passwords)
- Review instructions directing Claude toward external connections

## Repository Structure

```
claude-skills-marketplace/
├── skills/                    # Community skills
│   ├── creative/              # Creative & design skills
│   ├── development/           # Development & technical skills
│   ├── enterprise/            # Enterprise & communication skills
│   └── document/              # Document generation skills
├── templates/                 # Starter templates
│   └── basic/
│       └── SKILL.md
├── docs/                      # Documentation
│   ├── CREATING_SKILLS.md
│   ├── API_SKILLS.md
│   └── SKILLS_BEST_PRACTICES.md
└── CONTRIBUTING.md
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on submitting skills to the marketplace.

## Resources

- [Introducing Agent Skills | Anthropic](https://www.anthropic.com/news/skills)
- [How to create custom Skills | Claude Help Center](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [GitHub - anthropics/skills](https://github.com/anthropics/skills)
- [Equipping agents for the real world | Anthropic Engineering](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

## License

MIT
