---
name: software-graph-analysis
description: Build and query an Ontoly Software Graph for deterministic codebase understanding. Use for architecture summaries, route tracing, service/module ownership, dependency traversal, configuration usage, dead-code evidence, and impact analysis before falling back to source search.
version: 1.0.0
---

# Software Graph Analysis

## Overview

Use Ontoly to answer software-understanding questions from a deterministic graph of repository concepts and relationships. The graph is the first evidence source; source-file inspection is a fallback for missing or ambiguous graph coverage.

## Instructions

1. Find the repository root.
2. Check whether an Ontoly graph exists, usually `.ontoly/SoftwareGraph.json`.
3. If no graph exists or it is stale, run:

   ```bash
   npx ontoly build .
   ```

4. Review graph metadata, diagnostics, statistics, graph hash, framework detection, trust, and coverage before answering.
5. Query Ontoly CLI or MCP capabilities for the smallest graph scope that answers the request:
   - architecture: packages, modules, services, routes, framework report
   - route tracing: route -> handler/controller -> service -> repository/database
   - dependency analysis: imports, dependencies, callers, callees, consumers
   - impact analysis: upstream/downstream relationships and affected graph regions
   - configuration: configuration and environment-variable usage
6. Cite graph evidence in the answer: node IDs, node kinds, relationship names, edge directions, source locations, diagnostics, and graph-quality warnings.
7. If the graph cannot answer, state the missing node, edge, framework concept, or diagnostic. Only then inspect source files and label that evidence as fallback.

## Examples

### Example 1: Route Trace

**Input:**
```
Trace POST /login.
```

**Output:**
```markdown
## Answer
POST /login is handled by AuthController and flows through AuthService before reaching UserRepository.

## Graph Evidence
| Kind | Evidence |
|------|----------|
| Route | `route:POST:/login` |
| Edge | `route:POST:/login --HANDLES--> class:AuthController` |
| Edge | `class:AuthController --CALLS--> service:AuthService` |

## Confidence
High because route, controller, service, and repository nodes are present with connected edges.
```

### Example 2: Impact Analysis

**Input:**
```
What breaks if UserRepository changes?
```

**Output:**
```markdown
## Answer
The direct consumers are AuthService and SessionService. The affected request paths include POST /login and POST /logout.

## Gaps
No runtime migration graph was present, so database migration impact was not inferred.
```

## Guidelines

- Prefer graph queries over repository search for architecture, dependency, route, configuration, and impact questions.
- Do not claim certainty without graph evidence.
- Report low coverage, unresolved imports, ambiguous nodes, or missing relationship types as first-class findings.
- Keep answers scoped to the user's question; avoid dumping the whole graph.
- Do not modify the repository unless the user explicitly asks for implementation work.
