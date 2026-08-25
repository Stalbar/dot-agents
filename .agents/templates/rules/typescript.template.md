# TypeScript / Web Standards (Local Rules)

## 1. Type Safety & Public APIs
- Explicit parameter and return types on all exported functions, services, and props.
- Avoid `any` in application code; use `unknown` for untrusted input and narrow safely.
- Prefer string literal unions (`type Status = 'pending' | 'active'`) over numerical enums.
- Use `interface` for extendable object shapes and `type` for unions/tuples/mapped types.

```typescript
export interface UserProfile {
  id: string;
  email: string;
}

export function formatDisplayName(user: UserProfile): string {
  return `${user.email} (${user.id})`;
}
```

## 2. Immutability & State Updates
- Prefer `Readonly<T>` for shared state and props.
- Use spread or non-mutating array methods (`map`, `filter`) rather than mutating in place (`splice`, `push`).

## 3. Error Handling & Narrowing
- Narrow `unknown` errors cleanly in try/catch blocks; never assume caught errors have a `.message` property without type checking.

```typescript
function getErrorMessage(error: unknown): string {
  if (error instanceof Error) return error.message;
  return String(error);
}
```

## 4. Input Validation & Trust Boundaries
- Validate external API, query, and form payloads using schema libraries (e.g. `zod`).
- Derive TypeScript types directly from schemas (`type UserInput = z.infer<typeof userSchema>`).

## 5. Console & Logging
- No `console.log` in production code; use structured loggers.
