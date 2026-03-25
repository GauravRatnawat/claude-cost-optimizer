# Complete Command Reference — All Tools

Every command for every tool in the Claude Code Cost Optimizer stack, organized by step.

---

## Step 1: Installation

### claudetop
```bash
npm install -g claudetop
claudetop --version
```

### GitNexus
```bash
npm install -g gitnexus
gitnexus --version
```

### RTK (Token Killer)
```bash
brew install rtk
rtk --version
which rtk                     # Verify correct binary (not Rust Type Kit)
```

### ECC (Everything Claude Code)
```bash
npm install -g ecc-universal
ecc --help
```

### gstack (Automation Skills)
```bash
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack
```

### journal-recorder-agent
```bash
curl -o ~/.claude/agents/journal-recorder.md \
  https://raw.githubusercontent.com/GauravRatnawat/journal-recorder-agent/main/journal-recorder.md
```

### code-review-graph (MCP Server)
```bash
# See https://github.com/tirth8205/code-review-graph for MCP server setup
```

---

## Step 2: RTK — Hook Into Claude Code

### Initialize hooks
```bash
rtk init -g                   # Global Claude Code hook (recommended)
rtk init                      # Local project only
rtk init -g --auto-patch      # Skip confirmation prompts
rtk init -g --hook-only       # Hook only, no RTK.md injected
rtk init -g --no-patch        # Print manual instructions instead

# Other AI tools
rtk init -g --agent cursor    # Cursor IDE
rtk init -g --agent windsurf  # Windsurf IDE
rtk init -g --agent cline     # Cline / Roo Code
rtk init -g --opencode        # Also install OpenCode plugin
rtk init -g --gemini          # Gemini CLI instead of Claude Code
rtk init -g --codex           # Codex CLI (uses AGENTS.md + RTK.md)

# Show current config
rtk init --show

# Remove RTK artifacts
rtk init -g --uninstall
```

### Verify hook setup
```bash
rtk verify                    # Verify hook integrity + inline TOML tests
rtk hook-audit                # Show hook rewrite audit metrics (needs RTK_HOOK_AUDIT=1)
```

### Trust project-local filters
```bash
rtk trust                     # Trust TOML filters in current directory
rtk untrust                   # Revoke trust
```

### Analytics
```bash
rtk gain                      # Token savings summary
rtk gain --history            # Recent command history with savings
rtk gain --graph              # ASCII graph of daily savings
rtk gain --daily              # Detailed daily breakdown
rtk gain --weekly             # Weekly breakdown
rtk gain --monthly            # Monthly breakdown
rtk gain --all                # All time breakdowns
rtk gain --quota              # Monthly quota savings estimate
rtk gain --quota --tier pro   # For Pro tier (also: 5x, 20x)
rtk gain --project            # Filter to current project
rtk gain --format json        # JSON output
rtk gain --format csv         # CSV output

rtk cc-economics              # Claude Code spending vs RTK savings
rtk cc-economics --daily
rtk cc-economics --weekly
rtk cc-economics --monthly
rtk cc-economics --all
rtk cc-economics --format json

rtk discover                  # Find missed savings from Claude history
rtk discover --all            # All projects (not just current)
rtk discover --since 7        # Last 7 days
rtk discover --limit 20       # Max commands per section
rtk discover --format json

rtk session                   # RTK adoption across Claude sessions
rtk learn                     # Learn CLI corrections from error history
```

### Configuration
```bash
rtk config                    # Show or create config file
```

