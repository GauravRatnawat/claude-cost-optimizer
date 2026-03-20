# Frequently Asked Questions

## General

### Q: Will this really cut costs by 70%?

**A:** Results vary based on usage patterns, but the 70% figure comes from real-world usage. The key factors:
- opusplan mode saves ~60% by using cheaper models for execution
- Automated skills reduce repetitive queries by 50-80%
- Conversation persistence eliminates context re-explanation
- Pre-authorized commands reduce approval overhead

Your results will depend on your baseline usage patterns.

### Q: Do I lose quality with cheaper models?

**A:** No! opusplan uses Opus for planning (where quality matters most) and Sonnet/Haiku for execution (where speed matters more). You get the best of both worlds.

### Q: How long does setup take?

**A:** Automated setup: ~5 minutes. Manual setup: ~20-30 minutes.

## Technical

### Q: What if I already have custom configurations?

**A:** The setup script backs up your existing configuration to `~/.claude/backups/TIMESTAMP/`. You can run with `--interactive` flag to confirm each step.

### Q: Can I use this with other Claude Code features?

**A:** Yes! This setup is additive. It works with:
- MCP servers
- Custom plugins
- IDE integrations
- Remote sessions

### Q: Does this work on Windows?

**A:** The bash script is designed for Mac/Linux. Windows users should:
1. Use WSL (recommended)
2. Use Git Bash
3. Follow the manual setup guide

### Q: What's the difference between skills and plugins?

**A:**
- **Skills** are workflow automations (like /review, /qa)
- **Plugins** are integrations with external tools (LSPs, databases, etc.)

Both work together seamlessly.

## Cost & Monitoring

### Q: How accurate is claudetop?

**A:** claudetop reads from Claude Code's local stats cache, which tracks every API call. It's 100% accurate for local usage. Note: It doesn't track usage from claude.ai web interface or other clients.

### Q: What's a "good" burn rate?

**A:** It depends on your usage:
- Light development: $10-30/day
- Heavy development: $50-100/day
- Team usage: $200+/day

The goal is consistency. Track weekly trends, not daily fluctuations.

### Q: Can I set cost alerts?

**A:** Not yet in claudetop, but you can:
1. Run `claudetop --today` in a daily cron job
2. Parse the output and send alerts if over threshold
3. Use the `--json` flag for programmatic access

Example:
```bash
# Daily cost check
COST=$(claudetop --today | grep -oP '\$[\d.]+' | head -1)
if (( $(echo "$COST > 100" | bc -l) )); then
  echo "⚠️  High cost alert: $COST"
fi
```

## Workflows

### Q: When should I use /review vs /qa?

**A:**
- **/review**: Before merging a PR. Catches structural issues (SQL safety, trust boundaries, etc.)
- **/qa**: After implementing features. Tests the actual application behavior

Use both! /review first, then /qa.

### Q: What's the difference between /ship and manual shipping?

**A:** /ship automates:
1. Merge main into feature branch
2. Run tests
3. Review diff
4. Bump VERSION
5. Update CHANGELOG
6. Commit changes
7. Push to remote
8. Create PR

Manually, this is 50+ queries. With /ship: 1 command.

### Q: Do I need gstack to use this optimizer?

**A:** No! gstack is optional but recommended. Without gstack you still get:
- 40-50% cost savings from opusplan, monitoring, and voice-to-text
- All other optimizations work independently

With gstack, savings increase to 60-70% due to workflow automation.

See [docs/GSTACK_INSTALL.md](./docs/GSTACK_INSTALL.md) for installation options.

### Q: Can I customize the skills?

**A:** Yes! Skills are just directories with SKILL.md files. You can:
1. Fork and modify existing skills
2. Create new skills from scratch
3. Chain multiple skills together

See [docs/CREATING_SKILLS.md](./docs/CREATING_SKILLS.md) for examples.

## Workspace Management

### Q: Do I need Conductor?

**A:** No, but it helps! Conductor provides:
- Visual workspace switching
- Isolated session history per workspace
- Project-specific configurations

Without Conductor, you can still use project-specific CLAUDE.md files.

### Q: How do workspaces save costs?

**A:** By preventing context bleeding. Without workspaces:
- Claude sees history from unrelated projects
- Wastes tokens on irrelevant context
- Gets confused by mixed contexts

