# Code Review Checklist & Rubric

## 1. Correctness & Logic
- Edge cases handled: null, empty lists, boundary numbers, missing dictionary keys.
- Error handling: graceful degradation, specific exceptions, no bare `except:` or swallowed errors.
- Concurrency: race conditions, thread safety, transaction boundaries.

## 2. Security Guardrails
- Secrets: zero hardcoded credentials, tokens, or private keys.
- Injection: parameterized SQL queries only; no raw string concatenation in queries or subprocesses.
- Input validation: boundaries validate types, lengths, and schemas before business logic.

## 3. Simplicity & YAGNI (Ponytail)
- Standard library preferred over external dependencies.
- Zero unrequested abstractions, unnecessary design patterns, or speculative generics.
- Shortest working diffs.

## 4. Modularity & Maintainability
- Functions under 50 lines; modules under 300 lines; nesting depth <= 4 levels.
- Pure business logic decoupled from I/O.
- Call-graph reachability verified: newly added symbols are actively invoked by entry points.

## 5. Read-Only Static Sweep (Hunter Mode)
- Scan repository for latent bug classes, orphaned files, dead code, and unhandled promises/coroutines.