### Using RTK commands directly
```bash
# Git (compact output)
rtk git status
rtk git diff
rtk git log
rtk git add .
rtk git commit -m "msg"
rtk git push
rtk git pull
rtk git branch
rtk git fetch
rtk git stash list
rtk git worktree list
rtk git show HEAD

# GitHub CLI
rtk gh pr list
rtk gh pr view 123
rtk gh issue list

# Tests (show only failures)
rtk test cargo test
rtk test pytest
rtk test npm test
rtk pytest                    # Pytest specialist
rtk cargo test                # Cargo specialist
rtk go test ./...             # Go specialist

# Build tools
rtk tsc                       # TypeScript compiler (grouped errors)
rtk lint                      # ESLint (grouped violations)
rtk prettier                  # Format checker
rtk ruff check .              # Ruff linter
rtk mypy .                    # Mypy type checker
rtk cargo build               # Cargo build
rtk go build ./...            # Go build
rtk dotnet build              # .NET build
rtk dotnet test               # .NET tests

# Package managers
rtk npm run build
rtk pnpm install
rtk pip install -r requirements.txt
rtk deps                      # Summarize project dependencies

# Docker / Kubernetes
rtk docker ps
rtk docker build .
rtk kubectl get pods
rtk kubectl logs <pod>

# AWS
rtk aws s3 ls

# Database
rtk psql -c "SELECT ..."

# File operations
rtk ls
rtk ls -la
rtk tree
rtk find . -name "*.java"
rtk read path/to/file
rtk grep "pattern" src/
rtk diff HEAD~1

# Misc
rtk curl https://api.example.com/endpoint
rtk env                       # Show env vars (sensitive masked)
rtk log                       # Filter/deduplicate logs
rtk json                      # Show JSON structure without values
rtk smart <command>           # 2-line heuristic summary
rtk err <command>             # Show only errors/warnings
rtk summary <command>         # Heuristic summary of any command
rtk proxy <command>           # Raw execution (no filtering, still tracked)

# Frontend
rtk next build
rtk vitest run
rtk playwright test
rtk prisma migrate dev
rtk npx tsc

# Graph tools
rtk gt stack
rtk golangci-lint ./...

# Download
rtk wget https://example.com/file
rtk wc -l src/**/*.java
```

---

## Step 3: GitNexus — Code Intelligence

### Setup
```bash
gitnexus setup                # One-time MCP config for Claude Code, Cursor, OpenCode
```

### Index a repository
```bash
gitnexus analyze              # Index current repo
gitnexus analyze /path/to/repo
gitnexus analyze --force      # Force full re-index
gitnexus analyze --embeddings # Enable semantic search (off by default)
```

### Query the knowledge graph
```bash
gitnexus status               # Index status for current repo
gitnexus list                 # List all indexed repositories

gitnexus query "payment processing"
gitnexus query "auth flow" --repo my-repo
gitnexus query "user login" --context "fixing bug" --goal "find entry point"
gitnexus query "order service" --limit 10
gitnexus query "cache layer" --content  # Include full symbol source

gitnexus context PaymentService
gitnexus context processOrder --file src/orders/OrderService.java
gitnexus context MyClass --uid <uid>    # Direct UID lookup
gitnexus context PaymentService --content

gitnexus impact PaymentService          # Blast radius analysis
gitnexus impact processOrder --direction upstream    # What depends on it
gitnexus impact processOrder --direction downstream  # What it depends on
gitnexus impact PaymentService --depth 5
gitnexus impact PaymentService --include-tests

gitnexus cypher "MATCH (n:Function) RETURN n LIMIT 10"
gitnexus cypher "MATCH (n)-[r]->(m) WHERE n.name='foo' RETURN n,r,m" --repo my-repo

gitnexus augment "processPayment"      # Augment pattern with graph context (used by hooks)
```

### Wiki generation
```bash
gitnexus wiki                 # Generate wiki from knowledge graph
gitnexus wiki /path/to/repo
gitnexus wiki --force         # Force full regeneration
gitnexus wiki --gist          # Publish as public GitHub Gist
gitnexus wiki --model claude-sonnet-4-6
gitnexus wiki --concurrency 5
```

### MCP server
```bash
gitnexus mcp                  # Start MCP server (stdio)
gitnexus serve                # Start local HTTP server for web UI
gitnexus eval-server          # Lightweight HTTP server for fast tool calls
```

### Maintenance
```bash
gitnexus clean                # Delete index for current repo
gitnexus clean --force        # Skip confirmation
gitnexus clean --all          # Clean all indexed repos
```

---

## Step 4: claudetop — Cost Monitoring

### Interactive dashboard
```bash
claudetop                     # Open full TUI dashboard
```

