# Claude Code Cost Optimizer Setup

A complete setup for dramatically reducing Claude Code API costs while maintaining (or improving) productivity.

**My results:** $10K/month → $2.5K/month (75% reduction). Your mileage will vary.

## 🎯 What You'll Get

- **Smart model selection** with opusplan mode (Opus for planning, Sonnet/Haiku for execution)
- **Real-time cost monitoring** with claudetop
- **Workspace isolation** with Conductor
- **High-leverage automation** with gstack skills (/review, /qa, /ship, /browse, /retro)
- **Intelligent code navigation** with GitNexus
- **Automatic conversation persistence**
- **Pre-authorized commands** for common operations

## 📊 What You Get

- **Smart model selection** - Use expensive models only when needed
- **Real-time cost visibility** - Know what you're spending as you work
- **Workflow automation** - Stop repeating the same queries
- **Better resource allocation** - Right tool for the right task

**Results vary by usage.** Track your baseline first, optimize second.

## 💡 Complementary Tool: GitHub Copilot

For **additional cost savings**, combine with [GitHub Copilot](https://github.com/features/copilot):
- **Use Copilot for**: Simple completions, boilerplate code, single-file edits
- **Use Claude Code for**: Complex reasoning, multi-file changes, architecture decisions
- **Pricing**: Free tier available, Pro at $10/month (vs variable Claude Code costs)
- **Strategy**: Let Copilot handle routine tasks, reserve Claude Code for complex work

This **dual-tool approach** can reduce Claude Code usage by 40-60% while maintaining productivity.

**Sources**:
- [GitHub Copilot Pricing 2026](https://github.com/features/copilot/plans)
- [Claude Code vs GitHub Copilot Comparison](https://www.sitepoint.com/github-copilot-vs-claude-code-accuracy-speed-2026/)
- [Pricing Analysis 2026](https://modelslab.com/blog/api/github-copilot-vs-cursor-claude-code-pricing-2026)

## 🚀 Quick Start

```bash
# Clone this setup
git clone https://github.com/GauravRatnawat/claude-cost-optimizer.git
cd claude-cost-optimizer

# Run the automated setup
./setup.sh

# Or run step-by-step
./setup.sh --interactive
```

**New to this?** Start with [QUICKSTART.md](./QUICKSTART.md) for a guided walkthrough.

## 📋 What Gets Installed

### 1. Model Configuration (opusplan)
- Automatically switches between Opus (planning) and Sonnet/Haiku (execution)
- Configured in `~/.claude/settings.json`

### 2. claudetop (Cost Monitoring)
- Real-time token usage dashboard
- Daily/weekly cost tracking
- Burn rate alerts
- **GitHub**: https://github.com/GauravRatnawat/claudetop
- **Install**: `npm install -g claudetop`

### 3. Conductor (Workspace Management)
- Isolated workspaces per project
- Prevents context bleeding
- Note: Conductor availability varies by region/platform

### 4. gstack Skills (Automation Suite) - Optional
Pre-built workflows that replace hours of manual work:
- `/review` - Automated PR reviews
- `/qa` - Diff-aware QA testing
- `/ship` - Complete ship workflow
- `/browse` - Headless browser testing
- `/retro` - Weekly retrospectives

**Source**: https://github.com/garrytan/gstack
**Install**: `git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack`

**Note**: gstack is optional but highly recommended. See [docs/GSTACK_INSTALL.md](./docs/GSTACK_INSTALL.md) for detailed installation instructions. The cost optimizer works well without it, but gstack can double your savings.

### 5. GitNexus (Intelligent Navigation)
- Graph-powered code intelligence
- Pre-hooks for smart file/code search
- **GitHub**: https://github.com/abhigyanpatwari/GitNexus
- **Install**: `npm install -g gitnexus`

### 6. code-review-graph (MCP Server)
- AI-powered code review with knowledge graph
- Impact radius analysis for blast-radius detection
- Delta reviews and PR reviews with structural context
- **GitHub**: https://github.com/tirth8205/code-review-graph
- **Install**: See repository for MCP server setup

### 7. conversation-recorder
- Auto-saves conversations for resume
- Eliminates context re-explanation

### 8. Handy (Voice-to-Text) - Open Source
- Speak your prompts instead of typing (3x faster than typing)
- Faster input = faster iterations
- Better for complex explanations, fewer clarifications
- **Open source**: https://github.com/handy-app/handy
- Download from Mac App Store or https://handy.app
- Free and privacy-focused (local processing)

### 9. RTK (Token Killer)
- CLI proxy that compresses command output before the LLM sees it
- Sits transparently between Claude Code and shell commands via PreToolUse hook
- Supports git, cargo, pytest, npm, docker, kubectl, eslint, and more
- **GitHub**: https://github.com/rtk-ai/rtk
- **Install**: `brew install rtk` then `rtk init -g`

### 10. journal-recorder-agent (Session Logger)
- Auto-records coding sessions as rich, searchable journal entries
- Triggers proactively at end of conversations or after major milestones
- Captures: summary, commands run, key decisions, problems solved, next steps
- Entries written for "new engineer with zero context" — pick up exactly where you left off
- **GitHub**: https://github.com/GauravRatnawat/journal-recorder-agent
- **Install**: `curl -o ~/.claude/agents/journal-recorder.md https://raw.githubusercontent.com/GauravRatnawat/journal-recorder-agent/main/journal-recorder.md`

### 11. Caveman (Token Compression via Communication Style)
- Cuts ~75% of Claude's output tokens by responding in compressed "caveman" prose
- Full technical accuracy preserved — drops filler words, articles, hedging, pleasantries
- Intensity levels: `lite` (professional terse), `full` (classic caveman), `ultra` (abbreviations + arrows)
- Specialized modes: `/caveman-commit` (compressed commit messages), `/caveman-review` (one-line code review)
- **Plugin**: Install via `claude plugins install caveman@caveman` or vendor via `.claude/hooks/` (included in this repo)
- **Activate**: `/caveman` — deactivate: "stop caveman" or "normal mode"

### 12. Global Configuration
- `~/.claude/CLAUDE.md` with best practices
- Pre-authorized safe commands
- Standardized workflows

## Getting Started

Work through these stages in order. Each builds on the previous.

### Stage 1 — Core Setup (15 min) → ~20-30% cost reduction

- [ ] Run `./setup.sh` (or follow [Manual Setup](MANUAL_SETUP.md))
- [ ] Verify claudetop: `claudetop` shows a dashboard
- [ ] Verify model switching: `claude --model opusplan --print "hello"` responds
- [ ] Check your baseline: `claudetop --days 7 --summary`

**Expected result:** Model automatically switches to Sonnet/Haiku for non-planning tasks.

### Stage 2 — Token Compression (30 min) → additional ~40-50% reduction

- [ ] Install RTK: `brew install rtk && rtk init -g`
- [ ] Verify RTK: `rtk --version` and `rtk gain` both work
- [ ] Enable Caveman mode: type `/caveman` in Claude Code chat
- [ ] Check compression: `rtk gain` shows token savings accumulating

> ⚠️ RTK name collision risk: `brew install rtk` may install "Rust Type Kit" instead. If `rtk gain` fails, see the [RTK install notes](docs/02-tools-reference.md#rtk--token-killer).

**Expected result:** Terminal output compressed ~51% (RTK) + Claude responses compressed ~75% (Caveman).

### Stage 3 — Workflow Automation (1-2 hrs) → additional ~10-20% reduction

- [ ] Install gstack skills: see [GSTACK_INSTALL.md](docs/GSTACK_INSTALL.md)
- [ ] Try `/review` on a real project
- [ ] Try `/qa` before a commit
- [ ] Set up workspace isolation with [Conductor](docs/02-tools-reference.md#conductor) (optional but recommended)

**Expected result:** Multi-step workflows (review → test → commit) collapse into single commands.

---

## 🔑 Savings at a Glance: RTK

RTK compresses what Claude Code reads from the terminal. Before the LLM processes `cargo test` output, RTK strips noise, groups errors, deduplicates logs, and truncates boilerplate — returning a fraction of the original tokens.

Real-world data from 1,458 commands (run `rtk gain` to see your own):

| Command | Measured savings |
|---------|----------------|
| `ls` | 71.7% |
| `git diff` | 59–90% |
| `docker logs` | 73.2% |
| `make dev` | 92.2% |
| `ps aux` | 98.3% |
| Full session average | **51.0%** (514K tokens saved on 1.0M) |

```bash
brew install rtk
rtk init -g   # auto-hooks into Claude Code
rtk gain      # view accumulated savings
```

## 🎨 Optional: Advanced Enhancements

### everything-claude-code (ECC) - Community Harness
- 100+ skills, rules, agents, hooks, TDD workflows, and instinct learning — all in one install
- Covers Java, Kotlin, Python, Go, Rust, JS/TS, C++, and more
- **GitHub**: https://github.com/affaan-m/everything-claude-code (107k+ stars)
- **Install**: `npm install -g ecc-universal && ecc install --target claude java kotlin`
- **Commands**: `ecc doctor`, `ecc list-installed`, `ecc repair`
- **Full reference**: [docs/ECC_COMMANDS.md](./docs/ECC_COMMANDS.md)

### agency-agents (Specialized Personas)
- 100+ pre-built AI agent personas for role-specific tasks
- **GitHub**: https://github.com/msitarzewski/agency-agents
- **Benefit**: 10-20% additional savings through better-targeted prompts
- **Use cases**:
  - Engineering (frontend/backend devs, DevOps, security)
  - Design (UI/UX, brand strategy)
  - Marketing (SEO, content, social media)
  - QA Testing (accessibility, performance)
- **Setup**: Copy persona files to your project directory
- **Works with**: Claude Code (native), also Cursor, Aider, Windsurf

## 🛠️ Manual Setup (Alternative)

If you prefer to set things up manually, follow the [MANUAL_SETUP.md](./MANUAL_SETUP.md) guide.

## 📖 Configuration Files

- [`templates/CLAUDE.md`](./templates/CLAUDE.md) - Global instructions template
- [`templates/settings.json`](./templates/settings.json) - Model configuration
- [`templates/settings.local.json`](./templates/settings.local.json) - Permission presets
- [`templates/hooks.json`](./templates/hooks.json) - GitNexus integration

## 💡 Usage Tips

### Monitor Costs Daily
```bash
# Check today's spending
claudetop --today

# Interactive dashboard
claudetop
```

### Use Automation Skills
```bash
# Before merging a PR
/review

# Ship a feature (merge, test, changelog, PR - fully automated)
/ship

# QA test your app (diff-aware mode on feature branches)
/qa

# Weekly retrospective
/retro
```

### Workspace Best Practices
- Create separate Conductor workspaces for unrelated projects
- Name workspaces descriptively (e.g., `project-name-feature`)
- Archive completed workspaces to keep things clean

## 🔧 Customization

### Adjust Model Selection
Edit `~/.claude/settings.json`:
```json
{
  "model": "opusplan",  // or "sonnet", "opus", "haiku"
  "enabledPlugins": {}
}
```

### Customize Permissions
Edit `~/.claude/settings.local.json` to pre-authorize commands you trust:
```json
{
  "permissions": {
    "allow": [
      "Bash(npm install:*)",
      "Bash(git status:*)",
      "Bash(pytest:*)"
    ]
  }
}
```

### Add Custom Skills
```bash
# Link your custom skill
ln -s /path/to/your/skill ~/.claude/skills/your-skill-name
```

## 📈 Measuring Success

### Week 1: Baseline
```bash
claudetop --days 7 --summary
```

### After Setup: Compare
```bash
# View cost trends
claudetop --days 14

# Check token distribution by model
claudetop --json | jq '.sessions[] | {model, tokens, cost}'
```

## 🤝 Contributing

Found a cost optimization trick? PRs welcome!

## 📄 License

MIT

## 🙏 Credits

Setup based on real-world optimization of heavy Claude Code usage. Your results will depend on your usage patterns.

---

**Questions?** Check out:
- [QUICKSTART.md](./QUICKSTART.md) - Get started in 5 minutes
- [FAQ.md](./FAQ.md) - Common questions answered
- [docs/ALL_COMMANDS.md](./docs/ALL_COMMANDS.md) - Complete command reference for all tools
- [docs/ECC_COMMANDS.md](./docs/ECC_COMMANDS.md) - Everything Claude Code full reference
- [docs/VOICE_TO_TEXT.md](./docs/VOICE_TO_TEXT.md) - Voice input for faster prompts
- [docs/GSTACK_INSTALL.md](./docs/GSTACK_INSTALL.md) - Installing automation skills
- [docs/CREATING_SKILLS.md](./docs/CREATING_SKILLS.md) - Create your own skills
- [docs/COPILOT_INTEGRATION.md](./docs/COPILOT_INTEGRATION.md) - Use Copilot + Claude together
