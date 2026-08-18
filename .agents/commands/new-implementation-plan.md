---
description: Create an implementation plan (WHAT) from an approved ADR.
argument-hint: <adr-ref>
---

# /new-implementation-plan <adr-ref>

Create an implementation plan derived from the approved ADR.

1. Verify the referenced ADR exists in `docs/00_adr/` and was approved (check
   `context.md` or ask the user).
2. Delegate to the `planner` subagent (`.agents/agents/planner.md`) with the
   template `.agents/templates/implementation-plan.template.md`.
3. Create the file with the next number in `docs/01_implementation_plans/`,
   six-digit zero-padded, kebab-case slug.
4. Fill every template section: background and goals, components and module
   decomposition, interfaces and data flows (mermaid), risks and open
   questions, one-line steps.

After the plan is written, STOP at Gate R2. Present: the plan path, a short
summary, a checklist of what to verify, and the phrase "Awaiting your review".