### Non-interactive / scripting
```bash
claudetop --today             # Today's summary and exit
claudetop --summary           # One-line summary and exit
claudetop --json              # Full data as JSON

claudetop --days 7            # Last 7 days
claudetop --days 30           # Last 30 days
claudetop --since 14          # Last 14 days (alias)

claudetop --project my-app    # Filter to a specific project
claudetop --model opus        # Filter by model name

claudetop --sort tokens       # Sort by tokens (default)
claudetop --sort cost         # Sort by cost
claudetop --sort date         # Sort by date
claudetop --sort queries      # Sort by query count
claudetop --sort model        # Sort by model

claudetop --no-color          # Disable color output
claudetop --no-insights       # Skip insight generation (faster)
claudetop --version
```

### Dashboard keyboard shortcuts
```
1–7     Switch views (7 = Analytics)
j/k     Navigate up/down
↑↓      Navigate up/down
Enter   Expand / drill-down
/       Search
s       Cycle sort
r       Refresh
?       Help overlay
q       Quit
```

### Common pipelines
```bash
claudetop --json | jq '.totals'
claudetop --json | jq '.sessions[].model'
claudetop --json | jq '.sessions[] | {model, tokens, cost}'
claudetop --days 7 --summary
claudetop --days 14 --sort cost
```

---

## Step 5: ECC — Everything Claude Code

> See [ECC_COMMANDS.md](./ECC_COMMANDS.md) for the full reference.

### Quick install
```bash
ecc install --target claude java kotlin
ecc install --target claude --profile developer java kotlin
ecc install --target claude --profile full
```

### Manage
```bash
ecc list-installed
ecc doctor
ecc repair
ecc repair --dry-run
ecc uninstall --target claude --dry-run
ecc uninstall --target claude
```

### Explore
```bash
ecc plan --list-profiles
ecc plan --list-modules
ecc plan --list-components
ecc plan --profile developer --target claude
```

### Sessions & status
```bash
ecc sessions
ecc sessions --limit 10
ecc status
ecc session-inspect claude:latest
```

---

## Step 6: gstack Skills (in Claude sessions)

Skills are invoked inside a Claude Code session:

### PR & code review
```bash
/review             # Pre-landing PR review (SQL safety, LLM trust boundary, structural issues)
/review-pr          # Full PR review with blast-radius analysis (code-review-graph)
/review-delta       # Review only changes since last commit (token-efficient)
```

### QA & testing
```bash
/qa                 # Systematic QA — find bugs, fix iteratively, commit each fix
/qa-only            # Report-only QA — structured report, no fixes
/browse             # Headless browser: navigate, interact, screenshot, verify
```

### Shipping
```bash
/ship               # Full ship: merge base, run tests, bump VERSION, update CHANGELOG, create PR
/land-and-deploy    # Merge PR, wait for CI and deploy, verify production health
```

### Planning
```bash
/plan               # Restate requirements, assess risks, step-by-step implementation plan
/autoplan           # CEO + design + eng reviews sequentially with auto-decisions
/plan-ceo-review    # CEO/founder-mode: rethink problem, challenge premises, expand scope
/plan-eng-review    # Eng manager-mode: lock in execution plan, architecture, data flow, edge cases
/plan-design-review # Designer's eye: rates design dimensions 0-10, fixes plan
/design-consultation # Proposes complete design system (aesthetic, typography, color, layout)
/design-review      # Designer's eye QA: finds visual inconsistency, spacing, hierarchy issues
```

### Retrospective & analysis
```bash
/retro              # Weekly engineering retrospective: commit history, patterns, metrics
/office-hours       # YC Office Hours: startup mode or code review mode
```

### Code review graph (MCP)
```bash
/build-graph        # Build or update the code review knowledge graph
```

### Code quality & debugging
```bash
/investigate        # Systematic debugging: investigate, analyze, hypothesize, implement
/careful            # Warn before rm -rf, DROP TABLE, force-push, git reset --hard
/guard              # Full safety: destructive warnings + directory-scoped edits
/freeze             # Restrict file edits to specific directory for session
/unfreeze           # Clear freeze boundary
/cso                # Chief Security Officer: secrets, supply chain, CI/CD, LLM security audit
```

