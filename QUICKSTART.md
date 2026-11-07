# Quick Start Guide

Run setup, check tools, then follow linked guides.

## Prerequisites Check

```bash
claude --version    # Need Claude Code CLI
node --version      # Need Node.js 18+, see README
npm --version       # Need npm v7+
git --version       # Need Git v2+
```

Missing tools? Install Claude Code with `npm install -g @anthropic-ai/claude-code`. Get [Node.js](https://nodejs.org) and [Git](https://git-scm.com). See [README prerequisites](README.md#prerequisites).

## Installation (Automated)

Follow [README install steps](README.md#install), then start new session with `claude`.

## Installation (Step-by-Step)

Use `./setup.sh --interactive` for backup and local gstack link prompts. For each manual step, see [Manual Setup](MANUAL_SETUP.md).

## Verify Installation

```bash
claudetop --today              # Need cost dashboard with tokens, cost, sessions, queries
cat ~/.claude/settings.json    # Check model is opusplan and enabledPlugins exists
ls ~/.claude/skills/           # Check installed skill dirs
```

Look for `gstack/` and `conversation-recorder/` if installed. See [README checks](README.md#getting-started) for RTK and plugin checks.

## First Steps

### 1. Understand Your Baseline

Run `claudetop --days 7 --summary` before changes. Save token and cost totals for later check.

### 2. Start Using Automation

Start `claude`, then try `/review` in chat if gstack installed. See [gstack setup](docs/GSTACK_INSTALL.md#verification).

### 3. Monitor Daily

Run `claudetop --today`. More commands in [cost reference](docs/ALL_COMMANDS.md#step-4-claudetop--cost-monitoring).

## Week 1 Challenge

### Day 1: Setup & Baseline

Use [README stages](README.md#getting-started), save baseline, work as usual.

### Day 2-3: Learn Skills

Try `/review`, `/qa`, `/browse`. See [workflow commands](docs/ALL_COMMANDS.md#step-6-gstack-skills-in-claude-sessions).

### Day 4-5: Optimize Permissions

See [permission guide](docs/03-configuration.md#layer-2-permissions-settingslocaljson). Add only commands you trust, then restart session.

### Day 5-6: ECC Skills Harness (Optional)

See [ECC install guide](docs/ECC_COMMANDS.md#step-1-install-content-into-claude-code).

### Day 7: Workspace Organization

See [Conductor guide](docs/02-tools-reference.md#conductor) for optional workspaces. Use session recorder for saved context.

### End of Week: Measure Results

Run `claudetop --days 14`. Compare costs with saved baseline.

## Quick Reference

### Daily Commands

See [workflow commands](docs/ALL_COMMANDS.md#step-6-gstack-skills-in-claude-sessions) and [cost commands](docs/ALL_COMMANDS.md#step-4-claudetop--cost-monitoring).

### Weekly Commands

Run `claudetop --days 7`; try `/retro` in Claude chat.

### Monthly Commands

Run `claudetop --days 30 --summary`. For gstack updates, see [update steps](docs/GSTACK_INSTALL.md#stay-updated).

## Next Steps

See [All Commands](docs/ALL_COMMANDS.md), [FAQ](FAQ.md), [config templates](templates/), [Contributing](CONTRIBUTING.md).

## Support

Check [FAQ](FAQ.md), then use repo Issues or Discussions.
