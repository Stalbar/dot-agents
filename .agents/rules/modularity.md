# Modularity

Code must be modular so it can be tested in isolation. These rules apply to
every language the project uses.

1. **Single responsibility.** Each function, class, and module does one thing.
   If you need "and" to describe what it does, split it.
2. **Pure logic at the core.** Business logic lives in pure functions that take
   input and return output. I/O (files, network, database) lives at the edges.
3. **Dependency injection.** A function that needs a client, connection, or
   config receives it as a parameter. Do not create hidden dependencies inside.
4. **No logic trapped in entry points.** Notebooks, scripts, CLI entry points,
   and main() functions contain wiring only. Extract real logic into importable
   modules and import it from the entry point.
5. **Module and Function size.** Functions must stay focused (< 50 lines).
   Default module limit: 300 lines per module. Maximum nesting depth: 4 levels.
   If code exceeds these bounds, extract helper functions or split modules.
6. **Immutability First.** Prefer non-destructive state transitions (immutable
   records/DTOs, spread updates, pure transforms) over in-place mutation of
   shared state.
7. **Constants over magic values.** Named constants for identifiers, keys,
   defaults, and limits. Group related constants in one place.
8. **Import order.** Standard library, then third-party, then local. One blank
   line between groups.
9. **Testability.** Every new module must be importable by tests without side
   effects at import time. Module top level contains definitions only, no work.
10. **Call-Graph Reachability Gate.** After wiring any new feature, service, or
    endpoint, grep production entry points to confirm it is actually called.
    Compilation is not proof of wiring. If a new symbol has zero callers from
    application entry points, it is dead code and not done.
