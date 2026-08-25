# C# / .NET Standards (Local Rules)

## 1. Type Design & Models
- Follow modern .NET conventions (C# 10+) and enable nullable reference types (`<Nullable>enable</Nullable>`).
- Prefer `sealed record` or `readonly record struct` for immutable DTOs and value objects.
- Use `interface` only for true service boundaries and test seams; avoid single-implementation interface bloat.
- Avoid `dynamic` in application code; use generics or explicit strongly typed contracts.

```csharp
public sealed record UserDto(Guid Id, string Email);

public interface IUserRepository
{
    Task<UserDto?> FindByIdAsync(Guid id, CancellationToken ct);
}
```

## 2. Immutability & State
- Prefer `init` accessors, positional record parameters, and immutable collections for shared state.
- Do not mutate input models in place; use non-destructive mutations (`with { ... }`).

## 3. Async Discipline & Cancellation
- Always pass `CancellationToken` through public async APIs.
- Never use `.Result` or `.Wait()` on asynchronous tasks (prevents deadlocks).
- Ensure `using` or `await using` is used for all disposable resources (streams, connections, clients).

```csharp
public async Task<Order> LoadOrderAsync(Guid orderId, CancellationToken ct)
{
    var order = await repository.FindAsync(orderId, ct);
    if (order is null)
    {
        throw new KeyNotFoundException($"Order {orderId} was not found.");
    }
    return order;
}
```

## 4. Formatting & Analyzers
- Run `dotnet format` to enforce formatting and analyzer fixes.
- Group and sort `using` directives; enable implicit usings when applicable.
