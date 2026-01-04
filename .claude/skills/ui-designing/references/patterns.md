# UI Design Patterns for Scientific Calculator

## Color Palettes

### Modern Dark Theme
```css
/* Backgrounds */
bg-calculator: #1f2937;        /* gray-800 */
bg-display: #111827;           /* gray-900 */
bg-button: #374151;            /* gray-700 */
bg-operator: #2563eb;          /* blue-600 */
bg-function: #7c3aed;          /* purple-600 */
bg-special: #dc2626;           /* red-600 */

/* Text */
text-display: #ffffff;         /* white */
text-expression: #9ca3af;      /* gray-400 */
text-button: #f9fafb;          /* gray-50 */
```

### Light Theme Alternative
```css
/* Backgrounds */
bg-calculator-light: #f9fafb;  /* gray-50 */
bg-display-light: #ffffff;     /* white */
bg-button-light: #e5e7eb;      /* gray-200 */
bg-operator-light: #dbeafe;    /* blue-100 */
bg-function-light: #ede9fe;    /* purple-100 */
bg-special-light: #fee2e2;     /* red-100 */

/* Text */
text-display-light: #1f2937;   /* gray-800 */
text-expression-light: #6b7280; /* gray-500 */
text-button-light: #374151;    /* gray-700 */
```

## Button Categories and Styling

### Number Buttons
```html
<button class="number-btn bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-6 text-xl font-medium transition-all duration-200 active:scale-95 shadow-sm">
  7
</button>
```

### Basic Operators
```html
<button class="operator-btn bg-blue-600 hover:bg-blue-700 text-white rounded-xl py-4 px-6 text-xl font-medium transition-all duration-200 active:scale-95 shadow-sm">
  +
</button>
```

### Scientific Functions
```html
<button class="function-btn bg-purple-600 hover:bg-purple-700 text-white rounded-lg py-3 px-4 text-base font-medium transition-all duration-200 active:scale-95 shadow-sm">
  sin
</button>
```

### Special Functions
```html
<button class="special-btn bg-red-600 hover:bg-red-700 text-white rounded-lg py-3 px-4 text-base font-medium transition-all duration-200 active:scale-95 shadow-sm">
  AC
</button>
```

## Responsive Layout Patterns

### Mobile Layout
```html
<div class="calculator-mobile w-full max-w-sm mx-auto p-4">
  <div class="display bg-gray-900 rounded-xl p-4 mb-4">
    <div class="expression text-gray-400 text-xs min-h-5 overflow-x-auto text-right"></div>
    <div class="result text-white text-2xl font-semibold overflow-x-auto text-right"></div>
  </div>
  <div class="grid grid-cols-4 gap-2">
    <!-- Buttons in 4x5 or 4x6 grid -->
  </div>
</div>
```

### Desktop Layout
```html
<div class="calculator-desktop w-full max-w-md mx-auto p-6">
  <div class="display bg-gray-900 rounded-2xl p-6 mb-6">
    <div class="expression text-gray-400 text-sm min-h-6 overflow-x-auto text-right"></div>
    <div class="result text-white text-3xl font-semibold overflow-x-auto text-right"></div>
  </div>
  <div class="grid grid-cols-5 gap-3">
    <!-- More complex layout with 5 columns for advanced functions -->
  </div>
</div>
```

## Animation and Interaction Patterns

### Button Press Animation
```css
.btn-press {
  transition: all 0.2s ease;
  transform: scale(0.95);
  box-shadow: inset 0 2px 4px rgba(0,0,0,0.3);
}
```

### Display Entry Animation
```css
.display-enter {
  animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
  from { transform: translateY(-10px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}
```

### Error State Animation
```css
.error-shake {
  animation: shake 0.5s ease-in-out;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}
```

## Accessibility Implementation

### Keyboard Navigation
```javascript
// Add keyboard support
document.addEventListener('keydown', (e) => {
  const key = e.key;
  if (/[0-9+\-*/.=]/.test(key)) {
    // Handle number and operator keys
    handleButtonClick(key);
  } else if (key === 'Escape' || key.toLowerCase() === 'c') {
    // Handle clear
    handleClear();
  } else if (key === 'Backspace') {
    // Handle backspace
    handleBackspace();
  }
});

// Focus management
buttons.forEach((btn, index) => {
  btn.setAttribute('tabindex', '0');
  btn.setAttribute('role', 'button');
  btn.setAttribute('aria-label', getAriaLabel(btn.textContent));
});
```

