# Creating Custom Skills

Don't have access to gstack? Create your own automation skills!

## What is a Skill?

A Claude Code skill is a directory containing a `SKILL.md` file that defines:
- What the skill does
- What tools it can use
- Instructions for Claude to follow

## Basic Skill Structure

```
~/.claude/skills/
  my-skill/
    SKILL.md          # Required: Skill definition
    README.md         # Optional: User documentation
    templates/        # Optional: Templates or helpers
    examples/         # Optional: Example usage
```

## Creating Your First Skill

### Example: Simple PR Review Skill

```bash
# Create skill directory
mkdir -p ~/.claude/skills/simple-review
cd ~/.claude/skills/simple-review

# Create SKILL.md
cat > SKILL.md << 'EOF'
---
name: simple-review
version: 1.0.0
description: |
  Quick PR review focusing on common issues. Checks for:
  - Console.log statements
  - TODO comments
  - Missing error handling
  - Hardcoded values
allowed-tools:
  - Bash
  - Read
  - Grep
---

# Simple PR Review

You are reviewing a pull request. Follow these steps:

1. Get PR number from user or list open PRs:
   ```bash
   gh pr list
   ```

2. Get PR diff:
   ```bash
   gh pr diff <number>
   ```

3. Analyze the diff for:
   - **Console logs**: Look for console.log, print statements
   - **TODOs**: Find TODO, FIXME, HACK comments
   - **Error handling**: Missing try-catch, error checks
   - **Hardcoded values**: API keys, URLs, magic numbers
   - **Code duplication**: Repeated code blocks

4. Provide feedback in this format:

   ## 🔍 Quick Review

   ### ✅ Looks Good
   - [List positive findings]

   ### ⚠️ Issues Found
   - [Issue 1] - file.js:42
   - [Issue 2] - file.js:89

   ### 💡 Suggestions
   - [Suggestion 1]
   - [Suggestion 2]

Keep feedback concise and actionable.
EOF
```

### Test Your Skill

```bash
# Start Claude session
claude

# Try your skill
> /simple-review
```

## Skill Template

Here's a template for creating any skill:

```markdown
---
name: skill-name
version: 1.0.0
description: |
  Brief description of what this skill does.
  Can be multiple lines.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
---

# Skill Name

Brief intro about what this skill accomplishes.

## Steps

1. **First step**
   - Detail about what to do
   - Example command if needed

2. **Second step**
   - More details

3. **Final step**
   - Wrap up

## Output Format

Describe what format the output should be in.

## Examples

Show example usage if helpful.
```

## Useful Skill Ideas

### 1. Test Runner
```markdown
---
name: run-tests
version: 1.0.0
description: Run tests and analyze failures
allowed-tools: [Bash, Read]
---

# Test Runner

1. Run test suite: `npm test` or `pytest` or `cargo test`
2. If failures, analyze the output
3. Identify failing tests and suggest fixes
```

### 2. Dependency Updater
```markdown
---
name: update-deps
version: 1.0.0
description: Check for outdated dependencies
allowed-tools: [Bash, Read, Write]
---

# Dependency Updater

1. Check outdated: `npm outdated` or `pip list --outdated`
2. Identify security vulnerabilities
3. Suggest safe updates
```

### 3. Documentation Generator
```markdown
---
name: gen-docs
version: 1.0.0
description: Generate docs from code comments
allowed-tools: [Bash, Read, Write, Glob]
---

# Documentation Generator

1. Find all source files: Use Glob
2. Extract docstrings/JSDoc comments
3. Generate markdown documentation
4. Write to docs/ directory
```

### 4. Code Formatter
```markdown
---
name: format-code
version: 1.0.0
description: Format code and check style
allowed-tools: [Bash]
---

# Code Formatter

1. Run formatter: `npm run format` or `black .` or `rustfmt`
2. Run linter: `eslint` or `pylint` or `clippy`
3. Report any remaining issues
```

