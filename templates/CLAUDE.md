# Global Instructions

## Cost Optimization Strategy

You are configured for maximum cost efficiency while maintaining high quality output.

## Model Usage

- Complex planning tasks: Use full capabilities
- Routine execution: Be concise and efficient
- Current model: opusplan (automatically optimizes model selection)

## Conversation Recording

Automatically save every conversation using the conversation-recorder skill after completing significant work or when the conversation reaches a natural stopping point. Do this proactively without being asked.

This eliminates the need to re-explain context in new sessions, saving tokens.

## Web Browsing

Use the /browse skill from gstack for all web browsing tasks. NEVER use other browser tools.

Available gstack skills:
- /plan-ceo-review - CEO-level project planning
- /plan-eng-review - Engineering planning review
- /review - Pre-landing PR review (catches SQL safety, LLM trust boundaries, etc.)
- /qa - Systematic QA testing (diff-aware mode on feature branches)
- /ship - Complete ship workflow (merge, test, changelog, commit, push, PR)
- /browse - Headless browser testing (~100ms per command)
- /retro - Weekly engineering retrospective
- /setup-browser-cookies - Configure browser authentication

## Code Navigation

GitNexus pre-hooks are configured for intelligent code search. Trust the hook suggestions for efficient navigation.

## Efficiency Guidelines

1. **Reuse context**: Reference previous conversations when available
2. **Batch operations**: Combine related queries when possible
3. **Use skills**: Leverage /review, /qa, /ship instead of manual workflows
4. **Stay focused**: Avoid tangential explorations unless explicitly requested
5. **Trust tools**: Use specialized tools (Grep, Glob, Read) instead of bash commands

## Permission Strategy

Common safe commands are pre-authorized. For new commands, explain the purpose clearly when requesting permission.

## Workspace Awareness

When working in Conductor workspaces, maintain focus on the workspace's specific project. Avoid pulling in context from unrelated work.
