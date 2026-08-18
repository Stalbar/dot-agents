# Testing

## Test-first pipeline (mandatory)

1. Tests are written BEFORE implementation, from the approved change plan, and
   reviewed by the user at Gate R4.
2. New tests must FAIL before implementation, because the code they test does
   not exist yet. A test that passes before implementation is suspicious and
   must be reported to the user.
3. Implementation is complete only when the new tests AND the whole existing
   suite pass.
4. During implementation, if a test needs to change, first update the change
   plan and report it. Never silently edit tests to make them pass.

## General Rules

1. Don't use class-based unit tests, only function-based, unless the language's
   test framework forces class-based organization.
2. If you're testing the same function with different parameter sets, use the
   framework's parametrize mechanism.
3. If you add a new API service, make sure it is fully covered with tests.
4. Don't test code in third-party dependencies.
5. Don't test the language's own functionality (dataclasses, stdlib behavior).
6. **NEVER create conditionally skippable tests.** Do not use skip mechanisms
   like `pytest.skip()` inside test functions or fixtures. If a test is
   launched, it must either pass or fail. Period.
7. Start each test file with a bullet-point list of all the tests there. One
   sentence description for each. Keep this list and descriptions synced when
   updating the file.
8. Don't test that A calls B. Test what A does:
     - Returns expected output
     - Throws (or doesn't throw) specific errors
     - Writes expected data to files or database
     - Sends correct payload to an API
     - Receives and handles API responses correctly

   Where A or B can be: a notebook, library, module, class, method, or function.
9. Don't duplicate code in tests - test the actual implementation. Tests must
   import and test the actual code, not recreate it. If code lives in a
   location where it can't be imported (like a notebook), extract it into a
   module first, and test by importing from it.

## Test categories

Tests are organized into two categories: unit tests and integration tests.

### Decision Guide: Unit vs Integration

| If the test needs... | Put it in... |
|---------------------|--------------|
| Database connection | `tests/integration/` |
| External API calls | `tests/integration/` |
| Remote file system access (S3, FTP, etc.) | `tests/integration/` |
| Cloud service operations | `tests/integration/` |
| Only mocks, pure logic, and access to the local file system | `tests/unit/` |

### Unit Tests (`tests/unit/`)

- **No external dependencies** - no database, no network (except the local
  file system or mocks)
- **Use mocks** for any external interactions
- **Fast execution** - should run in milliseconds
- **Test logic in isolation** - test individual functions and methods

```python
# Good: Unit test with mock
def test_system_setting_get_typed_value():
    setting = Mock(spec=SystemSetting)
    setting.value = "42"
    setting.value_type = "int"

    result = SystemSetting.get_typed_value(setting)

    assert result == 42
```

### Integration Tests (`tests/integration/`)

- **Test real interactions** - database queries, API calls, remote file
  operations (S3, FTP, etc.)
- **Use the framework's database marker** for database tests
- **Slower execution** - acceptable, they test real systems
- **Test component interactions** - how parts work together

```python
# Good: Integration test with real database
@pytest.mark.django_db
def test_system_setting_get_returns_typed_value():
    SystemSetting.objects.create(key="test", value="100", value_type="int")

    result = SystemSetting.get("test")

    assert result == 100
```
