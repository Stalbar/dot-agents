---
name: tdd-testing
description: Test-first discipline for the .agents kit. Write failing tests from an approved change plan before implementation, follow .agents/rules/tests.md, and produce the test plan doc.
---

# TDD Testing

Used at Stage D of the kit workflow. The approved change plan (Gate R3) must
exist before you use this skill.

1. Read the change plan's testing checklist and `.agents/rules/tests.md`.
2. For each checklist item, write the minimal test that verifies it. Unit
   tests first; integration tests only where the checklist demands them.
3. New tests must fail before implementation. Run them and confirm the
   failures are because the code does not exist yet.
4. Every test file starts with a bullet list of its tests. No skippable tests.
5. Test behavior, not call graphs. Import the real code at the path the change
   plan defines.
6. Write `docs/03_test_plans/######-<title>.md` with a bullet list of every
   planned test, one sentence each.
7. Stop at Gate R4. The user reviews the tests before any implementation.
