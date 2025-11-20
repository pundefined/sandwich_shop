import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';

void main() {
  group('SignInScreen widget tests', () {
    testWidgets('renders fields and disabled sign in button initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

      // Fields
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      // Sign in button should be disabled initially (no credentials)
      final Finder signInButton =
          find.widgetWithText(ElevatedButton, 'Sign in');
      expect(signInButton, findsOneWidget);

      final ElevatedButton elevated =
          tester.widget<ElevatedButton>(signInButton);
      expect(elevated.onPressed, isNull);
    });

    testWidgets(
        'shows validation error for short password and keeps button disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

      // Enter username and a short password
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Username'), 'user1');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), '123');

      // Trigger onChanged validators
      await tester.pumpAndSettle();

      expect(
          find.text('Password must be at least 6 characters'), findsOneWidget);

      final Finder signInButton =
          find.widgetWithText(ElevatedButton, 'Sign in');
      final ElevatedButton elevated =
          tester.widget<ElevatedButton>(signInButton);
      expect(elevated.onPressed, isNull);
    });

    testWidgets(
        'enables button for valid credentials and shows loading then success',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

      // Fill valid credentials
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Username'), 'validuser');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'longenough');

      // Let validators run
      await tester.pumpAndSettle();

      // Now button should be enabled
      final Finder signInButtonFinder = find.byType(ElevatedButton);
      expect(signInButtonFinder, findsWidgets);

      // There may be multiple ElevatedButtons (styled); find the one with 'Sign in' text
      final Finder signInButton =
          find.widgetWithText(ElevatedButton, 'Sign in');
      expect(signInButton, findsOneWidget);

      final ElevatedButton elevated =
          tester.widget<ElevatedButton>(signInButton);
      expect(elevated.onPressed, isNotNull);

      // Tap to submit
      await tester.tap(signInButton);
      await tester.pump(); // start async work

      // Expect loading indicator and 'Signing in...'
      expect(find.text('Signing in...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Advance time to let the simulated 2s delay complete
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // SnackBar with success message shown
      expect(find.textContaining('Signed in as:'), findsOneWidget);
    });
  });
}
