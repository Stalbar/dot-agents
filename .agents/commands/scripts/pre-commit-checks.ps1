# name: pre-commit-checks
# purpose: run lint and fast tests before commit
# usage: pre-commit-checks.ps1
# example: powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/pre-commit-checks.ps1
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: none
#
# {{LINT_CMD}}, {{TEST_CMD}}, {{UNIT_PATH}} are replaced by /agents-init.

Write-Host "==> lint: {{LINT_CMD}}"
{{LINT_CMD}}
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "==> fast tests: {{TEST_CMD}} {{UNIT_PATH}}"
{{TEST_CMD}} {{UNIT_PATH}}
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "pre-commit checks passed"
