---
name: html-mockup-to-react
description: 'Generate React 19+ and TypeScript 7+ components from an HTML file or UI mockup. Use when the user asks to generate React/TypeScript code based on an HTML mockup, HTML file, static design, or mockup components, including reusable headers, footers, navigation, dashboards, and page sections.'
argument-hint: 'Path to the HTML/mockup and the React/TypeScript output or feature to build'
user-invocable: true
disable-model-invocation: false
---

# HTML Mockup to React

Convert an HTML file or visual mockup into maintainable, reusable React and TypeScript code while preserving the intended layout, visual hierarchy, responsive behavior, and interactions.

## When to Use

Use this skill when the request includes phrases such as:

- "generate the React/TypeScript component based on the HTML file"
- "convert this HTML mockup to React"
- "dissect this mockup into reusable React components"
- "build the header, footer, navigation, or page sections from this design"

## Procedure

### 1. Establish the implementation surface

1. Locate and read the complete mockup file before editing. Inspect linked stylesheets, scripts, images, fonts, and asset paths that affect its rendering.
2. Inspect the existing project structure, `package.json`, TypeScript configuration, routing setup, styling conventions, and test scripts.
3. Find project-specific component and styling guidance under `/references`, `./references`, or the repository's documented conventions. Read the relevant guidance before designing components, including the Tailwind CSS v4.3+ reference when present. If no reference directory exists, use Tailwind CSS v4.3+ with standard React accessibility practices unless the project already uses an established styling system.
4. Confirm the target output path and entry point. Preserve existing application architecture rather than introducing a parallel framework or styling system.

### 2. Decompose the mockup

1. Identify page-level regions and repeated UI patterns: header, navigation, sidebar, footer, hero, tables, cards, forms, dialogs, and repeated rows or tiles.
2. Make a region a component when it has a distinct responsibility, repeated structure, independent state, a meaningful semantic boundary, or a likely reuse case. Keep purely presentational fragments local when extraction would add indirection without reuse.
3. Use semantic HTML and accessible names, labels, landmarks, keyboard behavior, focus states, and appropriate button/link elements. Do not replace working navigation links with inert click handlers.
4. Keep components focused. Pass data and callbacks through typed props; do not hide page-specific data in reusable components.
5. Preserve the mockup's responsive layout and visual intent with Tailwind CSS v4.3+ utility classes. Use the project's existing design tokens and components where available; do not introduce a second styling system into an established project.

### 3. Define data and interaction boundaries

1. Replace hard-coded domain records with typed mock data in a clearly named data module or fixture: users, stock, ledger entries, valuations, metrics, menu items, and similar records.
2. Keep mock data shaped like the future API contract so it can be swapped without rewriting presentation components. Separate data fetching or selection from rendering.
3. Model loading, empty, error, disabled, and selected states when the mockup or workflow implies them.
4. Wire navigation through the existing router when one is present. For a simple app without a router, use real links and a minimal local route strategy only when appropriate.
5. Preserve meaningful interactions from the mockup, including menus, tabs, forms, filters, sorting, and responsive navigation. Ensure state is owned by the narrowest component that needs it.

### 4. Implement with the current toolchain

1. Use React 19 or newer and TypeScript 7 or newer where the project supports those versions. Check installed versions and package-manager constraints before changing dependencies.
2. If the repository is already a React project, extend its existing setup. If it is not, determine whether the user expects a complete project scaffold; do not silently replace unrelated project files.
3. Use Tailwind CSS v4.3+ for styling. Prefer utility classes for layout, sizing, typography, colors, states, and responsive behavior over custom CSS.
4. Define repeated colors, fonts, spacing, shadows, and breakpoints as theme variables or existing project design tokens. Avoid repeating arbitrary values.
5. Order utility classes consistently: layout, sizing, typography, colors, then interaction states.
6. Use mobile-first responsive utilities, semantic HTML, and visible focus states. Do not use styling classes as a substitute for accessible markup.
7. Use strict, explicit TypeScript types for props, mock records, event handlers, route data, and component state. Avoid `any` unless an external boundary makes it unavoidable and the exception is documented locally.
8. Keep components testable and avoid unnecessary global state, duplicated markup, or premature abstractions.
9. Keep edits limited to the mockup feature and required supporting files. Do not refactor unrelated code.

### 5. Validate progressively

Run the repository's existing commands, using the package manager specified by its lockfile:

1. Run linting and type checking, fixing errors introduced by the implementation.
2. Run the focused component or unit tests, then the project's full test command when available.
3. Run the production build and fix compile, asset, route, and bundling failures.
4. Start the development server when browser validation is supported. Test every primary navigation link and route, including direct loading of a route, active navigation state, back/forward behavior where applicable, and mobile navigation behavior.
5. Verify the rendered page at desktop and mobile widths. Check that content does not overlap, assets load, controls are keyboard accessible, and the console has no new errors.
6. If browser automation is unavailable, use the strongest available route/component tests and clearly report the unverified browser checks.

## Completion Criteria

The work is complete only when:

- The mockup has been read and its relevant regions are represented by appropriately scoped components.
- Repeated UI is reusable and receives typed props rather than copied markup.
- Domain values come from replaceable typed mock data rather than being embedded in presentation logic.
- The implementation follows the repository's component, styling, routing, and reference guidance.
- React and TypeScript versions meet the requested minimums or any compatibility limitation is explicitly reported.
- Lint, type checking, tests, and build pass, or failures are identified with their cause.
- Primary navigation has been exercised and works at supported viewport sizes.

## Output Summary

Report the created or updated components, mock-data modules, routes and interactions, validation commands and results, and any remaining limitations. Include file links for the main implementation files.
