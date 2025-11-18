# Feature: Modify Cart Items in Sandwich Shop App

## Overview
Add functionality to allow users to modify items in their cart on the cart screen. Users should be able to change quantities and remove items.

## Current Architecture
- **Models**: Sandwich (type, size, bread type), Cart (add/remove/clear methods, total price calculation)
- **Repository**: Pricing (calculates prices based on quantity and size; price is independent of sandwich type or bread)

## Features to Implement

### 1. Change Item Quantity
**Description**: Users can increase or decrease the quantity of a sandwich already in their cart.

**User Actions**:
- Tap increment button (+) on a cart item → quantity increases by 1 → total price updates
- Tap decrement button (-) on a cart item → quantity decreases by 1 → if quantity reaches 0, remove the item from cart → total price updates

**Requirements**:
- Quantity cannot go below 0
- When quantity is 1, decrement should remove the item
- Price recalculation should be automatic using the Pricing repository
- UI should reflect changes immediately

### 2. Remove Item
**Description**: Users can completely remove a sandwich from their cart.

**User Actions**:
- Tap delete/remove button on a cart item → item is removed from cart → total price updates
- Item is no longer visible in the cart

**Requirements**:
- Should work instantly without confirmation (or add confirmation if preferred)
- Total price should update immediately
- Cart should reflect the removal

### 3. Visual Feedback
**Requirements**:
- Display current quantity for each item
- Show individual item price (based on quantity and size)
- Update total cart price in real-time
- Disable decrement when quantity is 1 (optional, or auto-remove)

## Implementation Notes
- Modify the Cart model to support updating item quantities
- Ensure the Pricing repository is used for all price calculations
- Update the cart screen UI to include increment/decrement controls and delete buttons