# Skill Creator Reference

## Naming Conventions

### Skill Names

| Rule | Example |
|------|---------|
| Lowercase only | `code-reviewer` not `Code-Reviewer` |
| Hyphens for spaces | `meeting-notes` not `meeting_notes` |
| Max 64 characters | Keep names concise |
| Descriptive | `api-doc-generator` not `adg` |

### Categories

| Category | Use For |
|----------|---------|
| `creative` | Art, design, content creation |
| `development` | Code, debugging, DevOps |
| `enterprise` | Business, communication, workflows |
| `document` | File generation, formatting |
| `meta` | Skills about skills |

## Description Writing

### Good Descriptions

```
"Review Python code for security vulnerabilities, PEP 8 compliance, and performance issues. Use when asked to review, audit, or check Python code."
```

Why it's good:
- Specific capabilities listed
- Clear trigger conditions
- Mentions the technology

### Bad Descriptions

```
"Helps with code"
```

Why it's bad:
- Too vague
- No trigger conditions
- Could apply to anything

## Instruction Patterns

### Sequential Steps

```markdown
## Instructions

1. First, analyze the input
2. Then, identify key elements
3. Next, apply transformations
4. Finally, format and present output
```

### Conditional Logic

```markdown
## Instructions

When the user provides [type A]:
- Do action 1
- Do action 2

When the user provides [type B]:
- Do action 3
- Do action 4
```

### Decision Trees

```markdown
## Instructions

1. Determine the input type:
   - If structured data → use processing path A
   - If unstructured text → use processing path B
   - If mixed content → use hybrid approach
```

## Example Patterns

### Simple Example

```markdown
### Example: Basic Usage

**Input:**
User request

**Output:**
Expected response
```

### Detailed Example

```markdown
### Example: Complex Scenario

**Context:**
Background information about the scenario

**Input:**
```
Actual input content
```

**Processing:**
1. Step taken
2. Step taken

**Output:**
```
Actual output content
```

**Notes:**
Additional explanations
```

## Script Integration

### When to Use Scripts

| Use Scripts For | Use Claude For |
|-----------------|----------------|
| Deterministic operations | Creative tasks |
| Data validation | Analysis |
| File processing | Explanations |
| Calculations | Recommendations |

### Script Template

```python
#!/usr/bin/env python3
"""Brief description of script purpose."""

import argparse
import json
import sys

def main():
    parser = argparse.ArgumentParser(description="Script description")
    parser.add_argument("--input", required=True, help="Input description")
    parser.add_argument("--output", default="json", help="Output format")

    args = parser.parse_args()

    try:
        result = process(args.input)
        print(json.dumps(result, indent=2))
        return 0
    except Exception as e:
        print(json.dumps({"error": str(e)}), file=sys.stderr)
        return 1

if __name__ == "__main__":
    sys.exit(main())
```

## Common Patterns

### Input Validation

```markdown
## Instructions

Before processing:
1. Verify input is not empty
2. Check format matches expected pattern
3. Validate any referenced files exist
4. Report clear errors if validation fails
```

### Output Formatting

```markdown
## Output Format

Always structure output as:

1. **Summary**: Brief overview (2-3 sentences)
2. **Details**: Main content
3. **Next Steps**: Actionable recommendations
```

### Error Handling

```markdown
## Error Handling

If an error occurs:
1. Explain what went wrong clearly
2. Suggest how to fix it
3. Offer alternative approaches if available
```
