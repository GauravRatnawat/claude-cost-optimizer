# How It Works

## The Problem

Claude Code charges per token — every character you read and write costs money. At light usage this is invisible. At scale it compounds fast: heavy users routinely see $5–10K/month before any optimization.

Three things drive most of the cost:

1. **Wrong model for the task** — Using Opus for a simple `npm install` is like hiring a senior architect to hang a picture frame. Execution work doesn't need that reasoning depth.
2. **Verbose terminal output** — `cargo test`, `docker logs`, `ps aux` dump thousands of lines. The LLM reads every token. Most of it is noise.
3. **Repeated manual workflows** — PR reviews, QA runs, ship checklists, retrospectives — done by hand each time, each time burning new context.

**My results:** $10K/month → $2.5K/month (75% reduction). Your mileage will vary based on usage patterns.

## The 3-Strategy Approach

### Strategy 1: Smart Model Switching (opusplan)

Not every task needs the most powerful model. opusplan mode automatically routes:

- **Opus** — complex planning, architecture decisions, ambiguous requirements
- **Sonnet** — execution, formatting, simple edits, boilerplate

You set `"model": "opusplan"` once in `~/.claude/settings.json`. From then on, the right model is chosen per task without any manual intervention. You get Opus quality where it matters, and pay Sonnet rates for everything else.

### Strategy 2: Token Compression (RTK + Caveman + Ponytail + Context-mode)

Four complementary tools attack the token problem from every angle:

**RTK (Token Killer)** — sits transparently between Claude Code and your shell via a `PreToolUse` hook. Before the LLM sees `git diff`, `docker logs`, or `pytest` output, RTK strips noise, groups errors, deduplicates logs, and truncates boilerplate. Real-world average: **51% savings** across terminal output (514K tokens saved across 1,458 commands).

**Context-mode** — keeps tool output entirely out of your conversation context. Raw bytes from `ctx_batch_execute` and `ctx_execute` stay in a sandbox; only what your code explicitly prints enters the conversation. Saves ~40% context per session on tool-heavy workflows.

**Caveman mode** — changes how Claude responds, not what it reads. Activating `/caveman` switches Claude to terse, compressed prose: full technical accuracy, no filler words, no hedging, no pleasantries. Benchmark: **~75% fewer output tokens**. Three intensity levels: `lite` (professional terse), `full` (classic caveman), `ultra` (abbreviations + arrows).

**Ponytail mode** — enforces lazy-efficient responses: no speculative abstractions, no boilerplate, no over-engineering. Stops Claude from generating code and explanations you didn't ask for. Compounds with Caveman for maximum output compression.

Together these four cover every angle: CLI input (RTK), context management (Context-mode), and output style (Caveman + Ponytail).

### Strategy 3: Workflow Automation (gstack skills)

Repetitive multi-step workflows are replaced with single slash commands:

- `/review` — automated PR review (catches SQL safety, trust boundaries, structural issues)
- `/qa` — diff-aware QA testing after feature implementation
- `/ship` — full ship workflow: merge, test, changelog, PR (replaces 50+ manual queries)
- `/browse` — headless browser for web research and testing
- `/retro` — weekly retrospectives

Without gstack: baseline savings from model switching and token compression (~40–50%). With gstack: savings increase to 60–70% by eliminating repetitive query overhead.

## Component Overview

```
┌─────────────────────────────────────────────────────────┐
│                    Your Claude Code session              │
└──────────────────────────┬──────────────────────────────┘
                           │
          ┌────────────────▼────────────────┐
          │         MONITORING LAYER         │
          │  claudetop — real-time cost &    │
          │  token dashboard, burn alerts    │
          └────────────────┬────────────────┘
                           │
          ┌────────────────▼────────────────┐
          │       MODEL SWITCHING LAYER      │
          │  opusplan — routes Opus/Sonnet/  │
          │  Haiku per task automatically    │
          └────────────────┬────────────────┘
                           │
          ┌────────────────▼────────────────┐
          │       COMPRESSION LAYER          │
          │  RTK — compresses terminal       │
          │  output (PreToolUse hook, 51%)   │
          │  Context-mode — sandboxes tool   │
          │  outputs (~40% ctx reduction)    │
          │  Caveman + Ponytail — compress   │
          │  responses (output style, ~75%)  │
          └────────────────┬────────────────┘
                           │
          ┌────────────────▼────────────────┐
          │       AUTOMATION LAYER           │
          │  gstack skills — /review /qa     │
          │  /ship /browse /retro            │
          │  ECC — 100+ skills & agents      │
          └────────────────┬────────────────┘
                           │
          ┌────────────────▼────────────────┐
          │       CONTEXT QUALITY LAYER      │
          │  GitNexus — graph-powered code   │
          │  nav, prevents wasteful search   │
          │  Conductor — workspace isolation │
          │  conversation-recorder — session │
          │  resume, no re-explanation waste │
          └─────────────────────────────────┘
```

## Real Results

All numbers below are measured, not estimated:

| Source | Metric | Measured value |
|--------|--------|---------------|
| RTK | Terminal output compression | **51% average** (514K tokens saved / 1.0M) |
| RTK | `ps aux` | 98.3% reduction |
| RTK | `make dev` | 92.2% reduction |
| RTK | `docker logs` | 73.2% reduction |
| RTK | `git diff` | 59–90% reduction |
| Caveman | Output token reduction | **~75%** (plugin benchmarks) |
| Combined (my usage) | Monthly cost | **$10K → $2.5K (75%)** |

Run `rtk gain` at any time to see your own accumulated savings.

---
← [README](../README.md) | [Tools Reference →](02-tools-reference.md)
