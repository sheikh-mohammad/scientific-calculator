# JavaScript Implementation Guide for Scientific Calculator UI

## Core Calculator State Management

```javascript
class ScientificCalculator {
  constructor() {
    this.display = '';
    this.expression = '';
    this.result = '0';
    this.lastOperation = null;
    this.waitingForOperand = false;
    this.memory = 0;
    this.angleMode = 'deg'; // 'deg' or 'rad'
    this.updateDisplay();
  }

  // Update the display with current values
  updateDisplay() {
    const expressionEl = document.querySelector('.expression');
    const resultEl = document.querySelector('.result');

    if (expressionEl) expressionEl.textContent = this.expression;
    if (resultEl) resultEl.textContent = this.result;
  }

  // Handle number input
  inputNumber(num) {
    if (this.waitingForOperand) {
      this.display = num;
      this.waitingForOperand = false;
    } else {
      this.display = this.display === '0' ? num : this.display + num;
    }
    this.result = this.display;
    this.updateDisplay();
  }

  // Handle decimal point
  inputDecimal() {
    if (this.waitingForOperand) {
      this.display = '0.';
      this.waitingForOperand = false;
    } else if (this.display.indexOf('.') === -1) {
      this.display += '.';
    }
    this.result = this.display;
    this.updateDisplay();
  }

  // Handle basic operations
  inputOperation(op) {
    const lastChar = this.expression.slice(-1);

    if (['+', '-', '*', '/'].includes(lastChar)) {
      this.expression = this.expression.slice(0, -1) + op;
    } else {
      this.expression += this.display + op;
    }

    this.lastOperation = op;
    this.waitingForOperand = true;
    this.updateDisplay();
  }

  // Calculate result
  calculate() {
    try {
      const expressionToEvaluate = this.expression + this.display;
      // Use Function constructor for safe evaluation (alternative to eval)
      const result = new Function('return ' + expressionToEvaluate)();
      this.display = this.formatResult(result);
      this.expression = '';
      this.result = this.display;
      this.waitingForOperand = true;
      this.updateDisplay();
    } catch (error) {
      this.displayError('Error');
    }
  }

  // Format result to avoid long decimals
  formatResult(value) {
    // Round to 10 decimal places to avoid floating point precision issues
    const rounded = Math.round(value * 10000000000) / 10000000000;
    return rounded.toString();
  }

  // Handle scientific functions
  handleFunction(func) {
    try {
      const currentValue = parseFloat(this.display);
      let result;

      switch(func) {
        case 'sin':
          result = Math.sin(this.angleMode === 'deg' ? currentValue * Math.PI / 180 : currentValue);
          break;
        case 'cos':
          result = Math.cos(this.angleMode === 'deg' ? currentValue * Math.PI / 180 : currentValue);
          break;
        case 'tan':
          result = Math.tan(this.angleMode === 'deg' ? currentValue * Math.PI / 180 : currentValue);
          break;
        case 'log':
          result = Math.log10(currentValue);
          break;
        case 'ln':
          result = Math.log(currentValue);
          break;
        case 'sqrt':
          result = Math.sqrt(currentValue);
          break;
        case 'pow2':
          result = Math.pow(currentValue, 2);
          break;
        case 'pow3':
          result = Math.pow(currentValue, 3);
          break;
        case 'pow10':
          result = Math.pow(10, currentValue);
          break;
        case 'reciprocal':
          result = 1 / currentValue;
          break;
        case 'factorial':
          result = this.factorial(Math.floor(currentValue));
          break;
        default:
          throw new Error('Unknown function');
      }

      this.display = this.formatResult(result);
      this.result = this.display;
      this.waitingForOperand = true;
      this.updateDisplay();
    } catch (error) {
      this.displayError('Error');
    }
  }

  // Calculate factorial
  factorial(n) {
    if (n < 0) return NaN;
    if (n === 0 || n === 1) return 1;
    let result = 1;
    for (let i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  // Clear entry
  clearEntry() {
    this.display = '0';
    this.result = '0';
    this.updateDisplay();
  }

  // All clear
  allClear() {
    this.display = '0';
    this.expression = '';
    this.result = '0';
    this.lastOperation = null;
    this.waitingForOperand = false;
    this.updateDisplay();
  }

  // Display error
  displayError(message) {
    this.display = message;
    this.result = message;
    this.expression = '';
    this.waitingForOperand = true;

    // Add error animation class
    const resultEl = document.querySelector('.result');
    if (resultEl) {
      resultEl.classList.add('error-shake');
      setTimeout(() => {
        resultEl.classList.remove('error-shake');
      }, 500);
    }

    this.updateDisplay();
  }

  // Toggle angle mode
  toggleAngleMode() {
    this.angleMode = this.angleMode === 'deg' ? 'rad' : 'deg';
    // Update UI to show current mode
    const modeIndicator = document.querySelector('.angle-mode');
    if (modeIndicator) {
      modeIndicator.textContent = this.angleMode.toUpperCase();
    }
  }
}
```

## Event Handling and UI Interactions

