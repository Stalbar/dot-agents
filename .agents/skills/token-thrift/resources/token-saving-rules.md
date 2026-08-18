# Token Saving Rules & Techniques

## 1. Targeted File Navigation
- Never read whole files blindly. Use `rg` or `ast-grep` first to locate exact lines.
- Always provide line bounds (`StartLine` and `EndLine` or `sed`/`head`) when reading.
- List specific subdirectories rather than entire project trees.

## 2. Surgical Code Edits
- Use line-bounded replacement tools (`replace_file_content` / diff blocks).
- Avoid rewriting entire files or repeating untouched boilerplate.

## 3. Command Output Filtering
- Filter noisy command output using `--quiet`, `rg -i error`, or piping to `head -n 30`.
- Verify exit codes directly rather than printing hundreds of passing test logs.

## 4. Dense, High-Signal Output
- Code first, then at most 1 to 3 short lines: what was skipped, when to add it.
- Format: `[code] -> skipped: [X], add when [Y].`
