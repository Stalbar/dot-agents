# Node/JavaScript Project Rules (local)

Generated at init. Project-specific. Keep under 12,000 characters.

## Package manager

{{PACKAGE_MANAGER}} with {{LOCKFILE}}.

| Command | Purpose |
|---------|---------|
| `{{ADD_CMD}}` | Add a production dependency |
| `{{ADD_DEV_CMD}}` | Add a dev dependency |
| `{{REMOVE_CMD}}` | Remove a dependency |
| `{{INSTALL_CMD}}` | Install dependencies |

## Test commands

Full suite: `{{TEST_CMD}}`
Unit: `{{TEST_CMD}} {{UNIT_PATH}}`
Integration: `{{TEST_CMD}} {{INTEGRATION_PATH}}`

## Lint/format

`{{LINT_CMD}}`

## Notes

- Commit the lockfile.
- Never edit the lockfile by hand.
- {{DEPS_SPLIT_NOTE}}
