# Quick Reference Card

## Installation One-Liners

### Complete Setup (Automated)
```bash
git clone https://github.com/GauravRatnawat/claude-cost-optimizer.git && cd claude-cost-optimizer && ./setup.sh
```

### Individual Tools

**claudetop** (Cost Monitoring)
```bash
npm install -g claudetop
# GitHub: https://github.com/GauravRatnawat/claudetop
```

**GitNexus** (Code Intelligence)
```bash
npm install -g gitnexus
# GitHub: https://github.com/abhigyanpatwari/GitNexus
```

**code-review-graph** (MCP Server)
```bash
# GitHub: https://github.com/tirth8205/code-review-graph
# Install as MCP server - see repo for setup
```

**gstack** (Automation Skills)
```bash
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack
```

**Handy** (Voice-to-Text)
- Mac App Store: Search "Handy"
- GitHub: https://github.com/handy-app/handy

## Quick Commands

### Cost Monitoring
```bash
claudetop --today              # Today's costs
claudetop --days 7             # Last 7 days
claudetop --summary            # One-line summary
claudetop                      # Interactive dashboard
```

### gstack Skills
```bash
/review                        # Review PR
/qa                           # QA test app
/ship                         # Complete ship workflow
/browse                       # Headless browser test
/retro                        # Weekly retrospective
/plan-ceo-review              # CEO planning
/plan-eng-review              # Engineering planning
```

### GitNexus
```bash
gitnexus --version            # Check version
gitnexus rebuild              # Rebuild code graph
```

## Configuration Files

```bash
~/.claude/settings.json        # Model config (opusplan)
~/.claude/settings.local.json  # Permissions
~/.claude/hooks.json           # GitNexus hooks
~/.claude/CLAUDE.md            # Global instructions
~/.claude/skills/              # Custom skills
```

## Key Settings

### opusplan Model
```json
{
  "model": "opusplan"
}
```

### Pre-authorize Commands
```json
{
  "permissions": {
    "allow": [
      "Bash(git status:*)",
      "Bash(npm test:*)"
    ]
  }
}
```

## Potential Optimizations

| Strategy | Impact |
|---------|--------|
| Model selection | Opus→Sonnet saves ~70% per query |
| Task automation | Reuse instead of re-query |
| Voice-to-text | Clearer prompts = fewer iterations |
| Context preservation | Stop re-explaining |
| Copilot for simple tasks | Flat $10/mo for boilerplate |

**Your savings depend on your usage patterns. Track first, optimize second.**

### GitHub Copilot (Complementary)
- Free: $0 (2,000 completions/month)
- Pro: $10/month
- Use for: Simple completions, boilerplate
- Use Claude for: Complex reasoning, multi-file changes

## Troubleshooting

### Command not found
```bash
echo 'export PATH="$(npm root -g)/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Skills not loading
```bash
ls -la ~/.claude/skills/gstack/
# Should see: review/, qa/, ship/, browse/, retro/
```

### High costs still
```bash
# Check model distribution
claudetop --json | jq '.sessions[].model'

# Verify opusplan is active
cat ~/.claude/settings.json
```

## Links

- **This Project**: https://github.com/GauravRatnawat/claude-cost-optimizer
- **gstack**: https://github.com/garrytan/gstack
- **Handy**: https://github.com/handy-app/handy
- **claudetop**: https://github.com/GauravRatnawat/claudetop
- **GitNexus**: https://github.com/abhigyanpatwari/GitNexus
- **code-review-graph**: https://github.com/tirth8205/code-review-graph
- **agency-agents**: https://github.com/msitarzewski/agency-agents (optional personas)
- **GitHub Copilot**: https://github.com/features/copilot

## Cost Goals

- **Week 1**: Establish baseline with `claudetop --days 7`
- **Week 2**: Aim for 50% reduction
- **Week 3**: Aim for 70% reduction
- **Week 4**: Optimize based on usage patterns

## Support

- 📖 [README.md](./README.md)
- 🚀 [QUICKSTART.md](./QUICKSTART.md)
- ❓ [FAQ.md](./FAQ.md)
- 📚 [docs/](./docs/)

---

**Print this card or bookmark for quick reference!**
