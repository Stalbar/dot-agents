# Testing Discipline & Standards

Rules derived from `.agents/rules/tests.md` and test-driven development:

## 1. Test-First Pipeline (Gate R4)
- Tests are written BEFORE implementation, directly from the approved Change Plan.
- New tests must FAIL before implementation because the code does not exist yet. A passing test prior to implementation is a defect.
- Implementation is complete only when the new tests AND existing regression suites pass.

## 2. Test Architecture & Split

| Category | Location | Rules |
|---|---|---|
| **Unit Tests** | `tests/unit/` | Pure logic, memory/mocks only, no network/database, fast (<100ms). |
| **Integration Tests** | `tests/integration/` | Real databases, file systems, external network, marked with test markers. |

## 3. Core Standards
- **Function-based tests:** Prefer simple test functions over class hierarchies unless framework requires it.
- **Parametrize:** Use framework test parametrization for multi-input test matrices.
- **Never conditionally skip:** Zero `pytest.skip()` or conditional test bypassing. Tests must pass or fail.
- **Test behavior, not call graphs:** Test inputs, outputs, exceptions, and side effects. Never test third-party library internals or language builtins.
