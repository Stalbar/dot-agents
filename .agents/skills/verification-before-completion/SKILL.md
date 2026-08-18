---
name: verification-before-completion
description: Requires running fresh verification commands and inspecting output before claiming tasks, bugs, or tests are complete. Evidence before assertions.
---

# Verification Before Completion

Claiming completion without fresh verification leads to false positives, broken pipelines, and wasted context.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

Never declare a fix or task complete without executing the check and inspecting the output in the current step.

---

## Verification Protocol

1. **Identify the Check**: What exact test, build, or linter command proves the claim?
2. **Execute**: Run the full command cleanly.
3. **Inspect Output**: Check exit codes and exact failure counts.
4. **Report Facts**: Quote the actual output or status.

---

## Anti-Patterns to Avoid

- Saying *"This should now work"* or *"Tests probably pass"* without running them.
- Extrapolating build success from a passing linter.
- Claiming an issue is resolved because code was modified, without re-testing the original reproduction.
