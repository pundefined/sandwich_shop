# Feature: App Drawer — Main Navigation

## Overview
Add a simple, user-friendly navigation Drawer to the app so people can quickly move between the main areas: Order, Cart, and Sign In. The Drawer should be easy to open, clearly labeled, and provide immediate feedback when an item is tapped.

## What the Drawer shows
- Order — takes the user back to the main ordering screen (where sandwiches are browsed/created).
- Cart — opens the cart screen so the user can review or change their order.
- Sign In — opens the sign in screen (or account/profile area if already signed in).

Each item should have an icon and a short label.

## User actions and expected behavior

- Open Drawer
	- Action: user taps the menu icon (or swipes from the left edge, depending on platform conventions).
	- Result: the Drawer slides in and focuses on the first item. Drawer should be dismissible by tapping outside or swiping it closed.

- Tap Order
	- Action: user taps the "Order" row in the Drawer.
	- Result: the Drawer closes and the app navigates to the ordering screen (main app view). If already on that screen, the Drawer just closes.

- Tap Cart
	- Action: user taps the "Cart" row.
	- Result: the Drawer closes and the app opens the cart screen. If the cart is empty, the user still lands on the cart screen which shows the empty state.

- Tap Sign In
	- Action: user taps the "Sign In" row.
	- Result: the Drawer closes and the app navigates to the sign in screen. If the user is already signed in, this can instead go to a small account/profile screen or show the user's name and a "Sign Out" action.

## Visual / UX details
- Show an icon and label for each item.
- Highlight the currently active screen in the Drawer (subtle background or bold label).
- Show a small numeric badge on the Cart item with the number of items.
- Close the Drawer immediately after an item is selected so navigation feels snappy.

## Accessibility
- All Drawer items should have clear accessibility/semantic labels.
- Ensure touch targets are comfortably large (44–48 px recommended).
- Provide keyboard focus and activation behavior for desktop/web targets.

## Acceptance criteria (what success looks like)
- The Drawer is reachable from the app's main screens and opens reliably.
- Tapping Order, Cart, or Sign In closes the Drawer and navigates to the correct screen.
- Cart shows a badge with the current item count (if > 0).
- The active screen is visually indicated in the Drawer.
- Navigation is immediate (no long delays) and UI updates are visible to the user.
