# Go Standards (Local Rules)

## 1. Error Handling
- Never ignore returned errors (`_`). Handle or wrap errors with context using `fmt.Errorf("action failed: %w", err)`.
- Use custom error sentinel types or `errors.Is` / `errors.As` for inspecting wrapped errors.

```go
func LoadUser(ctx context.Context, id string) (*User, error) {
    user, err := repo.Find(ctx, id)
    if err != nil {
        return nil, fmt.Errorf("loading user %s: %w", id, err)
    }
    return user, nil
}
```

## 2. Context & Concurrency
- `context.Context` must always be the first parameter in I/O bound functions.
- Never store contexts inside structs; pass them explicitly down the call chain.
- Prevent goroutine leaks: always ensure goroutines terminate when contexts cancel or channels close.

## 3. Interfaces & Dependency Inversion
- Accept interfaces, return concrete structs.
- Define interfaces where they are consumed, not where they are implemented. Keep interfaces small (1-2 methods).

## 4. Testing
- Use table-driven tests with descriptive subtest names (`t.Run(tc.name, ...)`).
- Run `go test -race ./...` and `golangci-lint run` before committing.