### Deployment & monitoring
```bash
/setup-deploy       # Configure deployment settings for /land-and-deploy
/canary             # Post-deploy monitoring: console errors, performance, page failures
/benchmark          # Performance regression detection: page load, Core Web Vitals
```

### Browser
```bash
/browse             # Fast headless browser: navigate, interact, verify, screenshot
/gstack             # Alias for /browse
/setup-browser-cookies # Import cookies from real Chromium browser into headless session
```

### Session management
```bash
/commit             # Smart commit: stage, write message, commit
```

### Superpowers workflow
```bash
/brainstorm         # Explore intent, requirements, and design before implementation
/plan               # Write implementation plan before touching code
/tdd                # Test-driven development workflow
/review-pr          # Request code review with graph context
/careful            # Safety guardrails mode
```

---

## Step 7: code-review-graph MCP Tools (via Claude)

Used automatically by Claude when the MCP server is configured:

```
build-graph         # Build or update knowledge graph
get-review-context  # Get structural context for review
get-impact-radius   # Blast radius for changed files
find-large-functions # Identify oversized functions
semantic-search-nodes # Semantic search across nodes
query-graph         # Raw graph queries
embed-graph         # Embed graph for semantic search
list-graph-stats    # Graph statistics
get-docs-section    # Retrieve documentation sections
```

---

## Configuration Files

```bash
~/.claude/settings.json        # Model config (opusplan, permissions)
~/.claude/settings.local.json  # Local overrides, pre-authorized commands
~/.claude/CLAUDE.md            # Global instructions for Claude
~/.claude/hooks.json           # GitNexus and RTK hooks
~/.claude/rules/               # ECC-managed rules (common/, java/, kotlin/, etc.)
~/.claude/skills/              # Skill files
~/.claude/agents/              # Agent files (e.g., journal-recorder.md)
~/.claude/ecc/install-state.json  # ECC install state
~/.claude/sessions/            # Saved conversation sessions
~/claude-journal/              # journal-recorder-agent entries
```

### Model configuration
```json
// ~/.claude/settings.json
{
  "model": "opusplan"
}
```

### Pre-authorize common commands
```json
// ~/.claude/settings.local.json
{
  "permissions": {
    "allow": [
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(npm test:*)",
      "Bash(mvn test:*)",
      "Bash(gradle test:*)",
      "Bash(pytest:*)",
      "Bash(ls:*)",
      "Bash(cat:*)",
      "Bash(claudetop:*)",
      "Bash(rtk gain:*)"
    ]
  }
}
```

---

## Troubleshooting

```bash
# Tool not found
npm config get prefix           # Check npm global bin path
echo $PATH                      # Verify it includes npm bin

# RTK name collision (Rust Type Kit vs Token Killer)
which rtk
rtk gain                        # Should work, not "command not found"
rtk --version

# claudetop not showing data
ls ~/.claude/projects/          # Verify Claude Code session data exists
claudetop --json | jq keys      # Check JSON structure

# ECC drift
ecc doctor --target claude
ecc repair --target claude

# GitNexus index stale
gitnexus status
gitnexus analyze --force

# Skills not loading in Claude session
ls ~/.claude/skills/            # Verify skill directories exist
ls ~/.claude/rules/             # Verify ECC rules installed

# High costs despite setup
claudetop --json | jq '.sessions[].model'  # Check model distribution
cat ~/.claude/settings.json               # Verify opusplan is set
rtk gain                                  # Check RTK is saving tokens
```

---

**See also:**
- [ECC_COMMANDS.md](./ECC_COMMANDS.md) — Full ECC reference
- [GSTACK_INSTALL.md](./GSTACK_INSTALL.md) — gstack installation
- [CREATING_SKILLS.md](./CREATING_SKILLS.md) — Custom skills
- [VOICE_TO_TEXT.md](./VOICE_TO_TEXT.md) — Voice input setup
- [COPILOT_INTEGRATION.md](./COPILOT_INTEGRATION.md) — GitHub Copilot + Claude

**Last updated**: March 2026
