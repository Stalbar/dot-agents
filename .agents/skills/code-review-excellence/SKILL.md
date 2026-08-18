---
name: code-review-excellence
description: Systematic, constructive code review focusing on correctness, security, performance, simplicity, and maintainability.
---

# Code Review Excellence

Transform code review into systematic quality and security verification.

---

## Review Dimensions

1. **Correctness & Edge Cases**: Boundary conditions, null/empty handling, off-by-one errors, async race conditions.
2. **Simplicity & YAGNI**: Reject unnecessary abstractions, unneeded dependencies, and speculative complexity.
3. **Security**: Injection vulnerabilities, unvalidated input boundaries, secret leaks, unauthorized access.
4. **Performance**: Algorithmic complexity (O(n²)), memory leaks, redundant database queries / network roundtrips.
5. **Testing**: Adequacy of test coverage, failure behavior verification, lack of skipped tests.

---

## Feedback Format

- **Summary**: Concise high-level verdict.
- **Blocking Issues**: Must be fixed before merge.
- **Improvements**: Recommended simplifications or optimizations.
