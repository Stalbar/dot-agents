# ADR: SQLite State Storage for Task Runner

## Status

Approved (Gate R1)

## Date

2026-08-18

## Context & Problem Statement

The background task runner currently stores job execution state in memory. Restarting the process loses all in-flight job IDs and progress markers, causing duplicate job execution on restart.

## Considered Alternatives

### Option 1: Embedded SQLite Database
- **Description:** Use Python standard library `sqlite3` with a local database file.
- **Pros:** Zero new dependencies, ACID transactions, simple file-based backups.
- **Cons:** Single-writer concurrency limit.
- **Trade-offs:** Sufficient for single-node task runners; not distributed.

### Option 2: Redis Server
- **Description:** Connect to an external Redis instance over TCP.
- **Pros:** High throughput, built-in TTL support.
- **Cons:** Requires external daemon, connection failure handling, network latency.
- **Trade-offs:** Over-engineered for a local CLI task runner.

## Decision & Rationale

Select Option 1 (Embedded SQLite). The runner runs as a single local process, and Python's built-in `sqlite3` satisfies ACID requirements without external infrastructure dependencies.

## Consequences

- **Positive:** Crash resilience without external service dependencies.
- **Negative / Risks:** WAL mode required for concurrent reads during active writes.

## Implementation Steps

1. Create SQLite database schema migration script in `scripts/init_db.py`.
2. Implement repository interface in `runner/state.py` using stdlib `sqlite3`.
3. Add unit and transaction recovery tests in `tests/test_state.py`.
4. Wire task runner to write checkpoint state after each job step.
