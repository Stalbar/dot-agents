---
name: git-commit
description: "Use ONLY when explicitly asked to commit changes or invoked via /git-commit. Do not use for unverified code, pending reviews, or automatic commits without user request."
---

# Git Commit

Formats standardized commit messages, checks staged changes, and executes atomic git commits.

## Workflow

1. **Verify Readiness:** Ensure all tests pass and pre-commit checks succeed using `/verification-before-completion`.
2. **Execute Commit Helper:**
   - Commit already-staged changes:
     `python .agents/skills/git-commit/scripts/commit.py "<summary>"`
   - Stage all changes and commit non-interactively:
     `python .agents/skills/git-commit/scripts/commit.py "<summary>" --all --yes`
   - With optional references:
     `python .agents/skills/git-commit/scripts/commit.py "<summary>" --benefits "Faster loading" --adr docs/00_adr/000001-state.md --plan docs/02_change_plans/000001-fix.md`
3. **Format Standards:**
   - Summary: Imperative mood, under 50 characters.
   - Body: Bulleted list of modified files (<= 72 chars/line).
   - Optional sections: Benefits, ADR, Change plans (omitted if not provided).
