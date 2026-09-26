
# TypeScript Best Practices

The most important TypeScript practices include enabling strict mode, avoiding `any`, using precise types and discriminated unions, leveraging modern language features, and maintaining a clean project configuration.

## 1. Core Configuration

### Enable Strict Mode

Strict mode activates TypeScript's strongest safety checks, including:

- `strictNullChecks`
- `noImplicitAny`
- `strictFunctionTypes`
- `strictPropertyInitialization`
- `alwaysStrict`
- `noImplicitThis`

Recommended `tsconfig.json` settings:

```json
{
  "compilerOptions": {
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "moduleResolution": "node",
    "esModuleInterop": true,
    "skipLibCheck": true
  }
}
```

### Use Additional High-Value Flags

- `noUncheckedIndexedAccess` makes array and object indexing safer.
- `exactOptionalPropertyTypes` distinguishes missing properties from properties set to `undefined`.
- `noImplicitOverride` requires explicit `override` modifiers.

## 2. Type System Practices

### Use Type Inference

Let TypeScript infer obvious types and avoid redundant annotations:

```ts
const name = "John";
```

### Prefer `unknown` Over `any`

Use `unknown` for values with an uncertain type. It forces type narrowing and preserves type safety.

### Choose Interfaces and Types Intentionally

Use interfaces for extensible object shapes. Use type aliases for unions, tuples, mapped types, and other composed types.

### Use Discriminated Unions for State

Discriminated unions prevent impossible states and improve exhaustiveness checking:

```ts
type AsyncState<T> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: T }
  | { status: "error"; error: Error };
```

### Leverage Modern TypeScript Features

- Use the `satisfies` operator for precise constraint checking.
- Use template literal types for structured strings.
- Use branded types for safer identifiers.
- Use const type parameters when they improve inference.

## 3. Architecture and Scale

### Avoid Overly Complex Types

Use advanced types only when they improve clarity or enforce an important contract.

### Use Generics for Reusable Logic

```ts
function identity<T>(value: T): T {
  return value;
}
```

### Organize Code with Clear Boundaries

- Separate domain types from implementation details.
- Use modules with clear responsibilities.
- Use project references in monorepos.

## 4. Error Handling

### Use Typed Errors

Define structured error types instead of throwing arbitrary values.

### Narrow Caught Errors as `unknown`

```ts
try {
  // Operation that may fail.
} catch (error: unknown) {
  if (error instanceof Error) {
    console.error(error.message);
  }
}
```

## 5. Performance and Tooling

### Optimize Build Performance

- Use incremental builds.
- Use `typeRoots` to limit type lookup when appropriate.
- Use project references in monorepos.

### Avoid Excessive Runtime Assertions

Prefer compile-time safety and runtime validation over frequent type assertions.

## 6. Testing

- Write tests in TypeScript when the project uses TypeScript.
- Keep test fixtures and mocks type-safe.
- Avoid `any` in test code.

## Summary

Strict mode, precise typing, modern TypeScript features, and clear architecture form the foundation of effective TypeScript codebases.