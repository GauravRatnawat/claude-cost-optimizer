# Manual Setup Guide

If you prefer to set things up step-by-step, follow this guide.

## Prerequisites

- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Node.js and npm installed
- Git installed

## Step 1: Install Cost Monitoring (claudetop)

```bash
npm install -g claudetop
```

Test it:
```bash
claudetop --today
```

## Step 2: Install GitNexus

```bash
npm install -g gitnexus
```

## Step 3: Configure Model Selection

Create or edit `~/.claude/settings.json`:

```json
{
  "model": "opusplan",
  "enabledPlugins": {}
}
```

This enables automatic model switching:
- Opus for complex planning
- Sonnet/Haiku for execution

## Step 4: Set Up Global Instructions

Create `~/.claude/CLAUDE.md`:

```markdown
# Global Instructions

## Conversation Recording

Automatically save every conversation using the conversation-recorder skill after completing significant work or when the conversation reaches a natural stopping point.

## Web Browsing

Use the /browse skill from gstack for all web browsing tasks.

## Efficiency Guidelines

1. Reuse context from previous conversations
2. Batch operations when possible
3. Use skills over manual workflows
4. Stay focused on the task
5. Trust specialized tools
```

## Step 5: Configure Permissions

Create `~/.claude/settings.local.json`:

```json
{
  "permissions": {
    "allow": [
      "Bash(git status:*)",
      "Bash(npm test:*)",
      "Bash(pytest:*)",
      "Bash(curl:*)"
    ]
  }
}
```

Add commands you frequently use and trust.

## Step 6: Set Up GitNexus Hooks

Create `~/.claude/hooks.json`:

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

## Step 7: Install gstack Skills

```bash
# Clone gstack (or get it from the official source)
git clone <gstack-repo-url> ~/.claude/skills/gstack

# Or if you have it locally
ln -s /path/to/gstack ~/.claude/skills/gstack
```

This gives you:
- `/review` - PR review automation
- `/qa` - QA testing automation
- `/ship` - Ship workflow automation
- `/browse` - Headless browser
- `/retro` - Weekly retrospectives

## Step 8: Install conversation-recorder

```bash
# Link or clone conversation-recorder skill
ln -s /path/to/conversation-recorder ~/.claude/skills/conversation-recorder
```

## Step 9: Install Conductor (Optional)

Download and install Conductor for workspace isolation:
- Visit conductor.app or search your app store
- Create workspaces for different projects
- Use naming convention: `project-name-feature`

## Step 10: Verify Installation

```bash
# Check Claude Code
claude --version

# Check cost monitoring
claudetop --today

# Check GitNexus
gitnexus --version

# List installed skills
ls -la ~/.claude/skills/
```

## Step 11: Start Using

Start a new Claude Code session:

```bash
claude
```

Try the automation skills:
```
/review    # Review current PR
/qa        # Test your app
/ship      # Complete ship workflow
```

Monitor costs:
```bash
claudetop --today
```

## Customization

### Adjust Pre-authorized Commands

Edit `~/.claude/settings.local.json` and add commands you trust:

```json
{
  "permissions": {
    "allow": [
      "Bash(your-command:*)"
    ]
  }
}
```

### Add Custom Skills

Create a new directory in `~/.claude/skills/` with a `SKILL.md` file.

### Modify Global Instructions

Edit `~/.claude/CLAUDE.md` to add project-specific guidelines.

## Troubleshooting

### "Command not found" errors

Make sure npm global bin is in your PATH:
```bash
echo 'export PATH="$(npm root -g)/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### GitNexus hook not working

Check the hook path:
```bash
ls "$(npm root -g)/gitnexus/hooks/claude/gitnexus-hook.cjs"
```

### Skills not loading

Verify skill directory structure:
```bash
ls -la ~/.claude/skills/gstack/
# Should contain SKILL.md files
```

## Next Steps

1. Use Claude Code for 1 week with the new setup
2. Monitor costs daily with `claudetop --today`
3. Compare weekly costs: `claudetop --days 7`
4. Fine-tune permissions and settings based on your workflow

Expected result: ~70% cost reduction with improved productivity!
