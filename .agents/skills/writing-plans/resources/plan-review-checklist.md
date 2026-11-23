# Plan Review Checklist (Gates R2, R3, R4)

## Implementation Plan (Gate R2)
1. **Scope:** Does it break down the approved ADR without adding unrequested features?
2. **Decomposition:** Are component boundaries and data flows clean and decoupled?
3. **Traceability:** Are one-line next steps clearly mapped to future change plans?

## Change Plan (Gate R3)
1. **File Boundaries:** Are all affected files explicitly listed with intended modifications?
2. **Minimal Diffs (YAGNI):** Does the plan avoid unnecessary abstractions, factories, or premature generalizations?
3. **Rollback Plan:** Is there a clear, feasible reversal strategy?
4. **Testing Checklist:** Are both positive and negative boundary test cases specified?

## Test Plan & Failing Tests (Gate R4)
1. **Test-First Evidence:** Have the new tests been executed and confirmed to FAIL before implementation?
2. **Behavior Focus:** Do tests verify behavior and contracts rather than internal mock-heavy call graphs?
3. **No Skipped Tests:** Are there zero conditional skip markers?
