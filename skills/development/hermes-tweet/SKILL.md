---
name: hermes-tweet
description: Install, configure, and operate Hermes Tweet for Hermes Agent X/Twitter research, account reads, social monitoring, and approval-gated account actions.
version: 1.0.0
---

# Hermes Tweet

## Overview

Hermes Tweet is a native Hermes Agent plugin for X/Twitter workflows. Use it
when a user needs X/Twitter search, public signal research, authenticated
account reads, social monitoring, or explicit account actions from Hermes Agent.

Repository: <https://github.com/Xquik-dev/hermes-tweet>

## Instructions

### 1. Confirm Fit

Use this skill when the task mentions:

- Hermes Agent X/Twitter workflows
- Installing or validating the `hermes-tweet` plugin
- Social listening, trend research, mentions, account reads, or creator and
  brand research through Hermes
- Posting, replies, follows, DMs, monitors, webhooks, media, or other account
  changes that require explicit approval

Do not use Hermes Tweet as a generic social media scraper. It is for Hermes
Agent plugin workflows.

### 2. Install

Recommended Hermes install:

```bash
hermes plugins install Xquik-dev/hermes-tweet --enable
```

If the plugin is installed but disabled, enable it:

```bash
hermes plugins enable hermes-tweet
```

From PyPI inside the Hermes Python environment:

```bash
uv pip install --python ~/.hermes/hermes-agent/venv/bin/python hermes-tweet
hermes plugins enable hermes-tweet
```

### 3. Configure Safely

Set credentials only in the runtime environment or `~/.hermes/.env`:

```bash
export XQUIK_API_KEY="xq_..."
export HERMES_TWEET_ENABLE_ACTIONS="false"
```

Keep `HERMES_TWEET_ENABLE_ACTIONS=false` for research, monitoring, and
unattended runs. Set it to `true` only for sessions that need posting, replies,
DMs, follows, media changes, monitor changes, webhook changes, or other
account-changing actions.

Never paste API keys into prompts, issue bodies, PR comments, or tool inputs.

### 4. Operate Read First

Use the tools in this order:

1. `tweet_explore`: Search the bundled endpoint catalog. This does not call the
   API.
2. `tweet_read`: Call catalog-listed read endpoints after choosing a concrete
   `/api/v1/...` path.
3. `tweet_action`: Use only for approved private or write-like endpoints after
   `HERMES_TWEET_ENABLE_ACTIONS=true` is set.

For social listening, trend research, account checks, launch monitoring,
giveaway audits, and draft planning, keep the workflow read-only.

### 5. Validate

List enabled toolsets:

```bash
hermes tools list
```

Run a read-first smoke test:

```bash
hermes -z "Use tweet_explore, then read /api/v1/account. Do not call tweet_action." --toolsets hermes-tweet
```

Expected behavior:

- Without `XQUIK_API_KEY`, Hermes exposes `tweet_explore` only.
- With `XQUIK_API_KEY`, `tweet_read` can call catalog-listed read endpoints.
- `tweet_action` stays hidden or disabled unless
  `HERMES_TWEET_ENABLE_ACTIONS=true`.

## Guidelines

- Keep account-changing calls explicit and approval-gated.
- Use `tweet_explore` before selecting any endpoint path.
- Prefer read-only routes for automated or scheduled workflows.
- Restart Hermes gateway, cron, or desktop runtime sessions after changing
  environment variables outside an active CLI session.
- Treat installation, runtime secrets, and action enablement as separate steps.
