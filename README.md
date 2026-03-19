# Claude Code Cost Optimizer Setup

A complete setup for running Claude Code with 70% cost reduction while maintaining (or improving) productivity.

## 🎯 What You'll Get

- **Smart model selection** with opusplan mode (Opus for planning, Sonnet/Haiku for execution)
- **Real-time cost monitoring** with claudetop
- **Workspace isolation** with Conductor
- **High-leverage automation** with gstack skills (/review, /qa, /ship, /browse, /retro)
- **Intelligent code navigation** with GitNexus
- **Automatic conversation persistence**
- **Pre-authorized commands** for common operations

## 📊 Expected Results

- **70% lower API costs** (typical: $180/day → $65/day at same workload)
- **10x faster shipping** with automated workflows
- **Better code quality** with automated reviews
- **Complete spending visibility** with real-time monitoring

## 🚀 Quick Start

```bash
# Download or clone this setup
# Option 1: Clone from GitHub (after you publish it)
# git clone https://github.com/YOUR-USERNAME/claude-cost-optimizer.git

# Option 2: Download and extract ZIP
# Then navigate to the directory
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
- Install: `npm install -g claudetop`

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
- Install: `npm install -g gitnexus`

### 6. conversation-recorder
- Auto-saves conversations for resume
- Eliminates context re-explanation

### 7. Handy (Voice-to-Text) - Open Source
- Speak your prompts instead of typing (3x faster than typing)
- Faster input = faster iterations
- Better for complex explanations, fewer clarifications
- **Open source**: https://github.com/handy-app/handy
- Download from Mac App Store or https://handy.app
- Free and privacy-focused (local processing)

### 8. Global Configuration
- `~/.claude/CLAUDE.md` with best practices
- Pre-authorized safe commands
- Standardized workflows

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

Setup inspired by real-world Claude Code usage optimizations that achieved 70% cost reduction.

---

**Questions?** Check out:
- [QUICKSTART.md](./QUICKSTART.md) - Get started in 5 minutes
- [FAQ.md](./FAQ.md) - Common questions answered
- [RESOURCES.md](./RESOURCES.md) - Links to tools and documentation
- [docs/VOICE_TO_TEXT.md](./docs/VOICE_TO_TEXT.md) - Voice input for faster prompts
- [docs/GSTACK_INSTALL.md](./docs/GSTACK_INSTALL.md) - Installing automation skills
- [docs/CREATING_SKILLS.md](./docs/CREATING_SKILLS.md) - Create your own skills
