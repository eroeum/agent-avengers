---
description: C# and .NET conventions, patterns, and best practices for ASP.NET Core, Entity Framework Core, xUnit, and general C# development.
user-invocable: false
---

# C# / .NET Conventions

## Code Style & Idioms
- SOLID principles and proper use of interfaces
- Async/await patterns throughout -- no `.Result` or `.Wait()` blocking
- Nullable reference type annotations enabled and respected (`<Nullable>enable</Nullable>`)
- Use `required` modifier on properties that must be set
- Proper `IDisposable` / `using` patterns for resource cleanup
- LINQ usage where appropriate (not over-chained)
- Dependency injection over static/singleton abuse
- Use records for immutable data transfer objects
- Replace nested if/else with early returns (guard clauses)
- Replace manual null checks with null-conditional operators (`?.`, `??`)
- Apply pattern matching where it simplifies conditionals
- Apply generic constraints (`where T : class, IEntity`)
- Use `Span<T>` and `Memory<T>` to reduce heap allocations on hot paths

## Frameworks

### ASP.NET Core
- Controllers, services, repositories, middleware pipeline
- Clean Architecture: Domain, Application, Infrastructure, Presentation layers
- Use `[ApiController]` attribute for automatic model validation
- Define request/response DTOs -- never expose entities directly
- Use `ActionResult<T>` return types for proper OpenAPI documentation
- Apply `[Authorize]` and policy-based authorization
- Use `IActionResult` helpers (`Ok()`, `NotFound()`, `BadRequest()`)
- Configure Swagger/OpenAPI with Swashbuckle or NSwag
- MediatR for CQRS, FluentValidation for input validation
- AutoMapper for DTO mapping
- Configure response compression and output caching

### Entity Framework Core
- Check migration state with `dotnet ef migrations list`
- Use `Include()` and `ThenInclude()` for eager loading (fix N+1)
- Use `AsNoTracking()` for read-only queries
- Use compiled queries for hot paths
- Review `OnModelCreating` for proper index and constraint configuration
- Migrations: `dotnet ef migrations add`, `dotnet ef database update`
- Use raw SQL with `FromSqlRaw` only when LINQ is insufficient

## Testing
- Frameworks: xUnit (preferred), NUnit, MSTest
- Use `[Fact]` for single cases, `[Theory]` + `[InlineData]` for parameterized tests
- Mock with Moq (`Mock<IService>`) or NSubstitute
- Run: `dotnet test --verbosity normal`
- Use builder patterns for complex test data
- Test async methods with `async Task` return types

## Security
- SQL injection in raw `SqlCommand` (use parameterized queries or EF Core)
- LINQ injection in dynamic query construction
- Missing `[Authorize]` attributes on controllers/actions
- `[ValidateAntiForgeryToken]` missing on state-changing endpoints
- Over-posting / mass assignment (use DTOs, not entity binding)
- Insecure `appsettings.json` secrets (use User Secrets or Key Vault)
- Disabled HTTPS redirection or HSTS

## Performance
- Use `async`/`await` throughout -- avoid blocking calls
- Use `IAsyncEnumerable` for streaming large datasets
- Profile with `dotnet-counters`, `dotnet-trace`, or BenchmarkDotNet

## Documentation
- XML doc comments (`/// <summary>`, `<param>`, `<returns>`, `<exception>`)
- Document all public classes, methods, and properties
- Use `<example>` tags for usage examples
- Use `<inheritdoc/>` for interface implementations
- Reference types with `<see cref="TypeName"/>`

## Dependencies
- Files: `*.csproj`, `Directory.Packages.props`, `nuget.config`
- Audit: `dotnet list package --outdated`, `dotnet list package --vulnerable`
- Watch for: central package management, framework-coupled packages (Microsoft.*)

## CI/CD
- `dotnet restore` failures (NuGet feed authentication)
- SDK version mismatch (check `global.json`)
- `dotnet build` warnings treated as errors
- EF Core migration conflicts
- Test failures from missing connection strings or config

## Debugging
- Read the `InnerException` chain -- root cause is often nested
- Common: `NullReferenceException`, `InvalidOperationException`, `ArgumentException`
- Check DI registration in `Program.cs` / `Startup.cs`
- Async issues: look for deadlocks from `.Result` or `.Wait()`
- Run: `dotnet build` to check compilation, `dotnet run` to reproduce

## Regex
- Use verbatim strings (`@"pattern"`)
- Named groups: `(?<name>...)`
- `Regex.IsMatch()` for validation, `Regex.Match()` for extraction

## Logging
- `ILogger` output, Serilog structured logs, Application Insights
- Unhandled middleware exceptions, EF Core query warnings, DI resolution failures
