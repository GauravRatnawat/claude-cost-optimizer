# Quick Start Guide

Get up and running with cost-optimized Claude Code in 5 minutes.

## Prerequisites Check

```bash
# Check if you have the required tools
claude --version    # Should show Claude Code CLI
node --version      # Should show Node.js v16+
npm --version       # Should show npm v7+
git --version       # Should show git v2+
```

If any are missing:
- Claude Code: `npm install -g @anthropic-ai/claude-code`
- Node.js: Download from [nodejs.org](https://nodejs.org)
- Git: Download from [git-scm.com](https://git-scm.com)

## Installation (Automated)

```bash
# 1. Get the setup project
git clone https://github.com/your-username/claude-cost-optimizer.git
cd claude-cost-optimizer

# 2. Run automated setup (backs up existing config)
./setup.sh

# 3. Done! Start a new Claude session
claude
```

## Installation (Step-by-Step)

Prefer to see each step? Use interactive mode:

```bash
./setup.sh --interactive
```

This will ask for confirmation before each change.

## Verify Installation

```bash
# 1. Check cost monitoring
claudetop --today

# Expected output:
# Today (Mar 19): XXM tokens · $XX.XX · X sessions · XXX queries

# 2. Check configuration
cat ~/.claude/settings.json

# Expected output:
# {
#   "model": "opusplan",
#   "enabledPlugins": {}
# }

# 3. Check skills
ls ~/.claude/skills/

# Expected to see:
# gstack/
# conversation-recorder/
```

## First Steps

### 1. Understand Your Baseline

Before optimizing, know your starting point:

```bash
# Check your last 7 days (before optimization)
claudetop --days 7 --summary
```

Example output:
```
Last 7 days: 450M tokens · $540.00 · avg $77/day
```

### 2. Start Using Automation

Start a new Claude session and try a skill:

```bash
claude

# In Claude session:
> /review

# This will review your current branch for issues
```

### 3. Monitor Daily

Add to your daily routine:

```bash
# Morning: Check yesterday's costs
claudetop --today

# Set a reminder or add to your shell profile:
echo 'alias claude-costs="claudetop --today"' >> ~/.bashrc
```

## Week 1 Challenge

For maximum learning, try this progression:

### Day 1: Setup & Baseline
- Run setup
- Check baseline: `claudetop --days 7`
- Use Claude normally

### Day 2-3: Learn Skills
- Use `/review` before each PR
- Use `/qa` to test features
- Use `/browse` to verify deployments

### Day 4-5: Optimize Permissions
- Note which commands you approve repeatedly
- Add them to `~/.claude/settings.local.json`
- Restart Claude session

### Day 6-7: Workspace Organization
- Install Conductor (if available)
- Create separate workspaces for different projects
- Use conversation-recorder to save context

### End of Week: Measure Results

```bash
# Compare Week 1 to baseline
claudetop --days 14

# Expected: 50-70% cost reduction
```

## Common First-Day Issues

### "claudetop: command not found"

Fix:
```bash
# Check npm global bin is in PATH
npm config get prefix

# Add to PATH (replace /path/to/npm with actual path)
echo 'export PATH="/path/to/npm/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### "Skills not loading"

Fix:
```bash
# Check skill directory
ls -la ~/.claude/skills/gstack/

# If missing, install gstack
# See docs/GSTACK_INSTALL.md for installation options

# gstack is optional - other optimizations still work!
```

### "opusplan not working"

Check:
```bash
cat ~/.claude/settings.json

# Should show:
# {
#   "model": "opusplan",
#   ...
# }
```

If not, rerun setup or manually edit the file.

## Quick Reference

### Daily Commands

```bash
# Check today's costs
claudetop --today

# Start Claude session
claude

# In session, use skills:
/review   # Review PR
/qa       # Test app
/ship     # Ship feature
/browse   # Test with browser
/retro    # Weekly retrospective
```

### Weekly Commands

```bash
# Weekly cost report
claudetop --days 7

# Weekly retrospective (in Claude session)
/retro
```

### Monthly Commands

```bash
# Monthly budget check
claudetop --days 30 --summary

# Update skills (if using gstack)
cd ~/.claude/skills/gstack
git pull
```

## Next Steps

1. **Read the FAQ**: Common questions answered in [FAQ.md](./FAQ.md)
2. **Customize**: Edit templates in `templates/` to match your workflow
3. **Contribute**: Share your cost savings in [CONTRIBUTING.md](./CONTRIBUTING.md)

## Support

- Issues: Open a GitHub issue
- Questions: Check [FAQ.md](./FAQ.md)
- Discussions: GitHub Discussions

---

**Remember**: The goal is 70% cost reduction. Track your progress weekly and adjust!
