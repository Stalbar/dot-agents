# Verification Checklist

Execute these verification checks before declaring any task complete:

## 1. Clean Execution
- [ ] Run full project test suite (e.g. `pytest`, `npm test`, `cargo test`).
- [ ] Verify zero regressions in existing tests.
- [ ] Run project linter and type checker if configured.

## 2. Call-Graph Reachability Gate
- [ ] Grep production entry points (`cli`, `routes`, `handlers`, `main`) for new functions or classes.
- [ ] Confirm at least one active caller exists. Zero callers = dead code = NOT complete.

## 3. The Gap Round
- [ ] Explicitly identify any scenarios NOT verified by tests (e.g., live cloud credentials, hardware timers).
- [ ] Report gaps transparently in the completion report.
