---
name: token-thrift
description: "Use when optimizing prompt efficiency, minimizing context window usage, or trimming file reads during long sessions. Do not use for code implementation or bug fixes."
---

# Token Thrift

Strict context window hygiene and token optimization discipline for Flash models.

## Core Rules

1. **Targeted Reads:** Never read entire large files (> 100 lines). Use `rg` or `ast-grep` first to locate line numbers, then read only the target range.
2. **Compact Responses:** Facts and code first. Omit boilerplate greetings, summaries of the user's question, and conversational fillers.
3. **Chained Tool Calls:** Batch independent file reads and search commands into a single turn.
4. **Prune Logs:** Truncate stack traces and command logs to only the relevant failure frames before pasting into conversation.
