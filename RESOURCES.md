# Resources & Links

## Official Tools

### Claude Code
- **CLI Installation**: `npm install -g @anthropic-ai/claude-code`
- **Documentation**: https://docs.anthropic.com/claude-code
- **GitHub**: https://github.com/anthropics/claude-code (if public)

### claudetop
- **GitHub**: https://github.com/GauravRatnawat/claudetop
- **Installation**: `npm install -g claudetop`
- **Purpose**: Real-time cost monitoring and token analytics
- **Author**: Gaurav Ratnawat
- **Features**: Daily summaries, burn rate alerts, JSON export

### GitNexus
- **GitHub**: https://github.com/abhigyanpatwari/GitNexus
- **Installation**: `npm install -g gitnexus`
- **Purpose**: Graph-powered code intelligence
- **Author**: Abhigyan Patwari
- **Features**: Architecture exploration, blast radius analysis, dependency tracking

### code-review-graph
- **GitHub**: https://github.com/tirth8205/code-review-graph
- **Installation**: MCP server integration
- **Purpose**: AI-powered code review with knowledge graph analysis
- **Author**: Tirth Patel
- **Features**: Impact radius analysis, delta reviews, PR reviews, semantic search, structural context

### RTK (Token Killer)
- **GitHub**: https://github.com/rtk-ai/rtk
- **Installation**: `brew install rtk` then `rtk init -g`
- **Purpose**: CLI proxy that intercepts and compresses command output before the LLM reads it
- **How it works**: Hooks into Claude Code via PreToolUse; transparently rewrites Bash calls
- **Command coverage**: git, gh, cargo, npm/pnpm, pytest, go test, rspec, docker, kubectl, eslint, tsc, prettier, ruff, rubocop, and more
- **Features**: Smart filtering, grouping, truncation, deduplication; `rtk gain` analytics; `rtk discover` for missed savings
- **Savings**: 60-90% per command, ~80% overall session reduction
- **Overhead**: <10ms, single Rust binary, zero dependencies
- **Supported AI tools**: Claude Code, GitHub Copilot, Cursor, Gemini CLI, Codex, Windsurf, Cline/Roo Code

## Skills & Plugins

### gstack (Automation Skills)
A collection of high-leverage automation workflows:
- `/review` - Pre-landing PR review
- `/qa` - Systematic QA testing
- `/ship` - Automated ship workflow
- `/browse` - Headless browser testing
- `/retro` - Engineering retrospectives

**GitHub**: https://github.com/garrytan/gstack
**Installation**: `git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack`
**Author**: Garry Tan
**Documentation**: See repository README for setup and usage

### conversation-recorder
- **Purpose**: Auto-saves conversations for later resume
- **Installation**: Available as a Claude Code skill
- **Benefits**: Eliminates context re-explanation, saves tokens

### Handy (Voice-to-Text) - Open Source
- **Purpose**: Convert speech to text for faster Claude Code input
- **GitHub**: https://github.com/handy-app/handy
- **Website**: https://handy.app
- **Installation**: Mac App Store or build from source
- **Benefits**: 3x faster input, better explanations, reduced typing fatigue
- **Cost**: FREE (open source)
- **Privacy**: Local processing, no cloud required
- **Cost savings**: Fewer iterations due to clearer initial prompts
- **Documentation**: See [docs/VOICE_TO_TEXT.md](./docs/VOICE_TO_TEXT.md)

### using-gitnexus
- **Purpose**: Guides usage of GitNexus MCP tools
- **Features**: Architecture exploration, blast radius analysis, safe refactoring
- **Documentation**: Included with GitNexus installation

## Advanced Tools (Optional)

### agency-agents
- **GitHub**: https://github.com/msitarzewski/agency-agents
- **Purpose**: Specialized AI agent personas for role-specific tasks
- **Installation**: Copy persona files to project or `~/.claude/` directory
- **Author**: Marcin Sitarzewski
- **Personas Available**: 100+ pre-built agents across multiple domains
  - **Engineering** (20+): Frontend/backend developers, DevOps, security engineers
  - **Design** (8): UI/UX designers, brand strategists, visual designers
  - **Marketing** (28+): Social media specialists, SEO experts, content creators
  - **Sales** (8): Outbound strategists, deal closers, proposal writers
  - **Testing** (8): QA testers, accessibility auditors, performance testers
  - **Product/Project**: Sprint managers, trend researchers, producers
  - **Specialized** (20+): Blockchain auditors, MCP builders, compliance experts
