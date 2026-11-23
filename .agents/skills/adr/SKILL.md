---
name: adr
description: "Use when creating, recording, or reviewing Architectural Decision Records (ADRs) at Gate R1. Do not use for routine bug fixes or tactical code edits."
---

# ADR (Architectural Decision Record)

Governs architectural decisions, structural refactors, and technology choices.

## Workflow

1. **Context & Search:** Investigate the existing codebase structure using native search and file-reading tools before proposing changes.
2. **Draft ADR:**
   - Run helper: `python .agents/skills/adr/scripts/adr.py "<title>"`
   - Creates `docs/00_adr/######-<slug>.md` from `.agents/skills/adr/assets/adr.template.md`.
3. **Fill Required Sections:**
   - **Context & Problem Statement:** Specific issue, constraints, and scope.
   - **Considered Alternatives:** Minimum 2 realistic alternatives with pros, cons, and trade-offs. Standard library first.
   - **Decision & Rationale:** Justified with technical facts, not opinions.
   - **Consequences:** Positive benefits and negative trade-offs/risks.
   - **Implementation Steps:** One line per step, actionable, ordered.
4. **Self-Review:** Validate against `.agents/skills/adr/resources/adr-review-checklist.md`.
5. **Gate R1 Stop:** Present artifact path, short summary, review checklist, and "Awaiting your review".
   - Do NOT implement code until user explicitly responds with approval (`APPROVED`, `Approve R1`, or `Approved: <path>`).
