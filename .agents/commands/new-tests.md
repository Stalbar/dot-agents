---
description: Write unit and integration tests BEFORE implementation, plus the test plan doc.
argument-hint: <change-plan-ref>
---

# /new-tests <change-plan-ref>

Write the tests for the approved change plan, before any implementation.

1. Verify the referenced change plan exists in `docs/02_change_plans/` and was
   approved (Gate R3).
2. Delegate to the `test-writer` subagent (`.agents/agents/test-writer.md`)
   with the template `.agents/templates/test-plan.template.md`.
3. Tests go into the project test tree per the change plan's testing
   checklist. Every test file starts with a bullet list of its tests.
4. Create the test plan doc with the next number in `docs/03_test_plans/`.
5. Run the new tests to confirm they FAIL (the code does not exist yet).
   Report the failures as expected.

After the tests and test plan are written, STOP at Gate R4. Present: the test
plan path, the test file paths, a short summary, a checklist of what to
verify, and the phrase "Awaiting your review".
