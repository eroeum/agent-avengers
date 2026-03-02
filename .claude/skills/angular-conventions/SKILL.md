---
description: Angular conventions, patterns, and best practices for components, services, RxJS, Angular Material, testing, and general Angular development.
user-invocable: false
---

# Angular Conventions

## Code Style & Idioms
- Smart (container) vs presentational (dumb) component separation
- Proper use of OnPush change detection strategy
- RxJS subscription cleanup (takeUntil, async pipe, or DestroyRef)
- Lazy loading for feature modules and routes
- Reactive forms over template-driven for complex forms
- No direct DOM manipulation -- use Renderer2 or directives
- Feature modules with lazy loading
- Core module (singletons) vs shared module (reusable components)
- Interceptors for cross-cutting concerns (auth, error handling)
- Extract repeated template logic into pure pipes
- Move business logic from components into services
- Replace manual subscriptions with the `async` pipe
- NgRx or signal-based state management

## Architecture
- Feature modules with lazy loading
- Core module (singletons) vs shared module (reusable)
- Smart/container components vs presentational/dumb components
- Interceptors for auth, error handling, logging
- Route guards for protected pages

## Testing
- Framework: Jasmine + Karma (default), or Jest if configured
- Use `TestBed.configureTestingModule` for component/service setup
- Test components with `ComponentFixture` and `DebugElement`
- Mock services with `jasmine.createSpyObj` or provide test doubles
- Use `fakeAsync` + `tick` for async operations
- Run: `ng test` or `npx jest`
- Test observables with `subscribe` or marble testing

## Security
- Bypassing DomSanitizer (`bypassSecurityTrustHtml` misuse)
- Interpolation in `innerHTML` bindings
- Missing CSRF/XSRF token interceptor (`HttpClientXsrfModule`)
- Exposing API keys in `environment.ts` files shipped to the browser
- Open redirect via unvalidated `Router.navigate` targets
- Insufficient route guards on protected pages

## Performance
- Use `OnPush` change detection strategy on components
- Replace repeated computations in templates with pure pipes
- Use `trackBy` on `*ngFor` to minimize DOM updates
- Unsubscribe from observables to prevent memory leaks
- Use virtual scrolling (`cdk-virtual-scroll-viewport`) for long lists
- Bundle analysis with `ng build --stats-json` + webpack-bundle-analyzer

## Accessibility
- `<img>` tags in templates missing `[alt]` binding
- `mat-form-field` without `<mat-label>`
- `routerLink` elements missing accessible labels
- `*ngFor` lists missing proper list semantics (`role="list"`)
- `cdkTrapFocus` usage in modals and dialogs
- Angular Material component accessibility configuration
- `aria-live` regions for async-loaded content

## Dependencies
- Keep `@angular/*` packages version-aligned
- Use `ng update` for upgrades
- Files: `package.json`, `package-lock.json`, `yarn.lock`
- Audit: `npm audit`, `npm outdated`, `npx depcheck`

## CI/CD
- `ng build --configuration production` failures (AOT compilation errors)
- Node version mismatch (check `.nvmrc` or `engines` in `package.json`)
- `npm ci` failures from stale `package-lock.json`
- Karma/Jest test timeouts in headless Chrome
- `ng lint` failures from ESLint rule violations

## Debugging
- Read the full error in the browser console and terminal
- Common: `NullInjectorError` (missing provider), `ExpressionChangedAfterItHasBeenCheckedError`
- Check module imports, provider declarations, and component selectors
- RxJS: look for unsubscribed observables and operator ordering
- Zone.js: check for code running outside Angular's zone

## Migration
- Angular major version upgrades (use `ng update`)
- RxJS version upgrades (operator API changes)
- Angular Material / CDK version alignment
- Module-based to standalone component migration
- Template syntax changes (control flow: `@if`, `@for`)

## Documentation
- JSDoc/TSDoc (`/** */`) on services, components, and public methods
- Document `@Input()` and `@Output()` properties
- Include usage examples showing component selector and bindings
- Document route configurations and guards

## Logging
- `ExpressionChangedAfterItHasBeenCheckedError` patterns
- HTTP error responses in interceptors
- RxJS error handling in operators
