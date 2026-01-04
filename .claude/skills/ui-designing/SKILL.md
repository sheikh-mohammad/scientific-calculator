---
name: ui-designing
description: Create super modern, aesthetic, and highly usable web UI for scientific calculators with clean layout, proper spacing, visual hierarchy, and responsive design using Tailwind CSS. Use when Claude needs to design UI layouts, create styling, structure components, implement modern aesthetics, or build visually appealing calculator interfaces with proper accessibility.
---

# UI Designing Skill for Scientific Calculator

## Overview

This skill provides guidance for creating super modern, aesthetic, and highly usable web UI for scientific calculator projects. The design emphasizes clarity, spacing, balance, and visual hierarchy with a minimalist but elegant look.

## Aesthetic Principles for Calculator UI

### Clean Layout and Spacing
- Use generous padding and margins (2-4px minimum spacing between elements)
- Implement proper white space to reduce visual clutter
- Maintain consistent spacing patterns throughout the interface
- Use Tailwind's spacing scale (0, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 56, 64) for consistency

### Visual Hierarchy
- Make the display area the most prominent element (largest font size, most contrast)
- Group related buttons visually using background colors or borders
- Use font weights (font-medium, font-semibold) to emphasize important elements
- Implement z-index layering for depth and interaction feedback

### Interactive Elements
- Provide subtle hover states with opacity changes or slight color shifts
- Implement active states that provide clear visual feedback
- Use smooth transitions (transition-all, duration-200) for interactions
- Ensure all interactive elements have sufficient touch targets (min 44px)

## UI Layout Specifics

### Display Section Design
```html
<div class="display-area bg-gray-900 text-right p-6 rounded-lg mb-4">
  <div class="expression text-gray-400 text-sm min-h-6 overflow-x-auto whitespace-nowrap"></div>
  <div class="result text-white text-3xl font-semibold overflow-x-auto whitespace-nowrap"></div>
</div>
```

- Use a dark background with light text for the display area
- Include separate areas for expression (input) and result
- Ensure text is right-aligned for mathematical operations
- Implement overflow handling for long expressions

### Button Grid Layout
- Organize buttons in a grid with logical grouping
- Use different background colors for different button types:
  - Numbers: Neutral background (gray-700 to gray-800)
  - Operators: Accent background (blue-600 to blue-700)
  - Functions: Secondary background (purple-600 to purple-700)
  - Special: Warning background (red-600 to red-700)

### Visual Grouping
- Group related functions together (trigonometric, logarithmic, etc.)
- Use consistent button sizing (typically 60x60px minimum)
- Implement clear visual separation between groups
- Use subtle borders or shadows to define sections

### Accessibility Guidelines
- Include proper aria-labels for all buttons
- Ensure sufficient color contrast (minimum 4.5:1 ratio)
- Implement keyboard navigation support
- Add focus states for keyboard users
- Use semantic HTML elements where appropriate

## Styling Guidance

### Button Design
- Use rounded-lg or rounded-xl for modern appearance
- Apply consistent padding (py-3 px-4) for uniform sizing
- Implement proper font sizing (text-lg) for readability
- Use Tailwind's shadow-sm for subtle depth
- Ensure buttons have hover effects (hover:bg-opacity-90)

### Color Palette
- Primary: blue-600, blue-700 for operators
- Secondary: purple-600, purple-700 for functions
- Success: green-600, green-700 for positive actions
- Warning: red-600, red-700 for clear/delete functions
- Neutral: gray-700, gray-800 for numbers
- Background: gray-900 for display, gray-800 for main area

### Typography
- Use sans-serif fonts (system-ui, -apple-system, etc.)
- Implement responsive font sizing for different screen sizes
- Use font-semibold for important display elements
- Maintain proper line height for readability

## Code Output Standards

### HTML Structure
- Create semantic, well-structured HTML
- Use proper div containers with Tailwind classes
- Implement proper nesting and indentation
- Include appropriate data attributes for JavaScript interaction

### Tailwind CSS Usage
- Use utility-first approach with consistent class patterns
- Implement responsive design with breakpoint prefixes
- Use color and spacing utilities consistently
- Apply animation and transition utilities for smooth interactions

### JavaScript Event Handling
- Implement clean, organized event listeners
- Use data attributes to identify button types
- Provide clear error handling and feedback
- Implement proper state management for calculator operations

### Accessibility Implementation
- Include aria-label attributes for screen readers
- Implement proper focus management
- Use semantic HTML elements where appropriate
- Ensure keyboard navigation works properly

## UI Behavior Rules

### Interaction Feedback
- Provide immediate visual feedback on button press
- Implement subtle animations for state changes
- Use color changes or shadows to indicate active states
- Ensure all interactions feel responsive and smooth

### Display Updates
- Update the display area in real-time as operations are performed
- Handle long expressions with proper overflow
- Implement error states with clear messaging
- Show expression history when applicable

### Error Handling
- Display clear error messages in the calculator display
- Use appropriate colors (red) for error states
- Provide guidance on how to resolve errors
- Reset calculator state appropriately after errors

## Implementation Checklist

- [ ] Clean, modern layout with proper spacing
- [ ] Visual hierarchy emphasizing the display area
- [ ] Consistent button styling and grouping
- [ ] Responsive design for different screen sizes
- [ ] Proper accessibility implementation
- [ ] Smooth interactive feedback
- [ ] Error handling and display
- [ ] Keyboard navigation support
- [ ] Semantic HTML structure
- [ ] Consistent color palette and typography

## Example Structure

```html
<div class="calculator-container max-w-md mx-auto p-6">
  <div class="calculator bg-gray-800 rounded-2xl p-6 shadow-xl">
    <!-- Display Area -->
    <div class="display-area bg-gray-900 text-right p-6 rounded-lg mb-4">
      <div class="expression text-gray-400 text-sm min-h-6 overflow-x-auto whitespace-nowrap"></div>
      <div class="result text-white text-3xl font-semibold overflow-x-auto whitespace-nowrap"></div>
    </div>

    <!-- Button Grid -->
    <div class="grid grid-cols-4 gap-3">
      <!-- Calculator buttons arranged in grid -->
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-lg py-3 px-4 font-medium transition-all duration-200">sin</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-lg py-3 px-4 font-medium transition-all duration-200">cos</button>
      <!-- More buttons... -->
    </div>
  </div>
</div>
```

This structure provides a foundation for creating beautiful, functional, and accessible scientific calculator UIs with modern aesthetics and excellent usability.