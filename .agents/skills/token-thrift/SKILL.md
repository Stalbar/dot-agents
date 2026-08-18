---
name: token-thrift
description: Best practices and rules for minimizing token consumption and context window bloat across any AI harness and language.
---

# Token Thrift (Context Optimization)

Maximizes reasoning capacity and minimizes token cost by eliminating redundant reads, full-file overwrites, and verbose explanations.

---

## 1. Targeted Code Navigation

- **Never read entire files blindly**: Use `code-navigation` tools (`rg`, `ast-grep`, `ctags`, grep) to find exact line numbers.
- **Slice reads**: When reading files, supply explicit line ranges (`StartLine`/`EndLine` or `sed`/`head`/`tail`) instead of dumping thousands of lines into context.
- **Narrow directory listings**: List specific subdirectories rather than entire project trees.

---

## 2. Surgical Code Modifications

- **Avoid full-file replacements**: Use line-bounded replacement tools (`replace_file_content` / diff blocks) targeting only the necessary lines.
- **Do not regenerate untouched boilerplate**: Keep imports and existing functions intact without re-emitting them.

---

## 3. Command Output Discipline

- **Filter noisy CLI output**: Pipe noisy test/build commands through filters (e.g. `rg -i error`, `head -n 30`, or `--quiet` flags) when full logs are unnecessary.
- **Check exit codes first**: Run concise verification rather than dumping hundreds of passing test logs.

---

## 4. Concise Communication

- **Code first, minimal prose**: Provide the solution and necessary facts. Avoid marketing text, restating user prompts, or repeating whole file contents in the final response.
- **Use Ponytail format**: `[code/diff] -> skipped: [X], add when [Y].`
