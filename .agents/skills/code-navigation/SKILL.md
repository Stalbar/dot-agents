---
name: code-navigation
description: "Use when searching, navigating, and inspecting code structure using ripgrep, ast-grep, and ctags before making changes. Do not use for external web searches."
---

# Code Navigation

Targeted code exploration using `rg`, `ast-grep`, and `ctags` to preserve context tokens.

## Strategy

1. **Orient:** Use `rg --files | head` to locate relevant files without reading entire directories.
2. **Search Narrow:**
   - Text search: `rg "pattern" -C 2 src/`
   - Structural search: `ast-grep -p "function $NAME($$$) { $$$ }"`
3. **Targeted Reads:** Read only specific line ranges identified by search. Avoid loading whole files.
