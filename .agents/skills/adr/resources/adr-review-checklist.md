# ADR Review Checklist (Gate R1)

Use this checklist to evaluate an ADR before approving Gate R1 or when requesting an advisory review from another model.

## Review Criteria

1. **Problem Clarity:** Is the problem statement specific, scoped, and complete? Does it explain why a decision is necessary?
2. **Alternatives Considered:** Are at least 2 real alternatives evaluated with balanced pros, cons, and trade-offs? Are standard library / native platform options considered first?
3. **Decision & Rationale:** Is the decision justified with technical evidence, consistent with overall architecture, and avoiding unneeded dependencies?
4. **Consequences:** Are both positive benefits and negative trade-offs / operational costs explicitly documented?
5. **Implementation Steps:** Are steps ordered, actionable, and strictly one line per step (ready to become change plans)?
6. **Scope Discipline:** Does this document exactly one architectural decision without bundling unrelated concerns?

## Review Output Format

```markdown
## Verdict: approve | approve-with-changes | reject

## Critical Issues
- [Blocking problems, if any]

## Major Issues
- [Should fix before proceeding]

## Minor Issues
- [Suggestions and style improvements]
```
