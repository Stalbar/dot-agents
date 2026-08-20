---
name: systematic-debugging
description: "Use when encountering any bug, test failure, or unexpected error, before proposing or applying fixes. Enforces 4-phase root cause investigation to prevent token-wasting guessing loops."
---

# Systematic Debugging

Random fixes waste tokens, create regressions, and mask root causes.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

Never propose or apply code edits until completing Phase 1.

---

## The Four Phases

1. **Phase 1: Root Cause Investigation**
   - Read exact error messages and stack traces.
   - Reproduce minimally. Trace invalid state backwards to the source.
2. **Phase 2: Pattern Analysis**
   - Locate working counterparts in the codebase and compare contracts.
3. **Phase 3: Single Hypothesis & Minimal Test**
   - State hypothesis: *"X fails because Y occurs under condition Z."*
   - Validate with the smallest possible test or log.
4. **Phase 4: Targeted Fix & Verification**
   - Apply surgical fix at the root cause. Verify all tests pass.
   - **Oscillation Circuit Breaker**: If tool calls oscillate (`A -> B -> A -> B -> A`), fix loop delta is ~0, or the same error repeats 3 times: STOP immediately. Change ONE variable or stop and offer the user 2-3 concrete options.
   - **Escalation Rule**: If 3 successive fix attempts fail, STOP. Re-evaluate architecture with human partner.

---

## Supporting References

- Root cause tracing guide: `resources/root-cause-tracing.md`
- Sample debugging workflow: `examples/debugging-session.md`
