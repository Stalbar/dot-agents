# Sample Code Review Output

```markdown
## Summary
PR adds mailbox synchronization timeout handling. Overall clean and well tested, with 1 blocking edge case.

## Blocking Issues
1. **Unbounded Retry on 504 Gateway Timeout (`ImapClient.cs:L45-L52`)**
   - *Problem:* Retries infinitely if mail server is unresponsive, holding connection pool slots.
   - *Fix:* Cap retry attempts at 3 with exponential backoff.

## Recommended Simplifications (Ponytail)
1. **Remove `IMailboxSyncStrategyFactory` (`Factories/SyncFactory.cs`)**
   - *Problem:* Factory pattern wrapping a single concrete class.
   - *Fix:* Inject `MailboxSyncService` directly into the controller.

## Verified Tests
- [x] Unit test `test_sync_timeout_aborts_cleanly` passes (verified via `dotnet test`).
- [x] Full test suite green (28/28 tests passed).
```
