# Everything Claude Code (ECC) — Complete Command Reference

**GitHub**: https://github.com/affaan-m/everything-claude-code
**Website**: https://ecc.tools
**Version**: 1.9.0

---

## Installation

```bash
# Install globally via npm
npm install -g ecc-universal

# Verify install
ecc --help
```

---

## Step 1: Install Content into Claude Code

### Basic install by language

```bash
# Single language
ecc install --target claude java

# Multiple languages
ecc install --target claude java kotlin

# All supported languages
ecc install --target claude java kotlin javascript typescript python go rust cpp
```

### Install by profile

Profiles are curated module bundles:

| Profile    | Modules | Description |
|------------|---------|-------------|
| `core`     | 6       | Minimal harness: commands, hooks, platform configs, quality workflow |
| `developer`| 9       | Default for most engineers working across app codebases |
| `security` | 7       | Security-heavy setup with security-specific guidance |
| `research` | 9       | Investigation, synthesis, and publishing workflows |
| `full`     | 19      | Complete ECC install — all modules |

```bash
# Install a profile
ecc install --target claude --profile core
ecc install --target claude --profile developer
ecc install --target claude --profile security
ecc install --target claude --profile research
ecc install --target claude --profile full

# Profile + language
ecc install --target claude --profile developer java kotlin
```

### Install by module

```bash
# List all available modules
ecc plan --list-modules

# Install specific modules
ecc install --target claude --modules rules-core,agents-core,commands-core
ecc install --target claude --modules workflow-quality,framework-language
```

### Install by component

```bash
# List all available components
ecc plan --list-components

# Install with specific components included/excluded
ecc install --target claude java --with capability:security
ecc install --target claude java --with capability:database --with capability:devops
ecc install --target claude java --without baseline:hooks
```

### Available language components

```bash
lang:java        # Java + Spring Boot
lang:kotlin      # Kotlin, Ktor, Exposed, Coroutines, Compose Multiplatform
lang:typescript  # TypeScript, frontend/backend
lang:python      # Python, Django
lang:go          # Go
lang:rust        # Rust
lang:swift       # Swift, SwiftUI, Apple platforms
lang:cpp         # C++
lang:perl        # Perl
```

### Available capability components

```bash
capability:database       # Database and persistence skills
capability:security       # Security review and guidance
capability:research       # Deep research and API integration
capability:content        # Business writing and investor comms
capability:orchestration  # Worktree/tmux multi-agent orchestration
capability:agentic        # Autonomous loops and LLM pipeline optimization
capability:devops         # Docker, deployment, infrastructure
capability:documents      # Document processing and conversion
```

### Available framework components

```bash
framework:react      # React-focused guidance
framework:nextjs     # Next.js-focused guidance
framework:django     # Django-focused guidance
framework:springboot # Spring Boot-focused guidance
framework:laravel    # Laravel patterns, TDD, security
```

### Install targets (for other tools)

```bash
ecc install --target claude      # ~/.claude/ (default)
ecc install --target cursor      # ./.cursor/ in current project
ecc install --target antigravity # ./.agent/ in current project
ecc install --target codex       # OpenAI Codex
ecc install --target opencode    # Opencode
```

### Dry-run (preview without applying)

```bash
ecc install --target claude java kotlin --dry-run
ecc install --target claude --profile developer --dry-run

# Output as JSON
ecc install --target claude java --dry-run --json
```

---

## Step 2: Plan & Inspect (Before Installing)

```bash
# List all available profiles
ecc plan --list-profiles

# List all modules
ecc plan --list-modules

# List all components (with family filter)
ecc plan --list-components
ecc plan --list-components --family language
ecc plan --list-components --family capability
ecc plan --list-components --family baseline

# Preview what a profile resolves to
ecc plan --profile developer --target claude

# Preview what specific modules resolve to
ecc plan --modules rules-core,framework-language --target claude

# Output as JSON
ecc plan --profile full --target claude --json

# Install from a config file
ecc install --config ecc-install.json
```

---

## Step 3: Verify Installation

```bash
# List what is currently installed
ecc list-installed

# JSON output (for scripting)
ecc list-installed --json

# For a specific target
ecc list-installed --target claude
ecc list-installed --target cursor
```

---

## Step 4: Health & Diagnostics

