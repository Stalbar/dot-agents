---
name: verification-before-completion
description: "Use when verifying code changes, running pre-commit checks, proving tests pass, and generating completion reports. Do not use for initial planning or authoring new tests."
---

# Verification Before Completion

Enforces evidence-based task completion with zero unverified claims.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

Never declare a fix or task complete without executing the verification command and inspecting the output in the current step.

## Verification Protocol

1. **Run Full Test Suite:** Execute the project test command. Inspect exit code and exact failure count. Never assume passing status.
2. **Call-Graph Reachability Gate:** Grep production entry points to confirm newly added components or endpoints are actively wired and invoked. If a symbol has zero callers, it is dead code.
3. **Run Pre-Commit Checks:** Execute project linters, formatters, and type checkers.
4. **Gap Round:** Explicitly state what was NOT verified (e.g. live cloud APIs, production databases).
5. **Generate Completion Report:**
   - Run helper: `python .agents/skills/verification-before-completion/scripts/completion-report.py <change-plan-ref>`
   - Saves to `docs/02_change_plans/######-<slug>-report.md`.
   - Record what was done, actual verification output, reachability evidence, and deviations.
