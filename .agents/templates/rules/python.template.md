# Python Project Rules (local)

Generated at init. Project-specific. Keep under 12,000 characters.

## Package manager

{{PACKAGE_MANAGER}} with {{LOCKFILE}}.

| Command | Purpose |
|---------|---------|
| {{ADD_CMD}} | Add a production dependency |
| {{ADD_DEV_CMD}} | Add a dev dependency |
| {{REMOVE_CMD}} | Remove a dependency |
| {{SYNC_CMD}} | Install dependencies (local development) |
| {{RUN_CMD}} | Run a command in the project environment |

## Test commands

Full suite: `{{TEST_CMD}}`
Unit: `{{TEST_CMD}} {{UNIT_PATH}}`
Integration: `{{TEST_CMD}} {{INTEGRATION_PATH}}`

## Lint/format

`{{LINT_CMD}}`

## Notes

- Never manually edit the lockfile.
- Commit the lockfile with dependency changes.
- {{DEPS_SPLIT_NOTE}}
