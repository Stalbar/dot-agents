---
name: systematic-debugging
description: 4-phase root-cause investigation for bugs, test failures, and unexpected behaviors before proposing fixes. Eliminates guess-and-patch token waste.
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

### Phase 1: Root Cause Investigation
1. **Read Error Details**: Inspect exact error messages, line numbers, and stack traces.
2. **Reproduce Minimally**: Run the minimal failing command or test.
3. **Check Changes**: Run `git diff` or review recent commits to identify what introduced the fault.
4. **Trace Data Flow**: Trace invalid state backwards to its origin rather than patching where the symptom appears.

### Phase 2: Pattern Analysis
1. **Locate Working Counterparts**: Find similar working patterns within the codebase.
2. **Compare Contracts**: Spot discrepancies in inputs, configs, types, or environment variables.

### Phase 3: Single Hypothesis & Minimal Test
1. **State Hypothesis**: Explicitly formulate: *"X fails because Y occurs under condition Z."*
2. **Test Minimally**: Make the smallest possible change or diagnostic log to validate the hypothesis.

### Phase 4: Targeted Fix & Verification
1. **Write/Update Failing Test**: Ensure a test captures the exact regression.
2. **Apply Surgical Fix**: Modify only the root cause.
3. **Verify**: Ensure all tests pass with zero regressions.
4. **Escalation Rule**: If 3 successive fix attempts fail, STOP. Re-evaluate assumptions or discuss architectural mismatch.
