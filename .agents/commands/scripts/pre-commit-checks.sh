#!/usr/bin/env bash
#
# name: pre-commit-checks
# purpose: run lint and fast tests before commit
# usage: pre-commit-checks.sh
# example: bash .agents/commands/scripts/pre-commit-checks.sh
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: none
#
# {{LINT_CMD}}, {{TEST_CMD}}, {{UNIT_PATH}} are replaced by /agents-init.

set -euo pipefail

echo "==> lint: {{LINT_CMD}}"
{{LINT_CMD}}

echo "==> fast tests: {{TEST_CMD}} {{UNIT_PATH}}"
{{TEST_CMD}} {{UNIT_PATH}}

echo "pre-commit checks passed"
