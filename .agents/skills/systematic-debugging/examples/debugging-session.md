# Sample Systematic Debugging Session

```markdown
## Problem
Test `test_classify_timeout_fallback` failed with `NullReferenceException`.

## Phase 1: Root Cause Investigation
- Stack trace points to `BertService.cs:L89` trying to access `.Confidence` on `null`.
- Tracing backwards: `FastApiClassifierClient` returned `null` on HTTP 408 response instead of throwing `TimeoutException`.

## Phase 2: Pattern Analysis
- `ImapService.cs` correctly handles connection timeouts by returning a default `ClassificationResult.Fallback`.

## Phase 3: Single Hypothesis
- Hypothesis: `FastApiClassifierClient` needs to return `ClassificationResult.Fallback` when status is 408 / timeout.

## Phase 4: Targeted Fix & Verification
- Applied surgical fix in `FastApiClassifierClient.cs:L54-L58`.
- Ran `dotnet test Backend/Imap.Services.Tests/Imap.Services.Tests.csproj`.
- Result: 12/12 tests passed, 0 failures.
```
