# Built-in Skills

Skills are slash-command workflows. Invoke with `/skill-name` in Claude Code chat,
or tell Claude: "Use the [skill-name] skill."

## Caveman Skills — Token Compression

| Skill | Command | Purpose | When to use |
|-------|---------|---------|-------------|
| caveman | `/caveman [lite\|full\|ultra\|wenyan]` | Compress Claude's output tokens ~75% while keeping full technical accuracy | Long sessions, large codebases |
| caveman-commit | `/caveman-commit` | Write terse Conventional Commits messages — subject ≤50 chars, body only when "why" isn't obvious | Every commit |
| caveman-review | `/caveman-review` | One-line PR review comments: location, problem, fix. Optional severity prefix (bug/risk/nit) | Quick code reviews |

### Caveman intensity levels

| Level | Style |
|-------|-------|
| `lite` | No filler/hedging, full sentences, professional but tight |
| `full` | Drop articles, fragments OK, short synonyms (default) |
| `ultra` | Abbreviate everything, arrows for causality (X → Y) |
| `wenyan` | Classical Chinese register (wenyan-lite / wenyan-full / wenyan-ultra) |

Stop any caveman mode: say `"stop caveman"` or `"normal mode"`.

## GitNexus Skills — Code Intelligence

Requires GitNexus MCP server. Run `npx gitnexus analyze` first to build the index.

| Skill | Purpose | When to use |
|-------|---------|-------------|
| gitnexus-exploring | Understand architecture, trace execution flows, "How does X work?" | New codebase, unfamiliar module |
| gitnexus-impact-analysis | Blast radius of a change, "What breaks if I change X?" | Before any non-trivial edit or commit |
| gitnexus-debugging | Trace why X is failing, follow an error to its source | Bug investigation |
| gitnexus-refactoring | Rename / extract / split / move code safely | Structural changes |
| gitnexus-guide | Full tool reference, MCP resources, graph schema | When stuck on the GitNexus API |
| gitnexus-cli | `analyze`, `status`, `clean`, `wiki` CLI commands | Index maintenance |

See [gitnexus/README.md](gitnexus/README.md) for prerequisites and usage details.

## Using a GitNexus Skill

Tell Claude which skill to apply:
> "Use the gitnexus-exploring skill to explain how authentication works."

Or reference the skill file directly in CLAUDE.md (see [CLAUDE.md](../../CLAUDE.md)).

## Creating Custom Skills

See [docs/CREATING_SKILLS.md](../../docs/CREATING_SKILLS.md) for a full tutorial.
