# Research Report: Python uv Package Manager Skill for Claude

**Date:** 2025-12-23
**Depth:** Standard
**Confidence:** High

## Executive Summary

**uv** is an extremely fast Python package and project manager written in Rust by [Astral](https://astral.sh/). It is 10-100x faster than pip and serves as a unified replacement for pip, pip-tools, pipx, poetry, pyenv, virtualenv, and more. A Claude skill for uv should focus on common workflows, command reference, and best practices for 2024-2025.

## Key Findings

### What is uv?

- **Developer:** Astral (also behind Ruff linter)
- **Language:** Rust (for speed)
- **First release:** February 2024
- **Performance:** 10-100x faster than pip, 80x faster venv creation
- **Maturity:** Stable, widely used in production

### Core Capabilities

| Feature | Description |
|---------|-------------|
| Project management | `uv init`, `uv add`, `uv remove`, `uv sync`, `uv lock` |
| Package installation | `uv pip install`, `uv pip compile` |
| Tool management | `uv tool install`, `uvx` (run tools without install) |
| Python installation | `uv python install` (replaces pyenv) |
| Script execution | `uv run` (runs with dependencies managed) |
| Build & publish | `uv build`, `uv publish` |

### Essential Commands Reference

```bash
# Project initialization
uv init                          # New project in current dir
uv init my-project               # New project with name

# Dependency management
uv add requests                  # Add dependency
uv add 'flask>=2.0'              # Add with version constraint
uv add --dev pytest              # Add dev dependency
uv add --optional gui pyqt6      # Add optional dependency
uv remove requests               # Remove dependency
uv sync                          # Sync environment with lockfile
uv lock                          # Update lockfile
uv lock --upgrade-package flask  # Upgrade specific package

# Running code
uv run main.py                   # Run script in project env
uv run pytest                    # Run command in project env
uv run --env-file .env main.py   # Run with env file

# Python version management
uv python install                # Install latest Python
uv python install 3.12           # Install specific version
uv python install --default      # Set as default python/python3

# Tool management (replaces pipx)
uvx ruff check                   # Run tool without installing
uv tool install ruff             # Install tool globally
uv tool upgrade ruff             # Upgrade installed tool

# pip interface (for compatibility)
uv pip install flask             # Install package
uv pip install -r requirements.txt
uv pip compile requirements.in -o requirements.txt

# Build and publish
uv build                         # Create dist/
uv publish                       # Publish to PyPI
```

### Best Practices (2024-2025)

#### Project Structure
```
my-project/
├── .python-version     # Python version pin
├── .venv/              # Auto-created virtual environment
├── pyproject.toml      # Project config & dependencies
├── uv.lock             # Lockfile (commit this!)
├── src/
│   └── my_project/
│       └── __init__.py
└── tests/
    └── test_main.py
```

#### Key Recommendations

1. **Use `uv run` instead of activating venv**
   ```bash
   # Don't: source .venv/bin/activate && python main.py
   # Do:
   uv run main.py
   ```

2. **Commit `uv.lock`** - Ensures reproducible builds

3. **Use `--locked` in CI/CD**
   ```bash
   uv sync --locked  # Fails if lockfile outdated
   ```

4. **Production Docker settings**
   ```dockerfile
   ENV UV_COMPILE_BYTECODE=1
   RUN uv sync --locked --no-dev
   ```

5. **For requirements.txt migration**
   ```bash
   uv add -r requirements.txt
   ```

### Comparison with Other Tools

| Tool | uv Replacement |
|------|----------------|
| pip | `uv pip install` |
| pip-tools | `uv pip compile` |
| pipx | `uvx`, `uv tool` |
| poetry | `uv add`, `uv lock`, `uv sync` |
| pyenv | `uv python install` |
| virtualenv | `uv venv` |

### Environment Variables

| Variable | Purpose |
|----------|---------|
| `UV_COMPILE_BYTECODE=1` | Compile to .pyc (faster startup) |
| `UV_NO_SYNC=1` | Skip sync in `uv run` |
| `UV_MANAGED_PYTHON=1` | Only use uv-managed Python |

## Skill Design Recommendations

### Trigger Conditions
- User mentions "uv", "python project", "python package manager"
- User wants to create/manage Python project
- User asks about pip alternative or faster package manager
- User mentions pyenv, poetry, pipx replacement

### Skill Structure
```
skills/development/python-uv/
├── SKILL.md              # Main skill with commands and workflows
└── reference/
    ├── commands.md       # Full command reference
    └── migration.md      # Migration guides from pip/poetry
```

### Key Workflows to Include

1. **New Project Setup**
2. **Add/Remove Dependencies**
3. **Run Scripts and Commands**
4. **Install Python Versions**
5. **CI/CD Integration**
6. **Docker Best Practices**
7. **Migration from pip/poetry**

## Sources

- [uv Official Documentation](https://docs.astral.sh/uv/)
- [uv GitHub Repository](https://github.com/astral-sh/uv)
- [Astral Blog - Unified Python Packaging](https://astral.sh/blog/uv-unified-python-packaging)
- [DataCamp - Python UV Guide](https://www.datacamp.com/tutorial/python-uv)
- [SaaS Pegasus - uv Deep Dive](https://www.saaspegasus.com/guides/uv-deep-dive/)
- [Real Python - Managing Projects with uv](https://realpython.com/python-uv/)
- [Pragmatic AI Labs - UV Architecture](https://paiml.com/blog/2024-12-01-uv-architecture/)

## Confidence Assessment

| Aspect | Confidence | Notes |
|--------|------------|-------|
| Core commands | High | Verified via official docs |
| Best practices | High | Consistent across sources |
| Performance claims | High | Multiple benchmarks confirm |
| CI/CD patterns | High | GitHub Actions documented |
| Docker practices | High | Official guide available |
