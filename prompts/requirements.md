# Requirements Document: Cart Item Modification Feature

## 1. Feature Description

### Purpose
Enable users to dynamically modify items in their shopping cart by adjusting quantities and removing items. This feature improves the user experience by allowing flexible cart management before checkout.

### Scope
- Quantity adjustment (increment/decrement) for cart items
- Item removal from cart
- Real-time price recalculation
- Visual feedback for all modifications

### Out of Scope
- Cart persistence across app sessions
- Undo/redo functionality
- Batch operations (modify multiple items at once)

---

## 2. User Stories

### User Story 1: Adjust Item Quantity
**As a** customer ordering sandwiches  
**I want to** increase or decrease the quantity of a sandwich in my cart  
**So that** I can order the correct number of items without having to remove and re-add items

**Acceptance Criteria**:
- I can tap a "+" button to increase quantity by 1
- I can tap a "-" button to decrease quantity by 1
- The new quantity displays immediately
- The total cart price updates automatically
- When quantity reaches 0, the item is automatically removed

### User Story 2: Remove Item from Cart
**As a** customer  
**I want to** remove a sandwich from my cart entirely  
**So that** I can change my mind about an item without having to clear the entire cart

**Acceptance Criteria**:
- I can tap a delete/remove button on each cart item
- The item is removed from the cart immediately
- The total cart price updates to reflect the removal
- The cart screen updates to no longer show the removed item

### User Story 3: Real-Time Price Updates
**As a** customer  
**I want to** see the total price update instantly when I modify quantities or remove items  
**So that** I always know the current cost of my order

**Acceptance Criteria**:
- Price updates are immediate when quantity changes
- Price updates are immediate when items are removed
- Individual item prices reflect quantity × size-based unit price
- Total cart price is always accurate

---

## 3. Acceptance Criteria

### Functional Requirements

#### FR-1: Quantity Increment
- [ ] Increment button exists on each cart item
- [ ] Tapping increment increases quantity by exactly 1
- [ ] Quantity change is reflected in UI within 100ms
- [ ] Price recalculation uses Pricing repository
- [ ] Increment works for all sandwich sizes

#### FR-2: Quantity Decrement
- [ ] Decrement button exists on each cart item
- [ ] Tapping decrement decreases quantity by exactly 1
- [ ] When quantity reaches 0, the item is removed from cart
- [ ] Decrement does not allow negative quantities
- [ ] Quantity change is reflected in UI within 100ms

#### FR-3: Item Removal
- [ ] Delete button exists on each cart item
- [ ] Tapping delete removes the item immediately
- [ ] Removed item no longer appears in cart list
- [ ] Delete works for all sandwich types and sizes

#### FR-4: Price Calculations
- [ ] Individual item price = unit price × quantity (based on size)
- [ ] Price calculation ignores sandwich type and bread type
- [ ] Total cart price = sum of all item prices
- [ ] Pricing repository is used for all calculations
- [ ] Prices update within 100ms of modification

#### FR-5: Cart State Management
- [ ] Cart reflects all modifications accurately
- [ ] Multiple quantity changes work correctly in sequence
- [ ] Multiple item removals work correctly in sequence
- [ ] Clear cart button still functions as expected

### UI/UX Requirements

#### UX-1: Visual Feedback
- [ ] Increment/decrement buttons are clearly visible
- [ ] Delete button is clearly visible
- [ ] Current quantity is displayed for each item
- [ ] Buttons are appropriately sized for touch (minimum 44x44dp)

#### UX-2: Real-Time Updates
- [ ] Total price updates without page refresh
- [ ] Individual item prices update without page refresh
- [ ] UI remains responsive during modifications

#### UX-3: User Clarity
- [ ] Cart total is prominently displayed
- [ ] Item details (type, size, bread, price) are visible
- [ ] Quantity is clearly displayed next to each item

### Non-Functional Requirements

#### PERF-1: Performance
- [ ] Quantity changes complete in < 100ms
- [ ] Item removals complete in < 100ms
- [ ] Price recalculation completes in < 50ms

#### PERF-2: Reliability
- [ ] No data loss during modifications
- [ ] Cart state remains consistent after multiple operations
- [ ] No UI crashes or freezes during rapid modifications

### Edge Cases & Constraints

#### EC-1: Boundary Conditions
- [ ] Cannot have negative quantities
- [ ] Cannot have quantity of 0 (item is removed)
- [ ] Can add items until device memory/cart limit
- [ ] Works with carts containing 1+ items

#### EC-2: Cart States
- [ ] Modifications work when cart has 1 item
- [ ] Modifications work when cart has multiple items of same type
- [ ] Modifications work when cart has multiple different sandwich types
- [ ] Removing last item leaves empty cart in valid state

---

## 4. Implementation Subtasks

