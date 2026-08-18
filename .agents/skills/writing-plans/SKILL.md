---
name: writing-plans
description: Break specs and requirements into bite-sized, testable, dependency-ordered tasks before touching code.
---

# Writing Plans

Structured task decomposition prevents context thrashing, rework, and specification drift.

---

## Plan Structure

1. **Goal**: One clear sentence defining the deliverable.
2. **Architecture**: 2-3 sentences outlining the approach.
3. **Bite-Sized Tasks**:
   - Each task targets specific files (create, modify, or test).
   - Each task specifies consumed and produced interfaces.
   - Each task specifies exact test commands and verification criteria.

---

## Rules

- No placeholders (`TODO`, `TBD`, `implement later`).
- Keep tasks atomic and independently verifiable.
- Sequence dependencies linearly so earlier tasks unblock later tasks.
