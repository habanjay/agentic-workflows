
# Tailwind CSS v4.3+ Best Practices

Follow a utility-first mindset, leverage theme variables, organize code consistently, and optimize performance for maintainable Tailwind CSS v4.3+ projects.

## 1. Embrace Utility-First Design

Style elements directly with utility classes for layout, spacing, typography, and colors. Avoid custom CSS unless Tailwind utilities cannot express the required design.

## 2. Use Theme Variables and `@theme` Blocks

Define design tokens such as colors, fonts, spacing, shadows, and breakpoints in `@theme` blocks using native CSS variables. Promote repeated values to theme variables instead of repeatedly using arbitrary values such as `bg-[#...]`.

## 3. Organize Classes Consistently

Use a consistent utility-class order:

1. Layout: `flex`, `grid`, `gap-*`
2. Sizing: `w-*`, `h-*`
3. Typography: font family and text size
4. Colors: background and text colors
5. States: `hover:`, `focus:`, and `active:`

Consistent ordering makes classes easier to scan and reduces duplication.

## 4. Optimize Performance

Tailwind CSS v4.3+ automatically generates the CSS it needs. Keep the final stylesheet lean by using statically discoverable class names and removing obsolete styles and dependencies.

## 5. Prefer Semantic HTML

Tailwind styles elements but does not provide semantics. Prefer semantic HTML over excessive ARIA attributes or non-standard markup to improve accessibility.

## 6. Keep Styles Close to HTML

Keep styles near the consuming markup to simplify maintenance and reduce inconsistencies. Extract components when they provide meaningful reuse.

## 7. Leverage Modern CSS Features

Tailwind CSS v4.3+ supports cascade layers, OKLCH colors, container queries, and native CSS variables. Use feature queries for progressive enhancement, avoid `!important`, and rely on proper layer placement.

## 8. Build Responsive, Scalable Interfaces

Use a mobile-first approach and responsive utilities for fluid layouts. Define breakpoints in theme variables to keep responsive behavior consistent across the project.

## Summary

These practices help produce Tailwind CSS v4.3+ projects that are consistent, accessible, performant, and maintainable as they grow.