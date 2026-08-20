---
name: token-thrift
description: "Use during all coding, file reading, command execution, and review tasks to minimize token consumption and context window bloat."
---

# Token Thrift (Context Optimization)

Maximizes reasoning capacity and minimizes token cost by eliminating redundant reads, full-file overwrites, and verbose explanations.

---

## 1. Targeted Code Navigation
- Use `rg`, `ast-grep`, and ctags to find exact line numbers.
- **Large-Read Guard**: Never read files > 25 KB in full without offset/limit or line slices (`StartLine`/`EndLine`).

## 2. Surgical Code Edits
- Apply line-bounded replacements (`replace_file_content` / diff blocks).
- Never regenerate untouched boilerplate or whole files.

## 3. Command Output Discipline
- Filter noisy logs (`rg -i error`, `head -n 30`, `--quiet`).
- Rely on exit codes before printing full outputs.

## 4. Oscillation Circuit Breaker
- Detect `A -> B -> A -> B -> A` call loops.
- If tool calls oscillate or a fix loop produces zero delta, break the cycle immediately: change ONE variable or stop and present options.

## 5. Concise Communication
- Code first, facts second, minimal prose.
- Follow Ponytail pattern: `[code/diff] -> skipped: [X], add when [Y].`

---

## Supporting Assets & References

- Token efficiency techniques: `resources/token-saving-rules.md`
- Compact interaction examples: `examples/compact-interactions.md`
