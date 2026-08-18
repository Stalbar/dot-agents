# Root Cause Tracing Techniques

## 1. Backward Stack & Data Tracing
- When an error occurs deep in the call stack, do not patch where the exception is thrown.
- Trace the bad state (null value, invalid type, empty string) backwards up the call stack to the originating caller.
- Fix the problem at the source where the invalid state was first introduced.

## 2. Multi-Component Boundary Logging
When investigating bugs across service boundaries (e.g. API -> Database -> External Service):
1. Add minimal diagnostic logging at each boundary entry and exit point.
2. Run once to pinpoint the exact failing boundary layer.
3. Remove or clean up diagnostic logging before committing.

## 3. The Rule of Three Failures
If 3 consecutive fix attempts fail to resolve the issue:
- **STOP immediately.** Do not attempt a 4th fix.
- Re-examine core architectural assumptions, data models, or discuss with the human partner.