- **Cost Impact**: 10-20% additional savings through better-targeted prompts
- **Benefits**:
  - More accurate first-time responses
  - Fewer clarification iterations
  - Role-appropriate technical context
  - Reduced token waste on generic responses
- **Integration**: Native Claude Code support, also works with Cursor, Aider, Windsurf

## Workspace Management

### Conductor
- **Purpose**: Visual workspace isolation for different projects
- **Benefits**: Prevents context bleeding, project-specific configs
- **Availability**: Platform-dependent (check your app store or claude.ai)

## Learning Resources

### Blog Posts & Articles
- "Cost Optimization Strategies for Claude Code" (see your LinkedIn post!)
- Claude Code documentation on model selection
- Community discussions on cost efficiency

### Video Tutorials
- Setting up Claude Code for cost optimization
- Using automation skills effectively
- Understanding opusplan model switching

### Community
- **GitHub Discussions**: Share cost-saving strategies
- **Discord/Slack**: Claude Code community channels
- **Stack Overflow**: Tag `claude-code` for technical questions

## Related Tools

### Token Counting
- **tiktoken**: Count tokens before sending to API
- **claude-token-counter**: Estimate costs before operations

### Configuration Management
- **dotfiles**: Version control your `~/.claude/` configs
- **Ansible/Chef**: Automate team-wide Claude Code setup

### Monitoring & Analytics
- **Custom dashboards**: Build on top of `claudetop --json` output
- **Grafana**: Visualize token usage over time
- **Slack bots**: Daily cost notifications

## Example Projects

### Cost-Optimized Workflows
Examples of teams achieving significant cost reductions:
- 70% reduction with opusplan + skills automation
- 50% reduction with workspace isolation alone
- 85% reduction combining all strategies

### Custom Skills
Community-contributed skills:
- Database migration skill (automates multi-step migrations)
- Documentation generator (extracts docs from code)
- Test coverage analyzer (identifies untested code)

## Configuration Examples

### Enterprise Setup
- Team-wide permissions
- Shared skill library
- Centralized cost monitoring
- See `examples/enterprise/` (if available)

### Solo Developer Setup
- Minimal configuration
- Focus on automation skills
- Personal cost tracking
- See `examples/solo/` (if available)

### CI/CD Integration
- Claude Code in automated pipelines
- Cost-per-build tracking
- Automated code review
- See `examples/ci-cd/` (if available)

## Best Practices Documentation

### Model Selection Guide
When to use each model:
- **Opus**: Complex reasoning, architecture decisions, novel problems
- **Sonnet**: General development, code review, documentation
- **Haiku**: Simple queries, repetitive tasks, quick answers
- **opusplan**: Automatic switching (recommended)

### Permission Management
What to pre-authorize:
- ✅ Read-only commands (git status, ls, cat)
- ✅ Safe test commands (npm test, pytest)
- ✅ Non-destructive operations
- ❌ Destructive commands (rm -rf, git reset --hard)
- ❌ Network commands with side effects
- ❌ System-level changes

### Workspace Strategies
- One workspace per feature/project
- Archive completed workspaces weekly
- Use consistent naming conventions
- Keep workspace count under 10 active

## Troubleshooting Resources

### Common Issues
- "Command not found" errors → Check PATH configuration
- Skills not loading → Verify directory structure
- High costs despite setup → Check model distribution with `claudetop --json`
- GitNexus timeouts → Adjust timeout in hooks.json

### Debug Tools
```bash
# Check configuration
cat ~/.claude/settings.json
cat ~/.claude/settings.local.json
cat ~/.claude/hooks.json

# Verify installations
which claudetop
which gitnexus
claude --version

# Check skill structure
ls -la ~/.claude/skills/

# View recent costs
claudetop --days 7
```

## Contributing

Have a resource to add? See [CONTRIBUTING.md](./CONTRIBUTING.md)

## Stay Updated

- **Release notes**: Check Claude Code changelog
- **claudetop updates**: `npm update -g claudetop`
- **GitNexus updates**: `npm update -g gitnexus`
- **This repo**: Watch for updates to setup scripts and templates

---

**Last updated**: March 2026

**Maintained by**: Claude Code Cost Optimizer community
