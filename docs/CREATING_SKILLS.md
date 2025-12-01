# Creating Claude Skills

This guide provides detailed instructions for creating effective Claude Agent Skills.

## Understanding Skills

Skills are model-invoked packages that Claude loads dynamically when relevant to a user's request. Unlike slash commands (user-invoked), skills are automatically triggered based on their description.

## Skill Architecture

### Progressive Disclosure

Skills use a three-level loading system:

| Level | Content | When Loaded |
|-------|---------|-------------|
| 1 | Metadata (name, description) | Always in system prompt |
| 2 | Full SKILL.md | When Claude determines relevance |
| 3+ | Additional files | Only when referenced |

This keeps context usage minimal while enabling complex skills.

### File Structure

```
my-skill/
├── SKILL.md           # Core instructions (required)
├── reference.md       # Detailed documentation
├── examples.md        # Extended examples
├── forms.md           # Form templates
├── scripts/           # Executable code
│   ├── main.py
│   └── utils.py
├── templates/         # Output templates
└── resources/         # Data files
```

## Writing Effective SKILL.md

### Frontmatter

```yaml
---
name: skill-name
description: Clear, specific description that helps Claude know when to use this skill
version: 1.0.0
dependencies:
  - python>=3.8
  - pandas>=1.5.0
---
```

### Structure

```markdown
# Skill Name

## Overview
Brief description of purpose and capabilities.

## Instructions
Step-by-step guidance for Claude:
1. First step
2. Second step
3. Third step

## Examples
Concrete input/output examples showing expected behavior.

## Guidelines
Constraints, best practices, edge cases.

## Additional Resources
References to other files in the skill directory.
```

## Description Writing Tips

The description is critical - it determines when Claude uses your skill.

**Good descriptions:**
- "Review TypeScript code for security vulnerabilities, performance issues, and best practices"
- "Generate meeting notes with action items from transcripts or recordings"

**Poor descriptions:**
- "Code helper" (too vague)
- "Does stuff with meetings" (unclear trigger)

Include:
- What the skill does
- When to use it (trigger conditions)
- Key capabilities

## Including Scripts

For deterministic operations, include executable scripts:

```python
#!/usr/bin/env python3
"""Script description."""

import argparse
import json

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    args = parser.parse_args()

    result = process(args.input)
    print(json.dumps(result))

if __name__ == "__main__":
    main()
```

Reference in SKILL.md:
```markdown
## Scripts

### `scripts/process.py`
Use for data processing:
\`\`\`bash
python scripts/process.py --input data.json
\`\`\`
```

## Testing Your Skill

1. **Manual testing**: Try various prompts that should trigger your skill
2. **Edge cases**: Test boundary conditions and unusual inputs
3. **Negative testing**: Verify skill doesn't trigger inappropriately

## Common Mistakes

1. **Vague descriptions**: Claude can't determine when to use the skill
2. **Missing examples**: Claude lacks context for expected behavior
3. **Overly broad scope**: One skill trying to do too much
4. **No error handling**: Scripts fail ungracefully
5. **Hardcoded values**: Secrets or environment-specific paths

## Best Practices Summary

- Focus on one specific capability per skill
- Write clear, trigger-focused descriptions
- Include concrete examples with inputs and outputs
- Start simple, add complexity only when needed
- Test incrementally after each change
- Version your skills for tracking changes
