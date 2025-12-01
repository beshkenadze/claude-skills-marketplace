# API Skills Guide

This guide covers using Claude Skills with the Anthropic API.

## Setup

### Required Beta Headers

Skills require specific beta headers in your API client:

```python
from anthropic import Anthropic

client = Anthropic(
    api_key="your-api-key",
    default_headers={
        "anthropic-beta": "code-execution-2025-08-25,files-api-2025-04-14,skills-2025-10-02"
    }
)
```

| Header | Purpose |
|--------|---------|
| `code-execution-2025-08-25` | Enables code execution |
| `files-api-2025-04-14` | Enables file downloads |
| `skills-2025-10-02` | Enables Skills feature |

## Using Built-in Skills

Built-in skills are available without uploading:

- **xlsx** - Excel workbooks with formulas and charts
- **pptx** - PowerPoint presentations
- **pdf** - PDF documents and forms
- **docx** - Word documents

### Example: Generate Excel Report

```python
response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    messages=[
        {
            "role": "user",
            "content": "Create an Excel spreadsheet with Q4 sales data"
        }
    ]
)
```

## Working with Generated Files

Skills return file IDs that must be downloaded via the Files API:

```python
# Download file content
content = client.beta.files.download(file_id="file_abc123...")
with open("output.xlsx", "wb") as f:
    f.write(content.read())

# Get file metadata
info = client.beta.files.retrieve_metadata(file_id="file_abc123...")
print(f"Filename: {info.filename}")
print(f"Size: {info.size_bytes}")

# List all files
files = client.beta.files.list()
for file in files:
    print(f"{file.id}: {file.filename}")

# Delete a file
client.beta.files.delete(file_id="file_abc123...")
```

## Uploading Custom Skills

### Package Structure

Create a ZIP file with your skill directory as root:

```
my-skill.zip
└── my-skill/
    ├── SKILL.md
    ├── scripts/
    │   └── helper.py
    └── templates/
        └── report.html
```

**Important**: The skill folder must be the root of the ZIP, not nested.

### Upload Process

```python
# Upload skill ZIP
with open("my-skill.zip", "rb") as f:
    skill = client.beta.skills.upload(file=f)

print(f"Skill ID: {skill.id}")
print(f"Status: {skill.status}")
```

## Dependencies

**Important**: Runtime package installation is not supported for API Skills.

All dependencies must be pre-installed in the execution container. Available packages include:
- pandas, numpy, matplotlib
- openpyxl (Excel)
- python-pptx (PowerPoint)
- PyPDF2, reportlab (PDF)
- python-docx (Word)

## Container Reuse

For efficiency, reuse containers across multiple operations:

```python
# First call - creates container
response1 = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    messages=[{"role": "user", "content": "Create sales report"}]
)

# Get container ID from response
container_id = response1.container_id

# Subsequent calls - reuse container
response2 = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    container_id=container_id,
    messages=[{"role": "user", "content": "Add charts to the report"}]
)
```

## Error Handling

```python
from anthropic import APIError

try:
    response = client.messages.create(...)
except APIError as e:
    if e.status_code == 400:
        print("Invalid skill configuration")
    elif e.status_code == 429:
        print("Rate limited - retry later")
    else:
        print(f"API error: {e}")
```

## Best Practices

1. **Batch operations** in single conversations when possible
2. **Reuse containers** for related operations
3. **Download files promptly** - they may expire
4. **Handle errors gracefully** in production code
5. **Test skills locally** before API deployment
