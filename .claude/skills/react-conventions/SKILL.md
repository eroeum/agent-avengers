---
description: React conventions, patterns, and best practices for components, hooks, state management, testing, and general React/Next.js development.
user-invocable: false
---

# React Conventions

## Code Style & Idioms
- Rules of Hooks followed (no conditional hooks)
- Proper dependency arrays in useEffect/useMemo/useCallback
- State colocation -- state lives where it's used
- Controlled components for forms
- Key props on list items (no index keys for dynamic lists)
- No unnecessary re-renders (memoization used appropriately)
- Component composition over inheritance
- Extract reusable logic into custom hooks
- Feature-based folder structure or domain-driven grouping
- Prefer functional components with hooks over class components
- Colocate state with the components that use it
- Replace prop drilling with Context or composition patterns

## State Management
- React Context for low-frequency global state
- Zustand, Redux Toolkit, or Jotai for complex state
- TanStack Query (React Query) or SWR for server state
- Keep state as local as possible

## Testing
- Framework: Jest + React Testing Library (preferred), Vitest as alternative
- Query by role, label, text -- not by class or test ID
- Use `render`, `screen`, `userEvent` from Testing Library
- Mock API calls with MSW (Mock Service Worker) or jest.mock
- Test hooks with `renderHook` from `@testing-library/react`
- Run: `npm test` or `npx jest`
- Avoid testing implementation details (no shallow rendering)

## Security
- `dangerouslySetInnerHTML` with unsanitized input
- XSS via `href="javascript:"` in user-controlled links
- API keys or secrets in client-side code or `.env` files in build output
- Missing CSRF tokens on state-changing fetch/axios calls
- Insecure `postMessage` usage without origin validation
- Server-side rendering (SSR) injection risks

## Performance
- Memoize components with `React.memo` where props are stable
- Use `useMemo` / `useCallback` to avoid recalculating on every render
- Virtualize long lists with `react-window` or `react-virtuoso`
- Code-split with `React.lazy` and `Suspense`
- Avoid state in parent components when only children need it
- Profile with React DevTools Profiler

## Accessibility
- `<img>` tags missing `alt` prop (or empty for decorative)
- Form inputs without associated `<label>` (via `htmlFor`)
- Click handlers on non-interactive elements (use `<button>` not `<div onClick>`)
- Missing `role` and ARIA props on custom interactive widgets
- Focus management after route changes (react-router)
- Modal focus trapping (portals, dialog elements)
- `aria-live` regions for state-driven UI updates

## Dependencies
- Files: `package.json`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
- Audit: `npm audit`, `npm outdated`, `npx depcheck`
- Watch for: React 18+ compatibility of third-party component libraries

## CI/CD
- Build failures from TypeScript strict mode errors
- Jest test failures from missing environment variables
- `npm ci` or `yarn install --frozen-lockfile` failures
- ESLint/Prettier formatting conflicts
- Build output size exceeding configured limits

## Debugging
- Read the error boundary or console error with component stack
- Common: "Cannot read properties of undefined", "Invalid hook call", "Too many re-renders"
- Check useEffect dependency arrays for missing or incorrect deps
- State update issues: look for stale closures and batching problems
- Check for conditional hook calls violating Rules of Hooks
- Profile with React DevTools

## Migration
- React major version upgrades (class to hooks, concurrent features)
- State management library migrations (Redux to Zustand, etc.)
- Build tool migrations (CRA to Vite, Webpack to Vite)
- React Router version upgrades (v5 to v6 loader pattern)

## Documentation
- JSDoc/TSDoc on components, hooks, and utility functions
- Document prop types with `@param` tags or inline with TypeScript interfaces
- Include usage examples showing JSX with typical props
- Document custom hooks with parameter and return value descriptions

## Logging
- Unhandled promise rejections, component stack traces
- Hydration mismatches (SSR)
- Error boundary catch logs
