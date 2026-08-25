# Security Standards (Local Rules)

## 1. Trust Boundaries & Input Sanitization
- Treat all data from HTTP requests, query parameters, CLI inputs, message queues, and external APIs as untrusted.
- Validate types, lengths, ranges, and characters using schemas before processing.

## 2. Secrets & Credentials Protection
- Never hardcode secrets, API keys, database passwords, or JWT secrets in code or commits.
- Load secrets via environment variables or secret vaults.
- Never output raw secret values or authorization headers to log streams or console output.

## 3. Injection Prevention
- Use parameterized queries or ORMs for all database interactions. Never concatenate raw strings into SQL queries.
- Escape command arguments when executing subprocesses; avoid passing unsanitized shell commands.
- Sanitize HTML/rendered strings to prevent Cross-Site Scripting (XSS).

## 4. Authentication & Authorization
- Enforce authorization checks at the service and data layer, not just the UI/route layer.
- Never use broken or custom cryptographic algorithms; rely on standard library primitives (e.g. `crypto/bcrypt`, `Argon2`, `AES-GCM`).
