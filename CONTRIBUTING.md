# Contributing to corrhi

corrhi was built for non-programmers, maintained with AI. Contributions are welcome.

## Reporting Issues

[Open an issue](https://github.com/awhynotproduction/corrhi/issues) with:
- What you expected to happen
- What actually happened
- Your setup (Tier 1/2/3, macOS version, Claude Code version)

## Contributing Code

1. Fork the repo
2. Create a branch (`git checkout -b my-change`)
3. Make your changes
4. Test with a fresh setup (`./setup.sh` on a clean environment)
5. Open a pull request

## Contributing Skills

Skills are the easiest way to contribute. Create a new skill in `claude-code/skills/[name]/SKILL.md` following the existing format:

```yaml
---
name: skill-name
description: One line description
user-invocable: true/false
---

# Skill Name

## Steps
1. ...
2. ...

## Rules
- ...
```

## Design Principles

When contributing, keep these in mind:

- **Non-programmers first.** Every feature should work for someone who's never used a terminal.
- **Generic, not personal.** No hardcoded names, paths, or preferences. Use variables.
- **Propose, don't force.** Substantive changes should go through `_review/`, not auto-execute.
- **Disk is truth.** Everything important gets written to a file immediately.
- **macOS builtins only** for setup.sh. Zero external dependencies.
