---
description: Run the project test suite for a scope: unit, integration, or all.
argument-hint: <unit | integration | all>
---

# /run-tests <scope>

Run the project test suite for the given scope.

Execution block:

- POSIX: `bash .agents/commands/scripts/run-tests.sh <scope>`
- Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/run-tests.ps1 <scope>`

Report the result in 1 to 3 sentences: command run, pass/fail counts, and the
next step if something failed. If any existing test fails, fix the code, never
the tests.
