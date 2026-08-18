# Coding Standards

## General Principles

0. Code should be readable and well structured.
1. Code (methods, classes, modules) should be written to be easily testable
   with unit and integration tests.
2. No changes without confirmation. Always ask before implementing.
3. Follow existing patterns. Maintain consistency with the codebase.
4. Type safety. Use type hints where the language supports them.
5. Error handling. Comprehensive try/catch with fallbacks, never crash.
6. Logging over print. Use the project's logging practices for diagnostics,
   never print().

## Language sections

{{LANGUAGE_SECTIONS}}

(Selected at init from the grill-me answers: style, package manager,
test framework, lint tool. Stack-specific rules live in
`.agents/rules/*_local.md`.)

## Code Organization

### Imports

Standard library, then third-party, then local. One blank line between groups.

### Function documentation

Document Args and Returns. Keep docstrings accurate when signatures change.

## Configuration management

- Use the project's config module for all config.
- Never hardcode values. Use environment variables.

## Constants

- Never use magic strings for keys, identifiers, or defaults.
- Define constants in one place, grouped by topic.

## Testing

- Run the full suite before committing.
- Add tests for new features.
- Mock external dependencies.
- Test error conditions.
- See `.agents/rules/tests.md` and `.agents/rules/modularity.md`.

## Linting

- Use the project's linter, configured in the project config.
- Fix linting issues before committing.

## Documentation

- Update relevant docs when making changes.
- Create change plans for significant modifications.
- Keep README and docs up to date.
- Document complex logic with concise comments.
