# name: run-tests
# purpose: run the project test suite for a scope
# usage: run-tests.ps1 <unit|integration|all>
# example: powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/run-tests.ps1 unit
# created: 2026-08-18, by init-agent subagent (kit starter)
# params: scope from args[0], fallback $env:TEST_SCOPE
#
# {{TEST_CMD}}, {{UNIT_PATH}}, {{INTEGRATION_PATH}} are replaced by /agents-init.

param(
    [string]$Scope = ""
)

if (-not $Scope) { $Scope = $env:TEST_SCOPE }
if (-not $Scope) {
    Write-Error "usage: run-tests.ps1 <unit|integration|all>"
    exit 2
}

switch ($Scope) {
    "unit"        { {{TEST_CMD}} {{UNIT_PATH}} }
    "integration" { {{TEST_CMD}} {{INTEGRATION_PATH}} }
    "all"         { {{TEST_CMD}} }
    default {
        Write-Error "error: unknown scope '$Scope' (expected unit|integration|all)"
        exit 2
    }
}

if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
