# GitNexus Skills

These 6 skills use the GitNexus knowledge graph to navigate and analyze code.

## Prerequisites

1. GitNexus MCP server installed: `npm install -g gitnexus`
2. Index built: `npx gitnexus analyze` (run in project root)
3. Claude Code configured with GitNexus MCP (see [CLAUDE.md](../../../CLAUDE.md))

> If `gitnexus://repo/{name}/context` reports the index is stale, re-run `npx gitnexus analyze`.

## Skills

| Skill | Task | Read this skill |
|-------|------|----------------|
| gitnexus-exploring | Understand architecture / "How does X work?" | [gitnexus-exploring/SKILL.md](gitnexus-exploring/SKILL.md) |
| gitnexus-impact-analysis | Blast radius / "What breaks if I change X?" | [gitnexus-impact-analysis/SKILL.md](gitnexus-impact-analysis/SKILL.md) |
| gitnexus-debugging | Trace bugs / "Why is X failing?" | [gitnexus-debugging/SKILL.md](gitnexus-debugging/SKILL.md) |
| gitnexus-refactoring | Rename / extract / split / refactor | [gitnexus-refactoring/SKILL.md](gitnexus-refactoring/SKILL.md) |
| gitnexus-guide | Tools, resources, schema reference | [gitnexus-guide/SKILL.md](gitnexus-guide/SKILL.md) |
| gitnexus-cli | Index, status, clean, wiki CLI commands | [gitnexus-cli/SKILL.md](gitnexus-cli/SKILL.md) |

## How to Use

Tell Claude: `"Use the gitnexus-[name] skill to [task]."`

All skills follow the same pattern:
1. Read `gitnexus://repo/{name}/context` to check index freshness
2. Run the skill-specific workflow (query → context → trace)
3. Report findings

## CLI Quick Reference

```bash
npx gitnexus analyze          # Build or refresh the index
npx gitnexus analyze --force  # Force full re-index
npx gitnexus status           # Check index freshness
```

← [All Skills](../README.md)
