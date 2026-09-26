# React Best Practices

Modern React best practices focus on eliminating asynchronous waterfalls, reducing bundle size, deriving state during render, using function components with hooks, and relying on the React Compiler for memoization.

## 1. Highest-Impact Practices

### Eliminate Async Waterfalls

- Parallelize independent asynchronous work with `Promise.all()`.
- Defer `await` until the result is needed.
- Check inexpensive conditions before triggering asynchronous operations.
- Prevent chained waterfalls in API routes.

### Reduce Bundle Size

- Avoid barrel-file imports.
- Use dynamic imports for heavy components.
- Defer non-critical third-party libraries.

## 2. Server-Side Performance

- Hoist static I/O to module scope.
- Use per-request caching such as `React.cache`.
- Minimize serialization at React Server Component boundaries.

## 3. Client-Side Data Fetching

- Use SWR or TanStack Query for automatic request deduplication.
- Use passive event listeners for scroll performance.
- Version and minimize `localStorage` data.

## 4. Re-Render Optimization

- Derive state during render instead of synchronizing it with `useEffect`.
- Defer state reads until the values are used.
- Use lazy state initialization for expensive values.
- Avoid unnecessary `useMemo` and `useCallback`; the React Compiler can handle memoization.

## 5. Rendering Performance

- Use strategic `Suspense` boundaries.
- Avoid resetting state with `useEffect`; remount branches when appropriate.

## 6. Component Structure and Maintainability

- Keep one domain component or hook per file.
- Keep component APIs narrow and avoid oversized props objects.
- Use PascalCase for helpers that return JSX.

## 7. Modern React Patterns

- Use function components and hooks.
- Follow the Rules of Hooks strictly.
- Let the React Compiler handle memoization.
- Compute derived values inline during render.

## 8. Advanced Patterns and JavaScript Performance

- Preload resources based on user intent.
- Prefer statically analyzable import paths.
- Apply micro-optimizations only after addressing higher-impact issues.

## Summary

Modern React best practices prioritize eliminating latency, minimizing shipped JavaScript, and using React 19's compiler-driven optimizations while keeping components simple, predictable, and render-driven.