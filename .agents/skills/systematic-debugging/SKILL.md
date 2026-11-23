---
name: systematic-debugging
description: "Use when encountering bugs, test failures, or unexpected runtime errors before proposing or applying fixes. Do not use for routine feature development or unverified changes."
---

# Systematic Debugging

Four-phase root cause investigation with surgical precision and oscillation circuit breaker.

## The Iron Law

```
NO FIXES WITHOUT CONFIRMED ROOT CAUSE INVESTIGATION
```

Never guess, patch symptoms, or refactor surrounding code during bug fixes.

## 4-Phase Protocol

1. **Phase 1: Root Cause Investigation**
   - Reproduce the failure with a minimal test case or command.
   - Trace backwards from failure point to originating trigger.
   - Form and test hypotheses against evidence.
2. **Phase 2: Surgical Minimal Fix**
   - Apply the smallest possible code edit directly at the root cause.
   - Do NOT refactor surrounding code or introduce new abstractions.
3. **Phase 3: Verify & Reachability**
   - Run the reproduction test to prove the fix works.
   - Run the full project test suite to verify zero regressions.
4. **Phase 4: Circuit Breaker**
   - If fix attempts fail 3 times or tool calls oscillate (`A -> B -> A -> B`), STOP immediately.
   - Explain findings to the user and present 2-3 concrete options.
   - Log outcome to `.agents/memory/YYYY-MM-DD.md`.
