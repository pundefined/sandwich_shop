# Sign-in Screen — Feature & UX Prompt

This document describes the frontend-only Sign-in screen for the Sandwich Shop app. It specifies the UI elements, behaviors, user flows, validation rules, and acceptance criteria for implementing the screen in Flutter.

## Purpose

Provide a clean, accessible sign-in screen where users can enter a username and password and attempt to log in. Authentication and persistence are out of scope for now: the UI should call a placeholder callback (e.g. `onLogin(username, password)`) which the app will later implement to perform real authentication.

## Where to place

- File: `lib/views/login_screen.dart` (recommended)
- Strings moved into localization later (for now, keep inline strings but mark them for extraction)

## Visual layout

- AppBar with title: "Sign in".
- Vertical column with the following, centered horizontally with comfortable side padding:
  - App logo or illustration (optional, small, above fields)
  - TextField: Username
    - Label: "Username"
    - Hint: "Enter your username"
    - Leading icon: person/user
    - Keyboard type: text
    - Text input action: next (moves focus to password)
  - TextField: Password
    - Label: "Password"
    - Hint: "Enter your password"
    - Leading icon: lock
    - Trailing icon: toggle show/hide password
    - Obscure text by default
    - Text input action: done (submits form)
  - Small link: "Forgot password?" (tappable, placeholder action)
  - Primary button: "Sign in"
    - Full-width
    - Elevated / prominent
    - Disabled when form invalid or loading
  - Secondary action: "Create account" (text button) — navigates to sign-up screen in future
  - Area for error message (inline) under the button. Use red text and accessible semantics.

- Use consistent spacing (8-16 px increments). On small screens ensure content scrolls (wrap in SingleChildScrollView).

## States

1. Idle: fields editable, button enabled only if validation passes.
2. Invalid: show inline validation messages below the respective field(s) (e.g., "Username is required").
3. Loading: after tapping "Sign in", show a progress indicator inside the button or replace button with a circular indicator, disable fields and buttons.
4. Error: show an inline error banner/text with the failure reason (e.g., "Invalid credentials"). Allow retry.
5. Success: call `onLoginSuccess()` callback or navigate to main screen (placeholder). For now, emit a success callback to be handled by app logic.

## Form validation rules (client-side)

- Username: required, not blank, minimum 3 characters (recommendation).
- Password: required, not blank, minimum 6 characters (recommendation).
- Validation should occur on form submit and after field blur (or as user types for better UX). Keep messages concise.

## Interaction flow

1. User opens Sign-in screen.
2. User taps Username field and enters username.
3. User taps Next on keyboard — focus moves to Password.
4. User enters password. Optionally toggles "show password" to verify entry.
5. When both fields are valid, the "Sign in" button becomes enabled.
6. User taps "Sign in":
   - UI validates fields again.
   - If invalid, show validation errors and stop.
   - If valid, call `onLogin(username, password)` (a synchronous / asynchronous placeholder). Enter Loading state.
7. While loading, inputs and buttons are disabled and a spinner is shown.
8. Placeholder callback resolves with either success or failure:
   - On success: call `onLoginSuccess()` or navigate to the app's main screen (for now, the callback should be used so app decides navigation).
   - On failure: exit loading, show error message with `retry` option.

Note: Since we aren't implementing authentication, make the callback injectable (constructor parameter) so tests can simulate success/failure.

## Accessibility

- Provide `labelText` for text fields.
- Ensure `semanticsLabel` for the show/hide password toggle.
- Error message should be announced by screen readers (use `Semantics` or `LiveRegion` equivalent).
- Buttons must be reachable by keyboard and have sufficient contrast.
- Provide proper tap targets (min 44x44 logical pixels).

## Keyboard and platform behaviors

- On mobile, use the keyboard's "done" or "go" action to submit when on password.
- Dismiss keyboard on submit if appropriate.

## Visual/Style guidance

- Reuse app theme and `app_styles.dart` for colors, spacing, and text styles.
- Use existing button styles for consistency.

## Failure and edge cases

- Empty fields
- Very long input strings (truncate display where appropriate)

## Acceptance criteria

- The `LoginScreen` UI is implemented and reachable in the app (or show how to navigate to it).
- Username and Password fields have validation with clear messages.
- Sign in button triggers the injected `onLogin` callback and shows a loading state.
- On simulated successful callback, `onLoginSuccess()` is invoked or documented behavior occurs.
- On simulated failure, an inline error is shown and UI allows retry.
- Basic accessibility labels and focus order are implemented.

## Testing notes

- Add widget tests to assert:
  - Button is disabled when fields invalid
  - Button enabled when fields valid
  - Loading state disables inputs
  - Success callback is called on mock successful login
  - Error message shown on mock failure