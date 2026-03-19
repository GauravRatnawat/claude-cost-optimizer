# Installing gstack Automation Skills

gstack provides high-leverage automation workflows that significantly reduce Claude Code costs by replacing repetitive manual tasks.

## What is gstack?

gstack is a collection of automation skills for Claude Code created by Garry Tan.

**Repository**: https://github.com/garrytan/gstack

**Skills included:**
- **/review** - Automated PR reviews (catches security issues, code quality problems)
- **/qa** - Systematic QA testing with diff-aware mode
- **/ship** - Complete ship workflow (merge, test, changelog, commit, push, PR)
- **/browse** - Headless browser testing (~100ms per command)
- **/retro** - Weekly engineering retrospectives
- **/plan-ceo-review** - CEO-level project planning
- **/plan-eng-review** - Engineering planning review

Each skill replaces 50-100+ queries with a single command.

## Installation Methods

### Method 1: Check Existing Installation

gstack may already be installed on your system:

```bash
# Check if gstack is already in Claude skills
ls ~/.claude/skills/gstack

# If found, you're already set!
```

### Method 2: Install from GitHub (Recommended)

gstack is available as an open-source project on GitHub.

**Quick Install:**
```bash
# Clone directly to Claude skills directory
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack

# Install dependencies (gstack uses bun or npm)
cd ~/.claude/skills/gstack
bun install 2>/dev/null || npm install

# Verify installation
ls -la ~/.claude/skills/gstack/
# Should see: review/, qa/, ship/, browse/, retro/, etc.
```

#### Option B: Install from GitHub
```bash
# Clone gstack from official repository
git clone https://github.com/garrytan/gstack ~/.claude/skills/gstack

# Navigate to gstack directory
cd ~/.claude/skills/gstack

# Install dependencies (if needed)
npm install 2>/dev/null || bun install 2>/dev/null || true

# Verify installation
ls -la ~/.claude/skills/gstack/
```

**Source**: https://github.com/garrytan/gstack

#### Option B: Alternative Installation Locations

If you prefer a different location:
```bash
# Clone to your preferred directory
git clone https://github.com/garrytan/gstack ~/gstack

# Then link to Claude skills
ln -s ~/gstack ~/.claude/skills/gstack

# Or clone to a project directory
git clone https://github.com/garrytan/gstack /path/to/your/projects/gstack
ln -s /path/to/your/projects/gstack ~/.claude/skills/gstack
```

### Method 3: Create Your Own Skills

If gstack isn't available, you can create similar skills yourself:

```bash
mkdir -p ~/.claude/skills/my-automation
cd ~/.claude/skills/my-automation
```

Create `SKILL.md`:
```markdown
---
name: my-review
version: 1.0.0
description: Custom PR review workflow
allowed-tools:
  - Bash
  - Read
  - Grep
---

# PR Review Workflow

Steps:
1. Get PR diff: `gh pr diff <number>`
2. Analyze changes for common issues
3. Generate review comments
```

See [CREATING_SKILLS.md](./CREATING_SKILLS.md) for a complete guide.

## Verification

After installation, verify gstack is working:

```bash
# Check installation
ls -la ~/.claude/skills/gstack

# Should see:
# drwxr-xr-x  review/
# drwxr-xr-x  qa/
# drwxr-xr-x  ship/
# drwxr-xr-x  browse/
# drwxr-xr-x  retro/

# Start Claude and test
claude

# In session, try:
> /review
```

## Troubleshooting

### Skills Not Loading

**Issue**: `/review` command not recognized

**Fix**:
```bash
# Check skill structure
cat ~/.claude/skills/gstack/review/SKILL.md

# Verify it has proper frontmatter:
# ---
# name: review
# version: 1.0.0
# ---
```

### Permission Errors

**Issue**: "Permission denied" when accessing skills

**Fix**:
```bash
chmod -R 755 ~/.claude/skills/gstack
```

### Skills from Different Source

**Issue**: You have gstack but it's in a different location

**Fix**:
```bash
# Link it to Claude skills directory
ln -s /path/to/your/gstack ~/.claude/skills/gstack
```

## Alternative: Use Without gstack

You can still achieve significant cost savings without gstack:

### Manual Workflows
Instead of `/review`, create manual workflows:
```bash
# PR Review
gh pr diff <number> | pbcopy
# Then paste into Claude and ask for review
```

### Simple Custom Skills
Create basic skills for your most common tasks:
```bash
mkdir -p ~/.claude/skills/quick-review
cat > ~/.claude/skills/quick-review/SKILL.md << 'EOF'
---
name: quick-review
version: 1.0.0
description: Quick PR review
allowed-tools: [Bash, Read]
---
Run: gh pr diff and analyze for obvious issues
EOF
```

### Use Other Automation
- Pre-commit hooks for code quality
- GitHub Actions for automated checks
- Shell aliases for common operations

## Cost Impact

**With gstack**:
- Each skill saves 50-100+ queries
- Typical usage: 5-10 skill invocations/day
- **Savings**: 250-1000 queries/day = 30-50% cost reduction

**Without gstack**:
- You still get 40-50% savings from other optimizations:
  - opusplan model: 60% on execution
  - claudetop monitoring: Better awareness
  - Voice-to-text: Fewer iterations
  - Conversation recording: Context preservation

## Alternatives to gstack

While gstack is powerful, there are alternatives:

### 1. GitHub CLI Workflows
```bash
# Create aliases
alias pr-review='gh pr diff | claude review'
alias run-qa='npm test && claude analyze-results'
```

### 2. Claude Code Agents
Use the Task tool to create custom agents:
```
> Create a review agent that analyzes my PR diff for security issues
```

### 3. MCP Servers
Build custom Model Context Protocol servers for your workflows

### 4. IDE Extensions
- Claude Code VS Code extension
- JetBrains plugin
- Vim/Emacs integrations

## Stay Updated

Keep gstack up to date:

```bash
# Navigate to gstack directory
cd ~/.claude/skills/gstack

# Pull latest changes
git pull origin main

# Update dependencies
bun install 2>/dev/null || npm install
```

**Watch for updates:**
- Star the repository: https://github.com/garrytan/gstack
- Watch releases on GitHub
- Follow @garrytan on Twitter for announcements

## Need Help?

If you have access to gstack but need help installing:

1. Check `gstack/README.md` if you have the source
2. Run `gstack --help` if it's a CLI tool
3. Open an issue in this repo: We can help troubleshoot
4. Contact Anthropic support for official guidance

---

**Bottom line**: gstack is optional but highly valuable. The cost optimizer works well without it, but adding gstack can double your savings. Install it when available, or create your own automation in the meantime!
