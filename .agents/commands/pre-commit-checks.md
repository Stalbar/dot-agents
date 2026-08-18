---
description: Run pre-commit checks (lint + fast tests).
argument-hint: none
---

# /pre-commit-checks

Run the pre-commit checks.

Execution block:

- POSIX: `bash .agents/commands/scripts/pre-commit-checks.sh`
- Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/pre-commit-checks.ps1`

If the project has its own `scripts/pre-commit-checks.sh`, prefer it and note
which one ran. Report pass or fail. On failure, list the failing checks and
fix the code, never the checks.
