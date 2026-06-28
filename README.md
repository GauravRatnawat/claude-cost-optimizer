# Claude Code Cost Optimizer

**[gauravratnawat.com/claude-cost-optimizer](https://gauravratnawat.com/claude-cost-optimizer/)** · [GitHub](https://github.com/GauravRatnawat/claude-cost-optimizer)

Reduce Claude Code API costs by **40–75%** through model switching, token compression, and workflow automation.

> Measured results: $10K/month → $2.5K/month (author). RTK: 51% token reduction on terminal output. Caveman: ~75% fewer output tokens.

## Prerequisites

- Claude Code CLI installed
- Node.js 18+ and npm
- macOS (Linux/WSL partially supported)
- Git

## Install

```bash
git clone https://github.com/GauravRatnawat/claude-cost-optimizer.git
cd claude-cost-optimizer
./setup.sh
```

`setup.sh` installs everything in one run:
- `claudetop` + `gitnexus` via npm
- `rtk` via brew + hook wired into Claude Code
- Claude plugins: `caveman`, `ponytail`, `context-mode`, `code-review-graph` (via settings.json)
- `journal-recorder-agent` via curl
- `gstack` skills if already cloned
- `BMAD` via `npx bmad-method` (49 skills → `.claude/skills/`)

Prefer manual setup? See [MANUAL_SETUP.md](MANUAL_SETUP.md).

## Getting Started

Work through these stages in order. Each builds on the previous.

### Stage 1 — Run setup.sh → ~20-30% cost reduction

```bash
./setup.sh
```

Installs and configures everything automatically. Then verify:

- [ ] `claudetop --today` shows a dashboard
- [ ] `rtk gain` shows compression stats
- [ ] `rtk --version` prints the RTK version (not "Rust Type Kit")
- [ ] Check your baseline: `claudetop --days 7 --summary`

> ⚠️ RTK name collision: if `rtk gain` fails after install, see [RTK install notes](docs/02-tools-reference.md#rtk-token-killer).

**Expected result:** Model switches to Sonnet for non-planning tasks. RTK compressing terminal output. Plugins queued for next session.

### Stage 2 — Activate plugins in Claude → additional ~50-60% reduction

Start a new Claude session. The plugins installed by setup.sh activate automatically. Enable them:

- [ ] Type `/caveman` in Claude chat (response compression, ~75%)
- [ ] Type `/ponytail` in Claude chat (efficient responses, no over-engineering)
- [ ] Verify context-mode: `ctx stats` shows tool outputs being sandboxed

**Expected result:** Terminal output compressed ~51% (RTK) + responses compressed ~75% (Caveman + Ponytail) + tool outputs sandboxed (~40% context reduction, Context-mode).

### Stage 3 — Workflow automation → additional ~10-20% reduction

- [ ] Install gstack: see [GSTACK_INSTALL.md](docs/GSTACK_INSTALL.md), then try `/review` and `/qa`
- [ ] Build code-review-graph index: type `/code-review-graph:build-graph` in Claude chat
- [ ] BMAD auto-installed by `setup.sh` — activate with `/bmad-help` in Claude chat
- [ ] Set up workspace isolation with [Conductor](docs/02-tools-reference.md#conductor) (optional)

**Expected result:** Multi-step workflows (review → test → commit) collapse into single commands.

---

## Tools at a Glance

| Tool | Purpose | Install |
|------|---------|---------|
| opusplan | Smart model switching (Opus→Sonnet) | Included in `setup.sh` |
| claudetop | Real-time cost monitoring | `npm install -g claudetop` |
| RTK | CLI output compression (51% savings) | `brew install rtk && rtk init -g` |
| Caveman | Claude response compression (~75%) | `claude plugins install caveman@caveman` |
| Ponytail | Lazy-efficient responses (no over-engineering) | `claude plugins install ponytail@ponytail` |
| Context-mode | Sandboxes tool output — never enters context | `claude plugins install context-mode@context-mode` |
| Conductor | Workspace isolation | [Download](https://conductor.sh) |
| Handy | Voice-to-text input | [Install guide](docs/VOICE_TO_TEXT.md) |
| GitNexus | Graph-powered code intelligence | `npm install -g gitnexus` ([GitHub](https://github.com/abhigyanpatwari/GitNexus)) |
| gstack | Automation skills (/review, /qa, /ship) | [Install guide](docs/GSTACK_INSTALL.md) ([GitHub](https://github.com/garrytan/gstack)) |
| ECC | 100+ pre-built skills | [Reference](docs/ECC_COMMANDS.md) ([GitHub](https://github.com/affaan-m/everything-claude-code)) |
| journal-recorder-agent | Auto-save conversations | [GitHub](https://github.com/GauravRatnawat/journal-recorder-agent) |
| code-review-graph | AI code review with knowledge graph (MCP plugin) | `claude plugins install code-review-graph@code-review-graph` |
| Serena | Semantic code navigation MCP | Via MCP server config |
| BMAD | Structured agile AI dev (specialist agent roles) | `npx bmad-method` |
| agency-agents | 100+ agent personas | [GitHub](https://github.com/msitarzewski/agency-agents) · See [Tools Reference](docs/02-tools-reference.md) |

Full install commands and deep dives: [docs/02-tools-reference.md](docs/02-tools-reference.md)

## Documentation

| Doc | Read when |
|-----|-----------|
| [How It Works](docs/01-how-it-works.md) | Want to understand the approach |
| [Tools Reference](docs/02-tools-reference.md) | Looking up install/commands for a tool |
| [Configuration](docs/03-configuration.md) | Setting up or modifying config files |
| [Skills Guide](docs/04-skills-guide.md) | Using built-in Caveman or GitNexus skills |
| [Voice to Text](docs/VOICE_TO_TEXT.md) | Setting up Handy for voice input |
| [gstack Install](docs/GSTACK_INSTALL.md) | Installing /review, /qa, /ship workflows |
| [ECC Reference](docs/ECC_COMMANDS.md) | Everything Claude Code skills reference |
| [Creating Skills](docs/CREATING_SKILLS.md) | Building custom skill workflows |
| [Copilot Integration](docs/COPILOT_INTEGRATION.md) | Using Copilot + Claude together |
| [All Commands](docs/ALL_COMMANDS.md) | Complete command reference |
| [FAQ](FAQ.md) | Troubleshooting and Q&A |
| [Manual Setup](MANUAL_SETUP.md) | Step-by-step setup without setup.sh |

## Measuring Savings

```bash
claudetop --days 7 --summary   # Weekly cost summary
rtk gain                        # RTK token compression stats
rtk gain --history              # Full command history with savings
```

## About

Built by [Gaurav Ratnawat](https://gauravratnawat.com). Landing page at [gauravratnawat.com/claude-cost-optimizer](https://gauravratnawat.com/claude-cost-optimizer/).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Share your measured cost savings — real data helps everyone.
