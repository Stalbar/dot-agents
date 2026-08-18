# Code Review Comprehensive Checklist

## 1. Correctness & Edge Cases
- [ ] Boundary conditions: null, empty collections, zero values, off-by-one errors.
- [ ] Concurrency & async: race conditions, deadlocks, missing cancellation tokens.
- [ ] Error handling: exceptions caught at proper granularity; no swallowing errors.

## 2. Simplicity & YAGNI (Ponytail Alignment)
- [ ] No unrequested abstractions: single-implementation interfaces, premature factories.
- [ ] Standard library / native features preferred over adding dependencies.
- [ ] Shortest working diff: delete dead code; avoid speculative boilerplate.

## 3. Security Checks
- [ ] Injection prevention: SQL/command injection, parameterized queries.
- [ ] Secret handling: no hardcoded API keys, tokens, or private credentials.
- [ ] Input sanitization at all external trust boundaries.

## 4. Performance & Resource Management
- [ ] Query efficiency: no N+1 queries, unindexed filters, or unbounded in-memory allocations.
- [ ] Resource cleanup: proper disposal of streams, database connections, HTTP clients.

## 5. Testing & Verification
- [ ] Unit & integration tests present for all new behaviors and bugfixes.
- [ ] Test behavior, not call graphs or brittle mocks.
