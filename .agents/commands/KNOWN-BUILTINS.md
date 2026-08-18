# Known Harness Built-in Commands

This file is the static collision list checked by `/agents-init`. Kit command
names must never match an entry here. If a new harness adds a built-in that
collides with a kit command, add it to this list, run `/agents-init` again,
and let the init agent stop and ask the user for a new name. Never rename
files automatically.

## Antigravity (Gemini)

/init, /plan, /grill-me, /learn, /schedule, /goal

## Claude Code

/init, /compact, /clear, /cost, /review

## DSH (DeepSeek/MiMo)

(recorded at kit build time; currently no known collisions)

## Cursor

(recorded at kit build time; currently no known collisions)

## Kit command names (must stay outside all lists above)

/agents-init, /new-adr, /code-review, /new-implementation-plan,
/new-change-plan, /new-tests, /implement, /run-tests, /completion-report,
/update-context, /commit, /pre-commit-checks

## Renaming history

- `/init` -> `/agents-init` (Antigravity and Claude Code ship a built-in /init)
- `/review` -> `/code-review` (Claude Code ships a built-in /review)