```bash
# Diagnose missing or drifted files
ecc doctor

# For a specific target
ecc doctor --target claude
ecc doctor --target cursor

# JSON output
ecc doctor --json
```

---

## Step 5: Repair Drifted Files

```bash
# Restore any missing/drifted ECC-managed files
ecc repair

# Dry-run first to preview
ecc repair --dry-run

# For a specific target
ecc repair --target claude
ecc repair --target cursor

# JSON output
ecc repair --json
```

---

## Maintenance & Monitoring

### Session tracking

```bash
# View recent ECC sessions from state store
ecc sessions

# Limit to last N sessions
ecc sessions --limit 10

# JSON output
ecc sessions --json

# Inspect a specific session
ecc sessions <session-id>

# Inspect latest Claude history snapshot
ecc session-inspect claude:latest

# JSON snapshot
ecc session-inspect claude:latest --json
```

### State store status

```bash
# Query ECC SQLite state store
ecc status

# JSON output
ecc status --json

# Limit entries
ecc status --limit 20

# Custom DB path
ecc status --db /path/to/custom.db
```

---

## Uninstall

```bash
# Remove all ECC-managed files for Claude
ecc uninstall --target claude

# Dry-run first
ecc uninstall --target claude --dry-run

# Remove for a specific target
ecc uninstall --target cursor
ecc uninstall --target antigravity

# JSON output
ecc uninstall --target claude --json
```

---

## Legacy Compatibility

```bash
# Legacy install entrypoint (same as ecc install)
ecc-install java kotlin

# Route args directly to install (no subcommand needed)
ecc java kotlin
ecc typescript python
```

---

## Common Workflows

### Initial setup (Java + Kotlin developer)

```bash
npm install -g ecc-universal
ecc install --target claude java kotlin
ecc list-installed
ecc doctor
```

### Add capabilities after initial install

```bash
# Add security and database skills
ecc install --target claude java kotlin --with capability:security --with capability:database

# Add DevOps skills
ecc install --target claude --with capability:devops
```

### Upgrade to a fuller profile

```bash
ecc install --target claude --profile developer java kotlin
ecc list-installed
```

### Weekly maintenance

```bash
# Check for drift
ecc doctor --target claude

# Repair if needed
ecc repair --target claude

# Check session analytics
ecc sessions --limit 20
```

### Full reinstall

```bash
ecc uninstall --target claude
ecc install --target claude --profile developer java kotlin
ecc doctor
```

---

## Skills Unlocked (Java + Kotlin install)

After `ecc install --target claude java kotlin`, these skills become available in Claude Code:

| Skill | Purpose |
|-------|---------|
| `kotlin-patterns` | Idiomatic Kotlin patterns and best practices |
| `kotlin-testing` | Kotest, MockK, coroutine testing |
| `kotlin-build` | Fix Kotlin/Gradle build errors |
| `kotlin-review` | Comprehensive Kotlin code review |
| `kotlin-test` | TDD workflow for Kotlin |
| `kotlin-coroutines-flows` | Coroutines and Flow patterns |
| `kotlin-ktor-patterns` | Ktor server patterns |
| `kotlin-exposed-patterns` | JetBrains Exposed ORM patterns |
| `compose-multiplatform-patterns` | Compose Multiplatform / Jetpack Compose |
| `android-clean-architecture` | Clean Architecture for Android/KMP |
| `springboot-patterns` | Spring Boot architecture and REST API |
| `springboot-tdd` | TDD with JUnit 5, Mockito, MockMvc |
| `springboot-verification` | Build, static analysis, test verification |
| `java-coding-standards` | Java coding standards for Spring Boot |
| `gradle-build` | Fix Gradle build errors for Android/KMP |
| `tdd-workflow` | Universal TDD workflow |
| `verification-loop` | Code quality verification |
| `continuous-learning` | Extract reusable patterns from sessions |
| `eval-harness` | Regression testing for AI-assisted dev |
| `strategic-compact` | Context compaction for long sessions |

---

## Supported Targets Summary

| Target | Config Location | Use Case |
|--------|----------------|----------|
| `claude` | `~/.claude/` | Claude Code (default) |
| `cursor` | `./.cursor/` | Cursor IDE (per-project) |
| `antigravity` | `./.agent/` | Antigravity agent |
| `codex` | OpenAI Codex | Codex CLI |
| `opencode` | Opencode | Opencode CLI |

---

**Last updated**: March 2026
