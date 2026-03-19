# Contributing to Claude Code Cost Optimizer

Thanks for your interest in improving Claude Code cost efficiency!

## How to Contribute

### 1. Share Your Results

Open an issue with:
- Your baseline costs (before setup)
- Your costs after 1 week
- Percentage reduction
- Your usage pattern (light/heavy development, team size, etc.)

This helps validate and improve our cost estimates.

### 2. Submit Cost Optimizations

Found a new way to save tokens or costs? Share it!

**What we're looking for:**
- Configuration tweaks that reduce costs
- New pre-authorized commands that reduce friction
- Custom skills that automate token-heavy workflows
- Better default settings

**How to submit:**
1. Fork the repo
2. Create a branch: `git checkout -b optimization/your-optimization-name`
3. Add your changes
4. Document the cost impact (if measurable)
5. Submit a PR

### 3. Improve Documentation

Documentation improvements are always welcome:
- Clearer setup instructions
- Better troubleshooting guides
- Use case examples
- Video tutorials or blog posts

### 4. Add Skills

Have a custom skill that saves tokens? Add it to the `skills/` directory:

```bash
claude-cost-optimizer/
  skills/
    your-skill-name/
      SKILL.md          # Skill definition
      README.md         # Usage guide
      examples/         # Example usage
```

**Requirements:**
- Clear description of what the skill does
- Documented token savings (estimated)
- Examples of when to use it

### 5. Report Issues

Found a bug or issue? Open an issue with:
- Your environment (OS, Claude Code version, Node version)
- Steps to reproduce
- Expected vs actual behavior
- Relevant logs or screenshots

## Code Style

- Shell scripts: Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- Markdown: Use [markdownlint](https://github.com/DavidAnson/markdownlint)
- JSON: 2-space indentation, trailing commas where allowed

## Testing

Before submitting:

1. Test on a fresh installation
2. Verify backup/restore works
3. Check all links in documentation
4. Test both interactive and automated modes

## Measuring Impact

When adding optimizations, try to quantify the impact:

**Good:**
> "Pre-authorizing git commands reduced approval prompts by 80%, saving ~15 tokens per git operation"

**Better:**
> "Tested on 100 git operations. Before: 2000 tokens. After: 400 tokens. 80% reduction."

## Questions?

Open an issue or discussion. We're happy to help!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
