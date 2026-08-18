# Git Commit Messages

## Format

```
Short summary (< 50 chars)

Detailed explanation of changes (< 72 chars per line, < 30 lines):
- What was changed #1
- What was changed #2

Benefits (benefits count can differ from "what was changed"):
- Benefit 1
- Benefit 2

ADR: <related ADR file name> (if known)
Change plans:

- <related first applicable change plan file name> (if known)
- <related second applicable change plan file name> (if known)
- <related third applicable change plan file name> (if known)
```

## Example

```
Fix all deprecation warnings in codebase

This commit resolves 3 deprecation warnings by migrating to
modern API patterns.

Changes:
1. Pydantic - Migrate Config to ConfigDict
2. SQLAlchemy - Update declarative_base import path
3. Qdrant - Replace recreate_collection with modern API

Benefits:
- Future-proof for upcoming library versions
- Better type safety and IDE support
- Clean logs with no deprecation warnings

ADR: 000000-update-api-version
Change plans:

- 000001-fix-deprecation-warnings
- 000002-update-api
- 000003-add-tests
```

## Rules

1. Summary line: imperative mood, under 50 characters.
2. Body explains WHAT and WHY, not how.
3. Every commit references its ADR and change plans when they exist.
4. The `/commit` command formats messages per this file automatically.
   Manual commits must match the same format.
