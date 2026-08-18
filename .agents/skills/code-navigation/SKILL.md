---
name: code-navigation
description: Navigate and understand codebases using ripgrep, ast-grep, and ctags. Use for finding definitions, references, patterns, and understanding code structure before making changes.
---

Use these CLI tools for code exploration instead of broad `read` or `grep` loops.

## Tools Summary

| Tool | Use case | Example |
|------|----------|---------|
| `rg` (ripgrep) | Fast text search, find files by pattern, search file contents | `rg "function name" --type ts` |
| `ast-grep` | Structural search — find code by AST patterns, not text | `ast-grep -p "const $$$ = $$$" --lang ts` |
| `ctags` | Generate symbol index for navigation | `ctags -R --languages=TypeScript .` |

## ripgrep (rg)

Best for: finding text patterns, file names, and content quickly.

```bash
# Find all TypeScript files referencing a function
rg "functionName" --type ts

# Find with context (3 lines around match)
rg "pattern" -C 3 --type ts

# List files containing a pattern
rg -l "TODO" --type ts

# Search only in specific directories
rg "import.*from" src/

# Find files by name pattern
rg --files | rg "\.test\."

# Invert match (files NOT containing pattern)
rg --files | rg -v "node_modules"
```

## ast-grep

Best for: finding code by structure, not text. Understands syntax.

```bash
# Find all function declarations
ast-grep -p "function $NAME($$$) { $$$ }" --lang ts

# Find all class declarations
ast-grep -p "class $NAME { $$$ }" --lang ts

# Find all calls to a specific function
ast-grep -p "functionName($$$)" --lang ts

# Find all imports from a module
ast-grep -p "import { $$$ } from 'module'" --lang ts

# Find assignments to a variable
ast-grep -p "$VAR = $$$" --lang ts

# Find async functions
ast-grep -p "async function $NAME($$$) { $$$ }" --lang ts

# Count matches
ast-grep -p "try { $$$ } catch($$$) { $$$ }" --lang ts --count
```

### Pattern variables
- `$$$` — match any number of AST nodes (0 or more)
- `$$` — match single AST node (exactly 1)
- `$NAME` — match and capture with label

### Supported languages
Use `--lang` flag: `ts`, `tsx`, `js`, `jsx`, `python`, `rust`, `go`, `java`, `cpp`, `css`, `html`, `json`, `yaml`, `toml`, `bash`, `lua`, `ruby`, `swift`, `kotlin`, `c`, `csharp`, `scala`, `haskell`, `elixir`, `clojure`, `dart`, `php`, `sql`, and more.

## ctags

Best for: generating a symbol index for quick navigation.

```bash
# Generate tags for the project
ctags -R --languages=TypeScript,JavaScript --exclude=node_modules .

# Find definition of a symbol
grep "symbolName" tags

# List all functions
grep "function$" tags | head -20
```

## Strategy

1. **Orient** — use `rg --files | head` and `find` to understand project structure
2. **Search narrow** — use `rg` for text, `ast-grep` for structure
3. **Read targeted** — use `read` with offset/limit only after finding the right file and area
4. **Avoid broad reads** — never `read` entire large files; use `rg`/`ast-grep` first to locate, then read only the relevant section
