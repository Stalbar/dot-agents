---
name: code-review-excellence
description: "Use when reviewing pull requests, diffs, or code changes to provide systematic, constructive feedback on correctness, security, performance, and simplicity."
---

# Code Review Excellence

Systematic, constructive review focusing on correctness, security, performance, and maintainability.

---

## Workflow

1. **Read Context**: Check requirements, change plans, and test output first.
2. **Evaluate Core Dimensions**:
   - **Correctness**: Logic bugs, edge cases (null, empty, boundary).
   - **Simplicity & YAGNI**: Flag unnecessary abstractions or bloat (Ponytail style).
   - **Security**: Injection risks, trust boundaries, secret exposure.
   - **Performance**: Algorithmic bottlenecks (O(n²)), memory leaks, unindexed queries.
3. **Format Output**:
   - `## Summary`: 1-2 sentence verdict.
   - `## Blocking Issues`: Must fix before merge (quote exact lines).
   - `## Simplifications & Improvements`: YAGNI suggestions.
   - `## Verified Tests`: Test execution results.

---

## Supporting References

- Deep inspection checklist: `resources/review-checklist.md`
- Few-shot review example: `examples/sample-code-review.md`
