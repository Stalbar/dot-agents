---
name: git-commit
description: "Use when formatting, staging, and committing git changes according to repository commit conventions. Do not use for unverified code or pending reviews."
---

# Git Commit

Formats standardized commit messages, stages changes, and executes atomic git commits.

## Workflow

1. **Verify Readiness:** Ensure all tests pass and pre-commit checks succeed using `/verification-before-completion`.
2. **Execute Commit Helper:**
   - Interactive: `python .agents/skills/git-commit/scripts/commit.py "<summary>"`
   - Non-interactive: `python .agents/skills/git-commit/scripts/commit.py "<summary>" --yes`
3. **Format Standards:**
   - Summary: Imperative mood, under 50 characters.
   - Body: Bulleted list of modified files (<= 72 chars/line), benefits, and artifact references (ADR / Change Plan).
