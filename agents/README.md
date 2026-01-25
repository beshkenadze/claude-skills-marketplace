# Multi-Agent Development Team

Multi-agent development team configuration with Gitea integration.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    PM AGENT (Orchestrator)                   │
│  Gitea: agent-pm | Role: Task decomposition, PR reviews     │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┬─────────────┐
        │             │             │             │
        ▼             ▼             ▼             ▼
┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
│ FRONTEND  │  │  BACKEND  │  │  DEVOPS   │  │    QA     │
│           │  │           │  │           │  │           │
│ Next.js   │  │ tRPC      │  │ Docker    │  │ Vitest    │
│ React     │  │ ZenStack  │  │ CI/CD     │  │ Playwright│
│ Tailwind  │  │ Prisma    │  │ K8s       │  │ Review    │
└───────────┘  └───────────┘  └───────────┘  └───────────┘
```

## Quick Start

### 1. Create Users in Gitea

```bash
# Via Admin UI or CLI
tea admin user create --username agent-pm --email agent-pm@local
tea admin user create --username agent-frontend --email agent-frontend@local
tea admin user create --username agent-backend --email agent-backend@local
tea admin user create --username agent-devops --email agent-devops@local
tea admin user create --username agent-qa --email agent-qa@local
```

### 2. Generate Tokens

For each agent:
1. Login to Gitea under the account
2. Settings → Applications → Generate New Token
3. Permissions: `repo:read`, `repo:write`, `issue:read`, `issue:write`

### 3. Configure Environment

```bash
cp .env.template .env
# Fill in tokens in .env
```

### 4. Add Agents to Repository

```bash
# Grant repository access
tea repos add-collaborator agent-pm --permission write
tea repos add-collaborator agent-frontend --permission write
tea repos add-collaborator agent-backend --permission write
tea repos add-collaborator agent-devops --permission write
tea repos add-collaborator agent-qa --permission write
```

## Usage

### Option A: Claude Code Subagents

Copy configs to `~/.claude/agents/`:

```bash
cp -r agents/*/ ~/.claude/agents/
```

Launch via Task tool:
```
Task(subagent_type="backend-agent", prompt="Implement user CRUD API")
```

### Option B: Claude Agent SDK

```typescript
import { Claude } from '@anthropic-ai/sdk';
import pmConfig from './agents/pm/agent.json';
import frontendConfig from './agents/frontend/agent.json';

const orchestrator = new Claude({
  systemPrompt: pmConfig.systemPrompt
});

const frontend = orchestrator.createSubagent({
  name: 'frontend',
  systemPrompt: frontendConfig.systemPrompt,
  allowedPaths: frontendConfig.allowedPaths
});

// PM delegates task
await orchestrator.chat(`
  Create issue: Add user profile page
  Assign to: @frontend
`);
```

### Option C: Gitea Actions (Automation)

```yaml
# .gitea/workflows/agent-dispatch.yml
name: Agent Dispatch

on:
  issues:
    types: [labeled]

jobs:
  dispatch:
    runs-on: ubuntu-latest
    steps:
      - name: Route to agent
        run: |
          LABEL="${{ github.event.label.name }}"
          case $LABEL in
            frontend|ui|react)
              echo "Assigning to agent-frontend"
              tea issue edit ${{ github.event.issue.number }} --assignees agent-frontend
              ;;
            backend|api|database)
              echo "Assigning to agent-backend"
              tea issue edit ${{ github.event.issue.number }} --assignees agent-backend
              ;;
          esac
```

## Label Routing

| Label | Agent |
|-------|-------|
| `frontend`, `ui`, `react`, `nextjs` | frontend-agent |
| `backend`, `api`, `database`, `auth` | backend-agent |
| `devops`, `ci`, `docker`, `k8s` | devops-agent |
| `qa`, `testing`, `bug` | qa-agent |

## Workflow

1. **User** creates issue in Gitea
2. **PM Agent** breaks down into subtasks, assigns labels
3. **Specialized Agent** picks up issue by label
4. Agent creates branch, implements, opens PR
5. **QA Agent** reviews, runs tests
6. **PM Agent** merges after approval

## Files

```
agents/
├── orchestrator.json    # Main orchestrator config
├── .env.template        # Environment variables template
├── README.md            # This documentation
├── pm/
│   └── agent.json       # Project Manager
├── frontend/
│   └── agent.json       # Frontend Developer
├── backend/
│   └── agent.json       # Backend Developer
├── devops/
│   └── agent.json       # DevOps Engineer
└── qa/
    └── agent.json       # QA Engineer
```

## Agent Skills

| Agent | Installed Skills |
|-------|-----------------|
| Frontend | nextjs-expert, react-expert, typescript-expert, typescript-advanced-types, biome |
| Backend | trpc-expert, prisma-expert, zenstack, better-auth |
| DevOps | docker-expert, github-actions-expert |
| QA | vitest-expert, playwright-expert, jest-expert |

> **Note:** Skills are resolved dynamically. Install corresponding skills from marketplace for full functionality.
