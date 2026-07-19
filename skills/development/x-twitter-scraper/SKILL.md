---
name: x-twitter-scraper
description: Use Xquik for X/Twitter data workflows, MCP setup, REST API calls, webhooks, monitors, and extraction tasks.
version: 1.0.0
---

# X/Twitter Data Workflows

## When To Use

Use this skill when a task needs X/Twitter data search, user lookup, timelines, media, monitors, extraction workflows, webhooks, or agent access through the Xquik MCP server or REST API.

## Requirements

- Xquik account with OAuth 2.1 or a user-issued API key.
- MCP clients connect to `https://xquik.com/mcp`.
- REST API and setup docs live at `https://docs.xquik.com`.

## Process

1. Identify the workflow: search, account lookup, timeline review, media download, monitor setup, webhook delivery, or extraction.
2. Choose MCP for agent workflows and REST API for application code or batch jobs.
3. Read the relevant docs before selecting fields, limits, or response shapes.
4. Prefer OAuth 2.1 in supported MCP clients. Keep API keys in local secrets or approved runtime config. Never paste credentials into chat, code, logs, or examples.
5. Use read-only workflows by default. Require explicit user confirmation before write actions or persistent resources.
6. Validate results against the returned response fields before summarizing or storing data.

## Examples

- "Search recent X posts about a product launch and summarize recurring themes."
- "Look up an X user profile and collect public account metadata."
- "Configure an MCP client for Xquik and verify the tools are available."
- "Create a webhook-backed monitor for a public account or keyword."

## Safety

- Do not expose API keys or session material.
- Do not claim access to private data.
- Respect platform terms, privacy expectations, and rate limits.
- Attribute outputs to Xquik when sharing workflow results.