### Task 1: Data Model Updates
- [ ] Extend Cart model to support quantity updates
- [ ] Add update quantity method to Cart
- [ ] Ensure Cart maintains consistent state during modifications

### Task 2: UI Components
- [ ] Create increment button component
- [ ] Create decrement button component
- [ ] Create delete button component
- [ ] Add quantity display to cart items

### Task 3: Business Logic
- [ ] Implement quantity increment logic
- [ ] Implement quantity decrement logic with auto-remove at 0
- [ ] Implement item removal logic
- [ ] Integrate Pricing repository for price calculations

### Task 4: Integration
- [ ] Connect UI buttons to business logic
- [ ] Ensure Cart screen displays modifications in real-time
- [ ] Test integration with existing Cart functionality

### Task 5: Testing
- [ ] Write unit tests for Cart model modifications
- [ ] Write unit tests for Pricing calculations
- [ ] Write widget tests for UI components
- [ ] Perform manual testing on multiple device sizes

---

# Requirements Document: Sign-in Screen (Detailed)

## 1. Feature Description & Purpose

### Purpose
Provide a polished, accessible Sign-in screen that allows users to authenticate with a username and password. This feature is UI-only (no server authentication integration required for initial implementation) and focuses on clear validation, secure input handling, and a smooth user experience that prevents duplicate submissions and surfaces clear errors.

### Scope
- Username and password input fields
- Password visibility toggle (show/hide)
- Primary action: `Sign in` (enabled only when form is valid)
- Secondary actions: `Forgot password` and `Create account` (navigation placeholders)
- Client-side validation and loading state
- Accessible labels and error announcements

### Out of Scope
- Backend authentication, session persistence, and deep navigation flows
- Remember-me or password storage
- Social sign-in (Google/Apple)

## 2. User Stories

### User Story 1: Returning User
**As a** returning customer
**I want to** sign in using my username and password
**So that** I can continue with my saved preferences and complete my order faster

Acceptance criteria:
- I can enter my username and password
- The `Sign in` button becomes enabled only when inputs are valid
- On tapping `Sign in`, the UI shows a loading state and disables inputs
- On simulated success, the screen triggers the app's success handler

### User Story 2: New User Exploring Options
**As a** new user
**I want to** see a clear `Create account` option and guidance
**So that** I can create an account if I don't already have one

Acceptance criteria:
- A visible `Create account` link is present
- Tapping it calls the placeholder navigation handler for account creation

### User Story 3: User Who Forgot Password
**As a** user who forgot my password
**I want to** see a `Forgot password` link
**So that** I can recover my account via the next steps (out-of-scope)

Acceptance criteria:
- A visible `Forgot password` link is present and triggers a placeholder action

## 3. Acceptance Criteria

### Functional Requirements

- FR-1: Inputs
	- [ ] `Username` input is present and accepts text
	- [ ] `Password` input is present and masks input by default
	- [ ] Password visibility toggle reveals/hides the password

- FR-2: Validation
	- [ ] `Username` must be non-empty
	- [ ] `Password` must be non-empty and at least 6 characters (configurable)
	- [ ] Validation runs on submit and optionally on blur
	- [ ] Inline validation messages are shown for invalid fields

- FR-3: Submit Behavior
	- [ ] `Sign in` button disabled when form invalid
	- [ ] Tapping `Sign in` with valid data shows a loading indicator and disables inputs
	- [ ] Duplicate submissions are prevented while loading
	- [ ] On simulated success, the screen invokes a success callback
	- [ ] On simulated failure, a clear error message is shown and inputs re-enabled

- FR-4: Secondary Actions
	- [ ] `Forgot password` link present and triggers a handler
	- [ ] `Create account` link present and triggers a handler

### UX / Visual Requirements

- UX-1: Button / Control Visibility
	- [ ] Primary action (`Sign in`) is visually prominent
	- [ ] Toggle and secondary links are clearly visible but visually secondary

- UX-2: Responsiveness
	- [ ] Controls are touch-friendly (≥ 44x44dp equivalent)
	- [ ] Layout adapts to narrow and wide screens

### Accessibility Requirements

- A11Y-1: Labels & Hints
	- [ ] Every input has an accessible label
	- [ ] Password toggle is accessible and has a descriptive label

## 4. Subtasks (Implementation & Testing)

- Implementation
	- [ ] Add `SignInForm` widget with `username`, `password`, and `showPassword` state
	- [ ] Implement password visibility toggle control
	- [ ] Implement client-side validation and form state management
	- [ ] Implement loading state and submit debounce / disable
	- [ ] Add `Forgot password` and `Create account` callback hooks

- Testing
	- [ ] Unit tests for validation rules (username empty, password length)
	- [ ] Widget tests for visual states (idle, validation errors, loading, error)

## 5. Done Definition

The Sign-in screen is considered done when:
- All functional acceptance criteria pass in unit/widget tests
- The `prompts/requirements.md` includes this documented spec and implementation subtasks