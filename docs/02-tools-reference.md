# Tools Reference

## Quick Comparison

| Tool | Purpose | Install | Key Command | Deep Dive |
|------|---------|---------|-------------|-----------|
| opusplan | Auto-routes Opus/Sonnet/Haiku per task | Edit `~/.claude/settings.json` | `"model": "opusplan"` | — |
| claudetop | Real-time token & cost dashboard | `npm install -g claudetop` | `claudetop --today` | — |
| RTK | CLI output compression via PreToolUse hook | `brew install rtk && rtk init -g` | `rtk gain` | — |
| Caveman | Response compression (~75% fewer output tokens) | `claude plugins install caveman@caveman` | `/caveman` | — |
| Conductor | Isolated workspaces per project | Download from conductor.app | GUI | — |
| Handy | Voice-to-text prompt input | Download from handy.app | Push-to-talk | [VOICE_TO_TEXT.md](VOICE_TO_TEXT.md) |
| conversation-recorder | Auto-saves sessions for resume | `curl` install (see below) | Automatic | — |
| GitNexus | Graph-powered code intelligence | `npm install -g gitnexus` | `gitnexus rebuild` | — |
| code-review-graph | AI code review MCP server | See GitHub repo | MCP tools | — |
| gstack | Automation skill suite (/review /qa /ship etc.) | `git clone ...gstack ~/.claude/skills/gstack` | `/review` `/ship` | [GSTACK_INSTALL.md](GSTACK_INSTALL.md) |
| ECC | 100+ skills, rules, agents, hooks | `npm install -g ecc-universal && ecc install` | `ecc doctor` | [ECC_COMMANDS.md](ECC_COMMANDS.md) |
| agency-agents | 100+ role-specific agent personas | Copy persona files to `~/.claude/` | Per-persona | — |

---

## Tool Details

### opusplan

**Purpose:** Automatically switches between Opus (complex planning), Sonnet, and Haiku (execution) without manual model selection. Use expensive models only when reasoning depth is needed.

```bash
# Enable in ~/.claude/settings.json
{
  "model": "opusplan"
}
```

**Key commands:**
- Set once — no per-session commands needed
- Override per-session: `/model opus`, `/model sonnet`, `/model haiku`

---

### claudetop

**Purpose:** Real-time token usage dashboard with daily/weekly cost tracking and burn rate visibility. Reads from Claude Code's local stats cache — 100% accurate for local usage.

```bash
npm install -g claudetop
```

**Key commands:**
- `claudetop` — interactive dashboard
- `claudetop --today` — today's spending
- `claudetop --days 7` — weekly trend
- `claudetop --json` — machine-readable output for scripting

GitHub: https://github.com/GauravRatnawat/claudetop

---

### RTK (Token Killer)

**Purpose:** Transparent CLI proxy that compresses terminal output before the LLM reads it. Sits between Claude Code and shell via a `PreToolUse` hook. Supports git, cargo, pytest, npm, docker, kubectl, eslint, and more.

```bash
brew install rtk
rtk init -g   # installs global PreToolUse hook into Claude Code
```

**Key commands:**
- `rtk gain` — view accumulated token savings
- `rtk gain --history` — per-command savings history
- `rtk discover` — analyze Claude Code history for missed opportunities
- `rtk proxy <cmd>` — run a command without filtering (debug mode)

**Measured savings:** 51% average across 1,458 commands (514K tokens saved on 1.0M input).

GitHub: https://github.com/rtk-ai/rtk

---

### Caveman Mode

**Purpose:** Cuts ~75% of Claude's output tokens by switching to compressed "caveman" prose — full technical accuracy, zero filler words, articles, hedging, or pleasantries.

```bash
claude plugins install caveman@caveman
# OR: vendored in this repo via .claude/hooks/
```

**Key commands:**
- `/caveman` — activate (defaults to `full` intensity)
- `/caveman lite` — professional terse
- `/caveman full` — classic caveman
- `/caveman ultra` — abbreviations + arrows
- `/caveman-commit` — compressed commit messages
- `/caveman-review` — one-line code review comments
- `stop caveman` or `normal mode` — deactivate

See [Skills Guide](04-skills-guide.md) for full caveman skill reference.

---

### Conductor

**Purpose:** Isolated workspaces per project. Prevents context bleeding between unrelated projects — without isolation, Claude sees history from other projects and wastes tokens on irrelevant context.

```bash
# Download from:
# conductor.app (macOS)
# or your system's app store
```

**Key commands:** GUI-based workspace switching. Use naming convention `project-name-feature`.

