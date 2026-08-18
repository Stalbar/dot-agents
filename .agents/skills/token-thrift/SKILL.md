---
name: token-thrift
description: "Use during all coding, file reading, command execution, and review tasks to minimize token consumption and context window bloat."
---

# Token Thrift (Context Optimization)

Maximizes reasoning capacity and minimizes token cost by eliminating redundant reads, full-file overwrites, and verbose explanations.

---

## 1. Targeted Code Navigation
- Use `rg`, `ast-grep`, and ctags to find exact line numbers.
- Read only relevant slices (`StartLine`/`EndLine`). Never read large files in full.

## 2. Surgical Code Edits
- Apply line-bounded replacements (`replace_file_content` / diff blocks).
- Never regenerate untouched boilerplate or whole files.

## 3. Command Output Discipline
- Filter noisy logs (`rg -i error`, `head -n 30`, `--quiet`).
- Rely on exit codes before printing full outputs.

## 4. Concise Communication
- Code first, facts second, minimal prose.
- Follow Ponytail pattern: `[code/diff] -> skipped: [X], add when [Y].`

---

## Supporting Assets & References

- Token efficiency techniques: `resources/token-saving-rules.md`
- Compact interaction examples: `examples/compact-interactions.md`
