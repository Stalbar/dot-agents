---
name: unslop
description: "Use when drafting, reviewing, or editing prose, ADRs, documentation, or commit messages to remove AI writing tells, generic filler, and buzzwords while locking factual substance."
---

# Unslop (Prose De-Slop Discipline)

Eliminates AI writing tells, throat-clearing openers, generic buzzwords, and robotic rhythm from documentation and plans while preserving technical substance and author voice.

---

## Core Rules

1. **Cut Empty Framing**: Remove throat-clearing openers (*"It is worth noting that..."*) and generic optimistic endings (*"In conclusion, the future looks bright..."*).
2. **Lock Technical Substance**: Never alter facts, code signatures, paths, numbers, or domain-specific terms.
3. **Eliminate Buzzwords & Emojis**: Replace promotional adjectives (`seamless`, `robust`, `transformative`) with concrete mechanisms or delete them. Remove gratuitous emojis.
4. **Vary Cadence Naturally**: Break robotic symmetry. Avoid forcing lists into three items or overusing em dashes (`—`).
5. **Direct Verbs First**: Replace `has the ability to execute` with `executes`; replace `serves as a connection to` with `connects to`.

---

## Supporting Assets & References

- Complete pattern catalog: `resources/slop-patterns.md`
- Sample before/after rewrites: `examples/sample-unslop.md`
- Scanner script: `scripts/audit-prose.py`
