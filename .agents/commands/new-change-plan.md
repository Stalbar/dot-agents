---
description: Create a change plan (HOW) from an approved implementation plan.
argument-hint: <impl-plan-ref>
---

# /new-change-plan <impl-plan-ref>

Create a change plan derived from the approved implementation plan.

1. Verify the referenced implementation plan exists in
   `docs/01_implementation_plans/` and was approved (check `context.md` or ask
   the user).
2. Delegate to the `planner` subagent (`.agents/agents/planner.md`) with the
   template `.agents/templates/change-plan.template.md`.
3. Create the file with the next number in `docs/02_change_plans/`, six-digit
   zero-padded, kebab-case slug.
4. Fill every template section: background and issue description, affected
   files, implementation steps, testing checklist, minimal necessary unit and
   integration tests, rollback plan, benefits and estimated time.

After the plan is written, STOP at Gate R3. Present: the plan path, a short
summary, a checklist of what to verify, and the phrase "Awaiting your review".
