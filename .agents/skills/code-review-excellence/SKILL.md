---
name: code-review-excellence
description: "Use when reviewing code changes, diffs, PRs, or artifacts for correctness, security, performance, and simplicity, or auditing docs/prose for AI slop, or when conducting cross-model reviews. Do not use for writing code or drafting initial plans."
---

# Code Review Excellence

Systematic, constructive review focusing on correctness, security, performance, and simplicity.

## Review Workflow

1. **Read Context:** Inspect the relevant Change Plan, ADR, and test output first.
2. **Evaluate Core Dimensions:**
   - **Correctness:** Logic flaws, edge cases (empty collections, boundary values, null pointers).
   - **Security:** Secret leakage, parameterized queries, boundary input validation.
   - **Simplicity (Ponytail):** Flag unrequested abstractions, premature optimizations, or bloat.
   - **Modularity & Reachability:** Pure business logic, functions < 50 lines, reachability from entry points.
3. **Read-Only Static Sweep (Hunter Mode):** Search for bug classes or orphaned code across the repository. Optional: run `python .agents/skills/code-review-excellence/scripts/audit-prose.py <file>` to check documentation.
4. **Structured Verdict Output:**

```markdown
## Verdict: approve | approve-with-changes | reject

## Critical Issues
- [Blocking problems that must be fixed before merge]

## Major Issues
- [Significant defects or architectural flaws]

## Minor Issues
- [Suggestions, style improvements, naming]
```

## Cross-Model Review Protocol

To review an artifact with another model, use `.agents/skills/code-review-excellence/resources/cross-model-review-prompt.md`. Verdicts from other models are advisory; only the user approves gates.
