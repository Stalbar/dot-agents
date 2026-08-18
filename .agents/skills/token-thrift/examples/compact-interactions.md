# Sample Compact Token-Thrifty Interactions

### Bad (Verbose, 400+ tokens wasted):
```
I have examined the entire file. Here is the full rewritten file with 300 lines of code:
[dumps entire 300 line file]
In this file I updated the timeout from 10 to 30. The timeout was changed because...
```

### Good (Compact, 35 tokens):
```python
# Updated timeout in ImapClient.cs:L45
client.TimeoutSeconds = 30
```
> `Skipped retry logic; add when transient network failures are observed in telemetry.`