With workspaces: each project stays focused.

### Q: Can I sync workspaces across machines?

**A:** Conductor workspaces are local. For sync:
1. Use git to version control your CLAUDE.md files
2. Use cloud storage for `~/.claude/` directory
3. Use remote Claude sessions (experimental feature)

## GitNexus

### Q: What does GitNexus actually do?

**A:** GitNexus builds a graph of your codebase (files, functions, imports, etc.) and suggests relevant files before Claude searches. This prevents wasteful exploratory searches.

### Q: Does it work with all languages?

**A:** Best support for:
- JavaScript/TypeScript
- Python
- Go
- Rust
- Java

Basic support for most other languages.

### Q: How often does it update the graph?

**A:** Automatically on file changes (via pre-hooks). You can force rebuild:
```bash
gitnexus rebuild
```

## Troubleshooting

### Q: I'm not seeing cost savings. What's wrong?

**A:** Check:
1. Is opusplan actually enabled? `cat ~/.claude/settings.json`
2. Are you using skills instead of manual workflows?
3. Are conversations being saved/resumed?
4. Run `claudetop --days 7` to see model distribution

### Q: Skills aren't working. Help!

**A:** Debug steps:
1. Check skill exists: `ls ~/.claude/skills/gstack/review/`
2. Check SKILL.md exists: `cat ~/.claude/skills/gstack/review/SKILL.md`
3. Start fresh session
4. Check Claude Code version: `claude --version`

### Q: GitNexus hooks timing out

**A:** Increase timeout in `~/.claude/hooks.json`:
```json
{
  "timeout": 15000  // 15 seconds
}
```

Or disable for large repos:
```bash
mv ~/.claude/hooks.json ~/.claude/hooks.json.disabled
```

## Best Practices

### Q: How should I structure my workflow?

**A:** Recommended flow:
1. Start session in Conductor workspace
2. Implement feature
3. `/review` - Check for issues
4. `/qa` - Test the feature
5. `/ship` - Create PR
6. End of week: `/retro` - Reflect on progress

### Q: Should I pre-authorize all commands?

**A:** No! Only pre-authorize:
- Read-only commands (git status, ls, cat)
- Safe operations (npm test, pytest)
- Commands you understand

Never pre-authorize:
- Destructive operations (rm, git reset --hard)
- Network operations you don't control
- Commands with side effects

### Q: How often should I check claudetop?

**A:**
- Daily: `claudetop --today` (quick check)
- Weekly: `claudetop --days 7` (trend analysis)
- Monthly: `claudetop --days 30` (budget planning)

## Advanced

### Q: Can I use different models for different tasks?

**A:** Yes! Instead of opusplan, you can:
1. Set model per-session (override settings.json)
2. Create skill-specific model configs
3. Use model parameters in API calls

But opusplan is recommended for simplicity.

### Q: How do I contribute optimizations?

**A:** Open a PR or issue! We're collecting:
- New cost-saving techniques
- Custom skills that reduce tokens
- Better permission presets
- Integration with other tools

### Q: Can I see the token breakdown per tool?

**A:** Yes! Use:
```bash
claudetop --json | jq '.sessions[].tool_usage'
```

This shows which tools consume the most tokens.

### Q: Can specialized agent personas help reduce costs?

**A:** Yes! Using role-specific agents can reduce costs by:
- **Better first-time results** - Specialized personas give more accurate responses
- **Fewer iterations** - Role-appropriate context reduces back-and-forth
- **Focused prompts** - Less token waste on irrelevant context

**agency-agents** provides 100+ pre-built personas (engineers, designers, QA testers, etc.):
- **GitHub**: https://github.com/msitarzewski/agency-agents
- **Integration**: Works natively with Claude Code
- **Usage**: Copy persona files to your project or `~/.claude/` directory
- **Cost impact**: 10-20% additional savings through better-targeted prompts

Example personas:
- Frontend/backend developers with specific tech stacks
- QA testers for different testing types
- DevOps engineers for infrastructure tasks
- Marketing specialists for content creation

This is an **optional enhancement** - your core cost optimizer works great without it!

---

**More questions?** Open an issue on GitHub or check the discussions.
