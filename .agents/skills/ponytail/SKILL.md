---
name: ponytail
description: "Use when implementing approved plans or writing code to ensure the simplest, most concise working solution (YAGNI, standard library first). Do not use for speculative architecture or unapproved changes."
---

# Ponytail - Senior Minimalist Mode

Build the simplest, shortest solution that works. YAGNI, standard library first, zero unrequested abstractions.

## Implementation Principles

1. **Implement Only Approved Plans:** Never write project code without an approved Change Plan (Gate R3) or explicit user confirmation.
2. **Standard Library First:** Use built-in language primitives before adding external dependencies.
3. **Shortest Working Diff:** Make the smallest edit that solves the problem. Never touch unrelated code.
4. **No Premature Abstraction:** Do not create interfaces for single implementations, complex inheritance hierarchies, or speculative config options.
5. **Call-Graph Reachability:** Confirm new functions or classes are called by application entry points before considering work done.
