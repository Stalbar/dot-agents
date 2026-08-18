# Sample Implementation Plan

# Add IMAP Connection Warm-Up Plan

**Goal:** Pre-warm IMAP TCP connections upon user authentication to reduce classification latency.
**Architecture:** Add `ImapWarmUpService` background task in `Imap.Services` triggered by OAuth success events.

---

### Task 1: Add WarmUp Interface and State
- **Files:**
  - Create: `Backend/Imap.Services/IImapWarmUpService.cs`
  - Test: `Backend/Imap.Services.Tests/ImapWarmUpServiceTests.cs`
- **Interfaces:**
  - Produces: `Task WarmUpAccountAsync(Guid accountId, CancellationToken ct)`
- **Steps:**
  1. [ ] Write unit test `test_warmup_establishes_connection` in `ImapWarmUpServiceTests.cs`.
  2. [ ] Verify test fails (`IImapWarmUpService` does not exist).
  3. [ ] Implement minimal `IImapWarmUpService` and `ImapWarmUpService`.
  4. [ ] Run `dotnet test Backend/Imap.Services.Tests` and confirm tests pass.
