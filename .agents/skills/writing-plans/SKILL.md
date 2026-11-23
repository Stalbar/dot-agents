---
name: writing-plans
description: "Use when creating Change Plans (HOW), Implementation Plans (WHAT), or Test Plans before modifying code. Do not use for architectural decisions (/adr) or direct implementation without a plan."
---

# Writing Plans

Structured task decomposition and test planning before modifying repository code.

## Artifact Selection Matrix

| Need / Task Scope | Artifact to Produce | Destination Path | Review Gate |
|---|---|---|---|
| High-level roadmap / multi-component decomposition from ADR | **Implementation Plan (WHAT)** | `docs/01_implementation_plans/######-<title>.md` | Gate R2 |
| Concrete file edits, step-by-step diffs, testing checklist | **Change Plan (HOW)** | `docs/02_change_plans/######-<title>.md` | Gate R3 |
| Pre-implementation tests & test plan checklist | **Test Plan + Tests** | `docs/03_test_plans/######-<title>.md` | Gate R4 |

## Workflow

### 1. Implementation Plan (Gate R2)
- Use template: `.agents/skills/writing-plans/assets/implementation-plan.template.md`.
- Save as next 6-digit number in `docs/01_implementation_plans/######-<slug>.md`.
- Define module decomposition, interfaces, risks, and one-line steps for future change plans.
- STOP at Gate R2. Present path, summary, and "Awaiting your review".

### 2. Change Plan (Gate R3)
- Use template: `.agents/skills/writing-plans/assets/change-plan.template.md`.
- Save as next 6-digit number in `docs/02_change_plans/######-<slug>.md`.
- Detail affected files, exact implementation steps, rollback strategy, and minimal testing checklist.
- STOP at Gate R3. Present path, summary, and "Awaiting your review".

### 3. Test Plan & Tests-First (Gate R4)
- Follow `.agents/skills/writing-plans/resources/testing-discipline.md`.
- Write failing unit/integration tests directly into the project test tree.
- Use template: `.agents/skills/writing-plans/assets/test-plan.template.md`.
- Save test plan in `docs/03_test_plans/######-<slug>.md`.
- Run tests and verify they FAIL (evidence of test validity).
- STOP at Gate R4. Present test file paths, test plan doc, failure output, and "Awaiting your review".
