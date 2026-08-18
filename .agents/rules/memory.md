# Workspace Memory & Context Rules

Persistent files provide reliable, token-efficient memory across agent sessions.

---

## 1. The Three Tiers of Memory

1. **Tier 1: Invariant Project Memory (Long-Term)**
   - `architecture.md`: System design, technology choices, patterns, domain model.
   - `coding_standards.md`: Code formatting, naming, lint rules, test patterns.
   - `USER.md`: Human developer preferences, communication style, and constraints.
   - `rules/`: Governance and domain invariants.

2. **Tier 2: Consolidated Project State (Medium-Term)**
   - `context.md`: Current milestone, active tasks, recent changes, known issues, open questions.
   - Updated freely by agents upon completing milestones or running `/update-context`.

3. **Tier 3: Daily Activity & Debugging Logs (Short-Term / Rolling)**
   - `memory/YYYY-MM-DD.md`: Rolling log of daily tasks, experiments, command output summaries, and failed attempts.
   - Preserves granular trial-and-error context so subsequent sessions do not repeat mistakes.

---

## 2. Daily Log Format (`memory/YYYY-MM-DD.md`)

When executing multi-step tasks or complex debugging, append notes to `memory/YYYY-MM-DD.md`:

```markdown
# Daily Log: YYYY-MM-DD

## Session: <Time / Task Title>
- **Goal:** <One-sentence objective>
- **Attempted:** <What was tried, files modified>
- **Outcome:** <Success / Error logs / Test results>
- **Takeaway:** <What worked or what to avoid in future steps>
```

---

## 3. Memory Compaction & Maintenance

- **Garbage Collection**: Do not let daily logs clutter context. Agents read `memory/YYYY-MM-DD.md` only when researching past attempts or resuming recent work.
- **Milestone Compaction**: When a major feature or bugfix is completed, summarize key lessons into `context.md` or an ADR, and archive/truncate old daily logs.