### ARIA Labels
```html
<button aria-label="number seven" class="number-btn">7</button>
<button aria-label="addition operator" class="operator-btn">+</button>
<button aria-label="sine function" class="function-btn">sin</button>
<button aria-label="all clear" class="special-btn">AC</button>
```

## Complete Component Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modern Scientific Calculator</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style type="text/tailwindcss">
    @layer utilities {
      .btn-press {
        @apply transition-all duration-200 active:scale-95 active:opacity-90;
      }
    }
  </style>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">
  <div class="calculator bg-gray-800 rounded-2xl p-6 shadow-2xl max-w-md w-full">
    <!-- Display Area -->
    <div class="display bg-gray-900 rounded-xl p-5 mb-5 text-right">
      <div class="expression text-gray-400 text-sm min-h-6 overflow-x-auto whitespace-nowrap" aria-live="polite" aria-atomic="true"></div>
      <div class="result text-white text-3xl font-semibold overflow-x-auto whitespace-nowrap" aria-live="polite" aria-atomic="true">0</div>
    </div>

    <!-- Button Grid -->
    <div class="grid grid-cols-4 gap-3">
      <!-- Row 1: Functions -->
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="sin" aria-label="sine function">sin</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="cos" aria-label="cosine function">cos</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="tan" aria-label="tangent function">tan</button>
      <button class="btn-special bg-red-600 hover:bg-red-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="special" data-value="AC" aria-label="all clear">AC</button>

      <!-- Row 2: More Functions -->
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="log" aria-label="logarithm function">log</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="ln" aria-label="natural logarithm function">ln</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="sqrt" aria-label="square root function">√</button>
      <button class="btn-special bg-red-600 hover:bg-red-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="special" data-value="C" aria-label="clear entry">C</button>

      <!-- Row 3: Parentheses and Power -->
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="(" aria-label="open parenthesis">(</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value=")" aria-label="close parenthesis">)</button>
      <button class="btn-function bg-purple-600 hover:bg-purple-700 text-white rounded-xl py-4 px-3 text-sm font-medium btn-press transition-all" data-type="function" data-value="^" aria-label="power function">x^y</button>
      <button class="btn-operator bg-blue-600 hover:bg-blue-700 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="operator" data-value="/" aria-label="division operator">÷</button>

      <!-- Row 4: Numbers -->
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="7" aria-label="number seven">7</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="8" aria-label="number eight">8</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="9" aria-label="number nine">9</button>
      <button class="btn-operator bg-blue-600 hover:bg-blue-700 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="operator" data-value="*" aria-label="multiplication operator">×</button>

      <!-- Row 5: Numbers -->
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="4" aria-label="number four">4</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="5" aria-label="number five">5</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="6" aria-label="number six">6</button>
      <button class="btn-operator bg-blue-600 hover:bg-blue-700 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="operator" data-value="-" aria-label="subtraction operator">−</button>

      <!-- Row 6: Numbers -->
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="1" aria-label="number one">1</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="2" aria-label="number two">2</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="3" aria-label="number three">3</button>
      <button class="btn-operator bg-blue-600 hover:bg-blue-700 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="operator" data-value="+" aria-label="addition operator">+</button>

      <!-- Row 7: Zero and Decimal -->
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all col-span-2" data-type="number" data-value="0" aria-label="number zero">0</button>
      <button class="btn-number bg-gray-700 hover:bg-gray-600 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="number" data-value="." aria-label="decimal point">.</button>
      <button class="btn-equals bg-green-600 hover:bg-green-700 text-white rounded-xl py-4 px-3 text-xl font-medium btn-press transition-all" data-type="equals" data-value="=" aria-label="equals">=</button>
    </div>
  </div>

  <script>
    // Calculator logic would go here
  </script>
</body>
</html>
```

This reference provides detailed patterns and examples for implementing modern, aesthetic UI designs for scientific calculators with proper accessibility and responsive behavior.