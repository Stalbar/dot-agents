# Git Commit Message Convention

Format:

```
<Imperative summary, max 50 characters>

Detailed explanation of changes:
- <file1>: <what changed>
- <file2>: <what changed>

Benefits:
- <benefit 1>

ADR: <docs/00_adr/######-<slug>.md or None>
Change plans:
- <docs/02_change_plans/######-<slug>.md or None>
```

Rules:
- Line length in body: maximum 72 characters per line.
- Summary uses imperative mood ("Add feature", not "Added feature").
- Never include secrets, tokens, or credentials in commit messages.
