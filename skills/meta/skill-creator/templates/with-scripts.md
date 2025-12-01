---
name: {{skill_name}}
description: {{description}}
version: 1.0.0
dependencies:
{{#dependencies}}
  - {{.}}
{{/dependencies}}
---

# {{title}}

## Overview

{{overview}}

## Instructions

{{instructions}}

## Available Scripts

{{#scripts}}
### `scripts/{{name}}`

{{description}}

```bash
{{usage}}
```
{{/scripts}}

## Examples

{{#examples}}
### Example: {{name}}

**Input:**
{{input}}

**Output:**
{{output}}

{{/examples}}

## Guidelines

{{guidelines}}

## Error Handling

{{error_handling}}
