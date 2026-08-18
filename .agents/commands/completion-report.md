---
description: Create the completion report for a change plan, including deviations.
argument-hint: <change-plan-ref>
---

# /completion-report <change-plan-ref>

Create the completion report for the given change plan.

Execution block:

- `python .agents/commands/scripts/completion-report.py <change-plan-ref>`

Then fill the created file:

- What was actually done: one short paragraph.
- Verification steps and tests: lists, without details.
- Deviations:
  - changes that were done but were not in the change plan
  - changes that were in the change plan but were not done
  - changes that were implemented differently, with an explanation

The report reuses the change plan's number:
`docs/02_change_plans/######-<title>-report.md`.
