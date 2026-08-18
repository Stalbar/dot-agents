---
name: writing-plans
description: "Use when you have a specification or requirements for a multi-step task, before touching code. Breaks work into bite-sized, testable, dependency-ordered tasks."
---

# Writing Plans

Structured task decomposition prevents context thrashing, rework, and specification drift.

---

## Plan Structure

1. **Goal**: One clear sentence defining the deliverable.
2. **Architecture**: 2-3 sentences outlining the approach.
3. **Bite-Sized Tasks**:
   - Explicit file boundaries (create, modify, test).
   - Consumed and produced interfaces between steps.
   - Exact test verification commands for each step.

---

## Rules

- No placeholders (`TODO`, `TBD`, `implement later`).
- Keep tasks atomic and independently verifiable.
- Sequence dependencies linearly so earlier tasks unblock later tasks.

---

## Supporting Assets & References

- Reusable plan template: `assets/plan-template.md`
- Sample implementation plan: `examples/sample-plan.md`
