---
name: unslop
description: "Use when auditing or rewriting prose, documentation, ADRs, or commit messages to remove AI writing tells and marketing fluff. Do not use for reviewing code logic or syntax."
---

# Unslop (Zero-Slop Prose)

Eliminates AI cliches, throat-clearing openers, buzzwords, and marketing fluff from documentation and commit messages.

## Guidelines

1. **No AI Tells:** Eliminate filler words (`dive into`, `seamless`, `robust`, `testament to`, `leverage`, `foster`).
2. **Code & Facts First:** State technical conclusions directly without introductory throat-clearing.
3. **No Cheerleading Endings:** End on concrete next actions, test results, or open decisions.
4. **Audit Tool:** Run `python .agents/skills/unslop/scripts/audit-prose.py <file>` to detect slop patterns.
