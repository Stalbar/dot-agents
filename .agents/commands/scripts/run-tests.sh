#!/usr/bin/env bash
#
# name: run-tests
# purpose: run the project test suite for a scope
# usage: run-tests.sh <unit|integration|all>
# example: bash .agents/commands/scripts/run-tests.sh unit
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: scope from $1, fallback env TEST_SCOPE
#
# {{TEST_CMD}}, {{UNIT_PATH}}, {{INTEGRATION_PATH}} are replaced by /agents-init.

set -euo pipefail

SCOPE="${1:-${TEST_SCOPE:-}}"
if [ -z "$SCOPE" ]; then
  echo "usage: run-tests.sh <unit|integration|all>" >&2
  exit 2
fi

case "$SCOPE" in
  unit)
    {{TEST_CMD}} {{UNIT_PATH}}
    ;;
  integration)
    {{TEST_CMD}} {{INTEGRATION_PATH}}
    ;;
  all)
    {{TEST_CMD}}
    ;;
  *)
    echo "error: unknown scope '$SCOPE' (expected unit|integration|all)" >&2
    exit 2
    ;;
esac
