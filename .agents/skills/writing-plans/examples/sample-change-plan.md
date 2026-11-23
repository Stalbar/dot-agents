# Change Plan: Implement Token Expiration Validator

## Status

Approved (Gate R3)

## References

- Implementation plan: docs/01_implementation_plans/000003-auth-service.md

## Background & Issue Description

Tokens currently do not check the expiration timestamp (`exp`) claim, allowing expired tokens to authenticate successfully.

## Affected Files

- `src/auth/token.py` - modify: check `exp` claim against current UNIX timestamp in `verify_token()`.
- `tests/unit/test_token.py` - create/modify: test expired, valid, and malformed token scenarios.

## Implementation Steps

1. In `src/auth/token.py`, extract `exp` claim from decoded payload.
2. If `exp < time.time()`, raise `TokenExpiredError`.
3. If `exp` claim is missing, raise `InvalidTokenError`.

## Testing Checklist & Plan

- [ ] `test_verify_token_expired`: Raises `TokenExpiredError` when timestamp is in past.
- [ ] `test_verify_token_valid`: Returns payload when `exp` is in future.
- [ ] `test_verify_token_missing_exp`: Raises `InvalidTokenError`.

## Rollback Plan

Revert `src/auth/token.py` to previous git commit (`git checkout HEAD~1 -- src/auth/token.py`).

## Benefits & Estimated Effort

- Benefits: Closes critical authentication bypass vulnerability.
- Estimated effort: 20 minutes.