```javascript
// Initialize calculator
const calculator = new ScientificCalculator();

// Handle button clicks
function setupEventListeners() {
  const buttons = document.querySelectorAll('button');

  buttons.forEach(button => {
    button.addEventListener('click', (e) => {
      const type = e.currentTarget.dataset.type;
      const value = e.currentTarget.dataset.value;

      handleButtonClick(type, value);
    });
  });

  // Keyboard support
  document.addEventListener('keydown', (e) => {
    handleKeyboardInput(e);
  });
}

// Handle button click based on type
function handleButtonClick(type, value) {
  switch(type) {
    case 'number':
      if (value === '.') {
        calculator.inputDecimal();
      } else {
        calculator.inputNumber(value);
      }
      break;
    case 'operator':
      calculator.inputOperation(value);
      break;
    case 'function':
      calculator.handleFunction(value);
      break;
    case 'equals':
      calculator.calculate();
      break;
    case 'special':
      if (value === 'AC') {
        calculator.allClear();
      } else if (value === 'C') {
        calculator.clearEntry();
      }
      break;
  }
}

// Handle keyboard input
function handleKeyboardInput(event) {
  const key = event.key;

  // Numbers
  if (/[0-9]/.test(key)) {
    calculator.inputNumber(key);
  }
  // Operators
  else if (key === '+') {
    calculator.inputOperation('+');
  }
  else if (key === '-') {
    calculator.inputOperation('-');
  }
  else if (key === '*') {
    calculator.inputOperation('*');
  }
  else if (key === '/') {
    calculator.inputOperation('/');
  }
  // Decimal
  else if (key === '.') {
    calculator.inputDecimal();
  }
  // Equals/Enter
  else if (key === '=' || key === 'Enter') {
    calculator.calculate();
  }
  // Clear
  else if (key === 'Escape' || key.toLowerCase() === 'c') {
    calculator.allClear();
  }
  // Backspace
  else if (key === 'Backspace') {
    // Implement backspace functionality
    if (calculator.display.length > 1) {
      calculator.display = calculator.display.slice(0, -1);
    } else {
      calculator.display = '0';
    }
    calculator.result = calculator.display;
    calculator.updateDisplay();
  }
  // Scientific functions
  else if (key.toLowerCase() === 's') { // sin
    calculator.handleFunction('sin');
  }
  else if (key.toLowerCase() === 'c') { // cos
    calculator.handleFunction('cos');
  }
  else if (key.toLowerCase() === 't') { // tan
    calculator.handleFunction('tan');
  }
  else if (key.toLowerCase() === 'l') { // log
    calculator.handleFunction('log');
  }
  else if (key.toLowerCase() === 'q') { // sqrt
    calculator.handleFunction('sqrt');
  }
}

// Initialize the calculator when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  setupEventListeners();
});
```

## CSS Animations and Transitions

```css
/* Error shake animation */
@keyframes error-shake {
  0%, 100% { transform: translateX(0); }
  20%, 60% { transform: translateX(-5px); }
  40%, 80% { transform: translateX(5px); }
}

.error-shake {
  animation: error-shake 0.5s ease-in-out;
}

/* Button press animation */
.btn-press:active {
  transform: scale(0.95);
  opacity: 0.9;
}

/* Smooth transitions for display updates */
.display-transition {
  transition: all 0.2s ease;
}

/* Focus states for accessibility */
button:focus {
  outline: 2px solid #3b82f6; /* blue-500 */
  outline-offset: 2px;
}

/* Hover effects for better UX */
.btn-hover {
  transition: all 0.2s ease;
}

.btn-hover:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}
```

## Responsive Design Considerations

```javascript
// Handle window resize for responsive adjustments
function handleResize() {
  const calculator = document.querySelector('.calculator');
  const windowWidth = window.innerWidth;

  if (windowWidth < 640) { // Mobile
    // Adjust button sizes for mobile
    const buttons = document.querySelectorAll('button');
    buttons.forEach(btn => {
      btn.classList.remove('py-4', 'px-6', 'text-xl');
      btn.classList.add('py-3', 'px-4', 'text-lg');
    });
  } else { // Desktop
    // Adjust back to desktop sizes
    const buttons = document.querySelectorAll('button');
    buttons.forEach(btn => {
      btn.classList.remove('py-3', 'px-4', 'text-lg');
      btn.classList.add('py-4', 'px-6', 'text-xl');
    });
  }
}

// Listen for resize events
window.addEventListener('resize', handleResize);
// Initialize on load
handleResize();
```

## Error Handling and Validation

```javascript
// Enhanced error handling
function safeEvaluate(expression) {
  try {
    // Validate expression to prevent dangerous operations
    if (/[a-zA-Z]/.test(expression.replace(/(sin|cos|tan|log|ln|sqrt)/g, ''))) {
      throw new Error('Invalid characters in expression');
    }

    // Use Function constructor for safer evaluation
    const result = new Function('return ' + expression)();

    // Check for special cases
    if (!isFinite(result)) {
      throw new Error('Result is not finite');
    }

    return result;
  } catch (error) {
    throw new Error('Invalid expression');
  }
}

// Input validation
function validateInput(input) {
  // Check for valid characters
  const validChars = /^[0-9+\-*/.()=]+$/;
  if (!validChars.test(input)) {
    return false;
  }

  // Check for balanced parentheses
  let parenCount = 0;
  for (let char of input) {
    if (char === '(') parenCount++;
    if (char === ')') parenCount--;
    if (parenCount < 0) return false; // Closing paren without opening
  }

  return parenCount === 0; // Must have balanced parentheses
}
```

This JavaScript implementation guide provides a complete foundation for creating interactive, functional scientific calculator UIs with proper error handling, keyboard support, and accessibility features.