Note: Conductor availability varies by region/platform. Optional but recommended.

---

### Handy (Voice-to-Text)

**Purpose:** Speak prompts instead of typing — 3x faster input, better for complex explanations, fewer clarifications needed. Local processing, privacy-focused, open source.

```bash
# Download from:
# https://handy.app (macOS)
# https://github.com/handy-app/handy (open source)
```

**Key commands:** Push-to-talk hotkey (configured in app). Works system-wide — use in any Claude Code context.

Deep dive: [docs/VOICE_TO_TEXT.md](VOICE_TO_TEXT.md)

---

### conversation-recorder

**Purpose:** Auto-saves every conversation with summary, commands run, key decisions, problems solved, and next steps. Triggers proactively at end of sessions or after major milestones. Eliminates context re-explanation when resuming work.

```bash
curl -o ~/.claude/agents/journal-recorder.md \
  https://raw.githubusercontent.com/GauravRatnawat/journal-recorder-agent/main/journal-recorder.md
```

**Key commands:** Automatic — invoked by Claude at session end. Configure journal folder location once on first run.

GitHub: https://github.com/GauravRatnawat/journal-recorder-agent

---

### GitNexus

**Purpose:** Builds a graph of your codebase (files, functions, imports) and surfaces relevant files before Claude searches. Prevents wasteful exploratory searches. Updates automatically via pre-hooks on file changes.

```bash
npm install -g gitnexus
```

**Key commands:**
- `gitnexus rebuild` — force rebuild the codebase graph
- `npx gitnexus analyze` — analyze and index the repo
- `gitnexus --version` — verify installation

Best language support: JavaScript/TypeScript, Python, Go, Rust, Java.

GitHub: https://github.com/abhigyanpatwari/GitNexus

See [Skills Guide](04-skills-guide.md) for GitNexus skill reference.

---

### code-review-graph

**Purpose:** AI-powered code review MCP server with knowledge graph backing. Provides impact radius analysis (blast-radius detection), delta reviews, and PR reviews with structural context.

```bash
# See repository for MCP server setup:
# https://github.com/tirth8205/code-review-graph
```

**Key commands:** Exposed as MCP tools — available in Claude Code after server is configured:
- `build_or_update_graph_tool` — index the codebase
- `get_impact_radius_tool` — blast radius for a change
- `get_review_context_tool` — smart context for code review

GitHub: https://github.com/tirth8205/code-review-graph

---

### gstack Skills

**Purpose:** Pre-built automation workflows that replace hours of manual multi-step work with single slash commands.

```bash
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack
cd ~/.claude/skills/gstack
bun install 2>/dev/null || npm install
```

**Key commands:**
- `/review` — automated PR review (structural issues, SQL safety, trust boundaries)
- `/qa` — diff-aware QA testing
- `/ship` — full ship workflow (merge, test, changelog, PR — replaces 50+ queries)
- `/browse` — headless browser for web research and testing
- `/retro` — weekly retrospective

Deep dive: [docs/GSTACK_INSTALL.md](GSTACK_INSTALL.md)

---

### ECC (Everything Claude Code)

**Purpose:** Community harness with 100+ skills, rules, agents, hooks, TDD workflows, and instinct learning in one install. Covers Java, Kotlin, Python, Go, Rust, JS/TS, C++, and more.

```bash
npm install -g ecc-universal
ecc install --target claude java kotlin   # add languages as needed
```

**Key commands:**
- `ecc doctor` — check installation health
- `ecc list-installed` — show installed components
- `ecc repair` — fix broken installations

GitHub: https://github.com/affaan-m/everything-claude-code (107k+ stars)

Deep dive: [docs/ECC_COMMANDS.md](ECC_COMMANDS.md)

---

### agency-agents

**Purpose:** 100+ pre-built AI agent personas for role-specific tasks. Specialized personas give more accurate first-time responses, reducing iterations and token waste.

```bash
# Setup: copy persona files to your project or ~/.claude/ directory
# See: https://github.com/msitarzewski/agency-agents
```

**Key commands:** Reference the persona file in your CLAUDE.md or load at session start.

**Available categories:**
- Engineering (frontend/backend devs, DevOps, security)
- Design (UI/UX, brand strategy)
- Marketing (SEO, content, social media)
- QA Testing (accessibility, performance)

**Cost impact:** 10–20% additional savings through better-targeted prompts.

GitHub: https://github.com/msitarzewski/agency-agents

---
← [How It Works](01-how-it-works.md) | [Configuration →](03-configuration.md)
