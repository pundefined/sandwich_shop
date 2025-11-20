import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/order_screen.dart';

void main() {
  group('App Drawer navigation', () {
    testWidgets('Drawer shows Order, Cart and Sign In entries',
        (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(800, 600), textScaleFactor: 1.0),
        child: const MaterialApp(home: OrderScreen()),
      ));

      // Open the drawer by tapping the menu icon
      final Finder menuButton = find.byTooltip('Open navigation menu');
      expect(menuButton, findsOneWidget);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      expect(find.text('Order'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('Tapping Cart closes drawer and navigates to Cart View',
        (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(800, 600), textScaleFactor: 1.0),
        child: const MaterialApp(home: OrderScreen()),
      ));

      // Open drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap Cart
      await tester.tap(find.text('Cart'));
      await tester.pumpAndSettle();

      // CartScreen has AppBar title 'Cart View'
      expect(find.text('Cart View'), findsOneWidget);
    });

    testWidgets('Tapping Sign In closes drawer and navigates to Sign in',
        (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(800, 600), textScaleFactor: 1.0),
        child: const MaterialApp(home: OrderScreen()),
      ));

      // Open drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap Sign In
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // SignInScreen has AppBar title 'Sign in'
      // The Sign in text may appear more than once (AppBar + other labels).
      expect(find.text('Sign in'), findsWidgets);
    });

    testWidgets('Tapping Order closes drawer and stays on Order screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(800, 600), textScaleFactor: 1.0),
        child: const MaterialApp(home: OrderScreen()),
      ));

      // Ensure we're on Order screen
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Open drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap Order
      await tester.tap(find.text('Order'));
      await tester.pumpAndSettle();

      // Still on Order screen
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });
  });
}
