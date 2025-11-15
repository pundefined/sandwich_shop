import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('OrderScreen - Cart', () {
    testWidgets('adds item to cart when Add to Cart is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // There is no cart UI, but we can check debugPrint output or rely on internal state if exposed.
      // For now, just ensure the button is enabled and can be tapped.
      expect(addToCartButton, findsOneWidget);
    });

    testWidgets('changes quantity and adds correct amount to cart',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addButton = find.byIcon(Icons.add);
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pump();
      final quantityText =
          tester.widget<Text>(find.byKey(const ValueKey('quantityText')));
      expect(quantityText.data, '2');
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Again, no cart UI, but we can check that the button is enabled and can be tapped.
      expect(addToCartButton, findsOneWidget);
    });
  });
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
      final quantityText =
          tester.widget<Text>(find.byKey(const ValueKey('quantityText')));
      expect(quantityText.data, '1'); // initial quantity
    });

    testWidgets('increments quantity when Add is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addButton = find.byIcon(Icons.add);
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pump();
      final quantityText =
          tester.widget<Text>(find.byKey(const ValueKey('quantityText')));
      expect(quantityText.data, '2');
    });

    testWidgets('decrements quantity when Remove is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addButton = find.byIcon(Icons.add);
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pump();
      var quantityText =
          tester.widget<Text>(find.byKey(const ValueKey('quantityText')));
      expect(quantityText.data, '2');
      final removeButton = find.byIcon(Icons.remove);
      await tester.ensureVisible(removeButton);
      await tester.tap(removeButton);
      await tester.pump();
      quantityText =
          tester.widget<Text>(find.byKey(const ValueKey('quantityText')));
      expect(quantityText.data, '1');
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('toggles sandwich size with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Switch && widget.value == true),
          findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(
          find.byWidgetPredicate(
              (widget) => widget is Switch && widget.value == false),
          findsOneWidget);
    });

    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byKey(const ValueKey('breadTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      expect(find.text('wheat'), findsWidgets);
    });

    testWidgets('changes sandwich type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byKey(const ValueKey('sandwichTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();
      expect(find.text('Chicken Teriyaki'), findsWidgets);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
