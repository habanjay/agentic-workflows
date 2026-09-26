# React UI Best Practices

Follow these principles to build maintainable, scalable, and testable React components.

## Component Design Principles

### 1. Single Responsibility Principle

Each component should focus on one functionality or UI element. This improves reusability, simplifies testing, and reduces bugs.

For example, instead of creating one large `UserProfile` component, consider extracting focused components such as `ProfilePicture`, `UserName`, and `UserBio`.

### 2. Functional Components and Hooks

Use functional components rather than class components. Use hooks such as:

- `useState` for local state
- `useEffect` for side effects
- `useMemo` for expensive derived values when profiling justifies it
- `useCallback` when a stable callback identity is required

Keep components simple and composable. Do not add memoization by default without a measurable reason or an established project convention.

### 3. Treat Props as Readonly

Props are immutable inputs. Do not modify them directly. Use local state or callback props to manage changes and communicate updates to parent components.

### 4. Keep State Minimal and Well-Scoped

- Keep state in the narrowest component that needs it.
- Lift state to the nearest common ancestor when multiple components need access.
- Prefer immutable updates.
- Avoid deeply nested state when flatter structures are sufficient.
- Use context only for genuinely shared concerns, such as theming or authentication.

### 5. Use Stable Keys for Lists

When rendering lists, provide unique and stable keys. Do not use array indexes when items can be reordered, inserted, or removed.

## Component Architecture and Organization

### 1. Use an Organized Project Structure

Place each component in its own folder when the component has related files or meaningful complexity. Co-locate supporting files such as:

- `index.ts` or `index.tsx`
- `types.ts`
- `hooks.ts`
- Utilities
- Tests
- Stories, when the project uses Storybook

Follow the repository's existing structure when it differs from this pattern.

### 2. Separate Containers and Presentational Components

When the feature has enough complexity to justify the split:

- **Presentational components** render UI and handle local user interactions.
- **Container components** coordinate state, data fetching, business logic, and callbacks.

Do not force this pattern onto small components where it would add unnecessary indirection.

### 3. Build Reusable, Modular Components

Design components around clear contracts and typed props. Avoid hard-coded domain values; pass configurable values through props or use appropriately scoped context.

Keep reusable components independent of page-specific data fetching and business rules.

### 4. Optimize Based on Evidence

- Use `React.memo` when a component re-renders unnecessarily and memoization addresses the measured cost.
- Use `useMemo` for expensive calculations, not for every derived value.
- Use `useCallback` when callback identity affects memoized children or hook dependencies.
- Prefer simpler component boundaries and state ownership before adding performance abstractions.

## Additional Best Practices

### Typed Props and Defaults

Define explicit TypeScript types for props, state, events, and external data. Use default parameter values or fallback logic for optional props instead of relying on deprecated `defaultProps` patterns for function components.

### Consistent Component Style

Follow one component declaration style throughout the project, whether that is arrow functions or function declarations. Match the repository's formatting and lint configuration.

### TypeScript Integration

Use TypeScript to improve safety for props, state, events, API-shaped mock data, and component boundaries. Avoid `any` unless an external boundary makes it unavoidable.

## Outcome

Applying these practices produces React components that are easier to understand, test, reuse, and evolve as the application grows.