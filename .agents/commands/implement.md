---
description: Implement an approved change plan (Stage E): direct changes, green tests, pre-commit checks, completion report.
argument-hint: <change-plan-ref>
---

# /implement <change-plan-ref>

Implement the approved change plan. This is the only stage that writes project
code.

1. Verify the change plan was approved (Gate R3) and its tests were approved
   (Gate R4). If not, stop and ask the user.
2. Delegate to the `implementer` subagent (`.agents/agents/implementer.md`).
3. The implementer follows the change plan step by step, iterates until the
   new tests pass, then runs the full project suite.
4. Never edit tests before the production code is fixed. If a test must
   change, stop, update the change plan, and report to the user.
5. Run pre-commit checks:

Execution block:

- POSIX: `bash .agents/commands/scripts/pre-commit-checks.sh`
- Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/pre-commit-checks.ps1`

6. Create the completion report:

Execution block:

- `python .agents/commands/scripts/completion-report.py <change-plan-ref>`

7. Update `.agents/context.md` with what changed.

No gate after this stage: the completion report is informational. Present it
with the list of changed files.
