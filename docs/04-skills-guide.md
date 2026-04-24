# Skills Guide

## What Are Skills?

Skills are slash-command workflows that chain together tool calls, file reads, and structured prompts into repeatable, single-invocation automations. Instead of re-describing a multi-step process every session, you invoke `/skill-name` and Claude follows a pre-written playbook — saving tokens on repeated instructions and reducing variation in outcomes. Skills live as directories under `~/.claude/skills/`, each containing a `SKILL.md` that defines the workflow.

## Built-in Skills

### Caveman Skills

Caveman skills compress Claude's output style. They do not change what Claude knows or reasons about — they change how Claude communicates. All three levels preserve full technical accuracy.

| Skill | Command | Purpose | When to Use |
|-------|---------|---------|-------------|
| caveman | `/caveman [lite\|full\|ultra]` | Switch response compression intensity | Anytime you want fewer output tokens. Default: `full` |
| caveman-commit | `/caveman-commit` | Generate compressed, precise commit messages | Before every commit — removes verbose commit ceremony |
| caveman-review | `/caveman-review` | One-line code review comments | During PR review — one finding per line, no padding |

**Intensity levels for `/caveman`:**

- `lite` — professional terse; reads like a senior engineer in a hurry
- `full` — classic caveman; drops articles, hedging, filler completely
- `ultra` — adds abbreviations and arrow notation; maximum compression

**Benchmark:** Caveman mode reduces output tokens by approximately 75% (documented in plugin benchmarks).

**Deactivate:** say `stop caveman` or `normal mode` in the chat.

---

### GitNexus Skills

GitNexus skills use the codebase knowledge graph to give Claude structural context before it searches or edits. Always read the relevant `SKILL.md` before starting a task — the workflow in each skill is optimized for the specific task type.

| Skill | Command / Path | Purpose | When to Use |
|-------|----------------|---------|-------------|
| gitnexus-exploring | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` | Understand architecture, answer "how does X work?" | First question on an unfamiliar codebase or module |
| gitnexus-impact-analysis | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` | Blast radius — what breaks if I change X? | Before refactoring, deleting, or renaming anything |
| gitnexus-debugging | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` | Trace bugs — why is X failing? | When a bug is hard to isolate or crosses multiple files |
| gitnexus-refactoring | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` | Rename / extract / split / restructure code | Planned refactoring with full dependency awareness |
| gitnexus-guide | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` | GitNexus tools, resources, and schema reference | When using GitNexus MCP tools directly |
| gitnexus-cli | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` | Index, status, clean, wiki CLI commands | Rebuilding index, checking freshness, running CLI ops |

**Important:** Before using any GitNexus skill, verify index freshness:

```bash
# Check if index is stale
npx gitnexus analyze

# Force rebuild if needed
gitnexus rebuild
```

The project CLAUDE.md maps tasks to the correct skill file — use it as a quick lookup table.

## Using Skills

**Invoke a skill** by typing the slash command in Claude Code chat:

```
/caveman
/caveman ultra
/caveman-commit
/caveman-review
```

For GitNexus skills, tell Claude which skill to read:

```
Read .claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md and follow its workflow for [your task]
```

**List installed skills:**

```bash
ls ~/.claude/skills/
```

**Check a specific skill's workflow:**

```bash
cat ~/.claude/skills/gstack/review/SKILL.md
```

## Creating Custom Skills

Skills are just directories with a `SKILL.md` file. A minimal skill has:

1. A directory under `~/.claude/skills/your-skill-name/`
2. A `SKILL.md` with the workflow steps, prompts, and tool call sequence

See [docs/CREATING_SKILLS.md](CREATING_SKILLS.md) for a complete walkthrough with examples.

---
← [Configuration](03-configuration.md) | [Advanced →](VOICE_TO_TEXT.md)
