# Claude Code Cost Optimizer

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

Prefer manual setup? See [MANUAL_SETUP.md](MANUAL_SETUP.md).

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

## Tools at a Glance

| Tool | Purpose | Install |
|------|---------|---------|
| opusplan | Smart model switching (Opus→Sonnet/Haiku) | Included in `setup.sh` |
| claudetop | Real-time cost monitoring | `npm install -g claudetop` |
| RTK | CLI output compression (51% savings) | `brew install rtk && rtk init -g` |
| Caveman | Claude response compression (~75%) | Vendored in this repo |
| Conductor | Workspace isolation | [Download](https://conductor.sh) |
| Handy | Voice-to-text input | [Install guide](docs/VOICE_TO_TEXT.md) |
| GitNexus | Graph-powered code intelligence | `npm install -g gitnexus` ([GitHub](https://github.com/abhigyanpatwari/GitNexus)) |
| gstack | Automation skills (/review, /qa, /ship) | [Install guide](docs/GSTACK_INSTALL.md) ([GitHub](https://github.com/garrytan/gstack)) |
| ECC | 100+ pre-built skills | [Reference](docs/ECC_COMMANDS.md) ([GitHub](https://github.com/affaan-m/everything-claude-code)) |
| journal-recorder-agent | Auto-save conversations | [GitHub](https://github.com/GauravRatnawat/journal-recorder-agent) |
| code-review-graph | AI code review MCP | [Docs](docs/ALL_COMMANDS.md) ([GitHub](https://github.com/tirth8205/code-review-graph)) |
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

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Share your measured cost savings — real data helps everyone.