### 5. Git Helper
```markdown
---
name: git-commit
version: 1.0.0
description: Smart git commits with conventional commit format
allowed-tools: [Bash, Read]
---

# Git Commit Helper

1. Show git diff
2. Analyze changes
3. Generate conventional commit message:
   - feat: new feature
   - fix: bug fix
   - docs: documentation
   - refactor: code refactoring
4. Ask user to confirm
5. Commit with message
```

## Advanced Features

### Using Parameters

Skills can accept parameters:

```bash
# In Claude session
> /simple-review 123
```

Parse in skill:
```markdown
If a PR number is provided in args, use it.
Otherwise, list PRs with `gh pr list` and ask user to choose.
```

### Conditional Logic

```markdown
1. Check if in git repo:
   ```bash
   git status
   ```

2. If not in repo, warn user and exit
3. If in repo, continue with workflow
```

### Error Handling

```markdown
For each command:
- If it fails, explain the error to user
- Suggest fixes (e.g., "run npm install first")
- Ask if they want to continue or abort
```

### Multi-Step Workflows

```markdown
1. **Setup Phase**
   - Check prerequisites
   - Install dependencies if needed

2. **Execution Phase**
   - Run main task
   - Handle errors gracefully

3. **Cleanup Phase**
   - Report results
   - Suggest next steps
```

## Best Practices

### 1. Clear Descriptions
```markdown
❌ description: "Does stuff"
✅ description: "Analyzes PR for security issues and code quality"
```

### 2. Minimal Tool Access
```markdown
❌ allowed-tools: [Bash, Read, Write, Edit, Grep, Glob]
✅ allowed-tools: [Bash, Read]  # Only what you need
```

### 3. User Confirmation for Destructive Actions
```markdown
Before running `rm` or `git reset`:
1. Show what will be deleted
2. Ask user: "Proceed? [y/N]"
3. Only continue if confirmed
```

### 4. Clear Output Format
```markdown
## Output

Provide results in this format:
```
✅ Tests passed: 45/45
⏱️  Duration: 12.3s
```
```

### 5. Examples in Documentation
Create `README.md` in skill directory:
```markdown
# Simple Review Skill

## Usage

```bash
/simple-review          # Review current branch
/simple-review 123      # Review PR #123
```

## Example Output

[Show example]
```

## Testing Your Skills

### 1. Syntax Check
```bash
# Verify SKILL.md has valid frontmatter
head -10 ~/.claude/skills/my-skill/SKILL.md
```

### 2. Dry Run
Test in Claude session with mock data

### 3. Edge Cases
- Empty input
- Invalid PR numbers
- No git repo
- Network errors

## Sharing Your Skills

### 1. Documentation
- Clear README
- Usage examples
- Known limitations

### 2. Versioning
Update version in SKILL.md when making changes:
```markdown
version: 1.1.0  # Was 1.0.0
```

### 3. License
Add LICENSE file if sharing publicly

### 4. Publish
- GitHub repository
- Claude Code skill marketplace (if available)
- Blog post or tutorial

## Troubleshooting

### Skill Not Loading

**Check file structure**:
```bash
ls -la ~/.claude/skills/my-skill/
# Should have SKILL.md
```

**Check frontmatter**:
```bash
head -20 ~/.claude/skills/my-skill/SKILL.md
# Should have --- delimiters
```

### Skill Runs But Fails

**Add debug output**:
```markdown
Before each step:
1. Log what you're about to do
2. Run the command
3. Log the result
```

### Tools Not Available

**Check allowed-tools list**:
```markdown
allowed-tools:
  - Bash   # ← Make sure tool is listed
```

## Examples Repository

See the `examples/` directory in this repo for complete skill examples:

- `examples/skills/pr-review/` - Full PR review
- `examples/skills/test-runner/` - Test automation
- `examples/skills/doc-generator/` - Documentation
- `examples/skills/code-quality/` - Linting and formatting

## Resources

- Claude Code documentation: https://docs.anthropic.com
- Skill marketplace: (check claude.ai)
- Community skills: GitHub topic `claude-code-skill`

---

**Remember**: Skills are just instructions! Start simple and iterate based on usage.
