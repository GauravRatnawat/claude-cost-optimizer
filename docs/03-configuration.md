# Configuration Guide

Claude Code Cost Optimizer uses four configuration files. Each has a distinct role.

## Configuration Layers

```
┌─────────────────────────────────────────────────────┐
│  Layer 4: Project CLAUDE.md  (~/.claude/CLAUDE.md)  │
│  "What Claude should know about this project"        │
│  → Tool routing, efficiency guidelines, agent config │
├─────────────────────────────────────────────────────┤
│  Layer 3: Hooks  (~/.claude/hooks.json)              │
│  "Automatic pre-search before every tool call"       │
│  → GitNexus integration, search triggers             │
├─────────────────────────────────────────────────────┤
│  Layer 2: Permissions  (~/.claude/settings.local.json│
│  "Commands Claude can run without asking"            │
│  → Pre-approved git, npm, kubectl commands           │
├─────────────────────────────────────────────────────┤
│  Layer 1: Model  (~/.claude/settings.json)           │
│  "Which model to use by default"                     │
│  → opusplan: Opus for planning, Sonnet/Haiku for work│
└─────────────────────────────────────────────────────┘
```

## Layer 1: Model Selection (`settings.json`)

Controls which model Claude Code uses by default. The template sets `opusplan` — a routing preset that automatically escalates to Opus for complex planning tasks and falls back to Sonnet or Haiku for execution, without any manual `/model` switching.

```json
{
  "model": "opusplan",
  "enabledPlugins": {}
}
```

**What `opusplan` does:** Detects planning-heavy prompts (architecture, design, analysis) and routes them to Opus. Routine code generation and tool calls stay on cheaper models. Cost difference: Opus is ~15x more expensive than Haiku — routing intelligently is the single largest lever in the stack.

**Install location:** `~/.claude/settings.json`

---

## Layer 2: Permissions (`settings.local.json`)

Pre-approves safe, read-oriented shell commands so Claude Code doesn't prompt for permission on every invocation. Without this file, Claude asks before every `git diff` or `ls` — which is friction with no security benefit for read-only commands.

```json
{
  "permissions": {
    "allow": [
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(npm install:*)",
      "Bash(npm test:*)",
      "Bash(npm run:*)",
      "Bash(pytest:*)",
      "Bash(cargo test:*)",
      "Bash(make test:*)",
      "Bash(kubectl get:*)",
      "Bash(kubectl describe:*)",
      "Bash(docker ps:*)",
      "Bash(docker logs:*)",
      "Bash(curl:*)",
      "Bash(wget:*)",
      "Bash(which:*)",
      "Bash(ls:*)",
      "Bash(pwd:*)",
      "Bash(echo:*)",
      "Bash(cat:*)",
      "Bash(head:*)",
      "Bash(tail:*)"
    ]
  }
}
```

All entries are read-only or side-effect-free operations. Destructive commands (`git push`, `rm`, `kubectl delete`) are intentionally excluded — those still require explicit approval.

**Install location:** `~/.claude/settings.local.json`

**Important:** This file is `.gitignored` by design. It holds user-specific permission overrides that should not be committed to shared repos. Do not add it to version control.

---

## Layer 3: GitNexus Hooks (`hooks.json`)

Registers a `PreToolUse` hook that fires the GitNexus pre-search script before every `Grep`, `Glob`, or `Bash` tool call. GitNexus intercepts the call, checks the codebase graph for relevant files, and surfaces them — reducing exploratory search queries.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": {
          "tool_name": "Grep|Glob|Bash"
        },
        "hooks": [
          {
            "type": "command",
            "command": "node \"$(npm root -g)/gitnexus/hooks/claude/gitnexus-hook.cjs\"",
            "timeout": 8000
          }
        ]
      }
    ]
  }
}
```

**Install location:** `~/.claude/hooks.json`

**Dependency:** GitNexus must be installed globally (`npm install -g gitnexus`) and the repo must be indexed (`npx gitnexus analyze`) before this hook does anything useful. If GitNexus is not installed, the hook command will fail silently and tool calls will proceed normally.

---

## Layer 4: Global Instructions (`CLAUDE.md`)

Read by Claude Code at the start of every session. Sets the behavioral contract: cost strategy, model guidance, available skills, and efficiency rules. The template configures:

- **Cost optimization stance** — instructs Claude to reuse context, batch operations, and avoid tangential exploration
- **Model usage policy** — maps task types to model tiers (complex planning vs. routine execution)
- **Skills index** — lists available slash commands (`/review`, `/qa`, `/ship`, `/browse`, etc.) so Claude knows what automation is available without searching
- **GitNexus integration** — tells Claude to trust pre-hook suggestions for code navigation
- **Conversation recording** — instructs Claude to proactively save sessions via `conversation-recorder` to eliminate re-explanation in future sessions
- **Permission strategy** — primes Claude to explain purpose clearly when requesting new command approvals

**Install location:** `~/.claude/CLAUDE.md`

Changes take effect on the next session start. Edits mid-session are not picked up until Claude Code is restarted.

---

## Minimal vs Full Setup

| Config | Minimal | Full |
|--------|---------|------|
| settings.json | Required | Required |
| settings.local.json | Optional | Recommended |
| hooks.json | Skip if no GitNexus | With GitNexus |
| CLAUDE.md | Required | Required |

A minimal setup (settings.json + CLAUDE.md) gets you model routing and behavioral instructions. Add settings.local.json to eliminate permission prompts. Add hooks.json only after GitNexus is installed and indexed.

---

## Common Mistakes

**Wrong file location.** `settings.json` must live at `~/.claude/settings.json` — not in the project root. Claude Code reads only from `~/.claude/` for global config. A settings.json in your project directory is ignored entirely.

**Committing settings.local.json.** This file is deliberately excluded from version control. It holds machine-specific permission overrides. If you copy it into a shared repo, other team members inherit your permissions silently — a security concern.

**Installing hooks.json before GitNexus is ready.** The hook runs on every `Grep`, `Glob`, and `Bash` call. If the GitNexus binary is missing or the index is stale, each invocation adds latency with no benefit. Run `npx gitnexus analyze` first and confirm the index is fresh before enabling the hook.

**Editing CLAUDE.md and expecting immediate effect.** Claude Code reads `CLAUDE.md` once at session startup. Changes made during a running session are not picked up. Start a new session after any edits.

---

## Where the Templates Live

All templates are in `templates/` in this repo. `setup.sh` copies them to `~/.claude/` automatically.

To reconfigure manually: copy the relevant template, then edit to match your environment.

```bash
cp templates/settings.json ~/.claude/settings.json
cp templates/settings.local.json ~/.claude/settings.local.json
cp templates/hooks.json ~/.claude/hooks.json
cp templates/CLAUDE.md ~/.claude/CLAUDE.md
```

---
← [Tools Reference](02-tools-reference.md) | [Skills Guide →](04-skills-guide.md)
