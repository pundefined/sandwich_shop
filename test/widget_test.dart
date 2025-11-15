import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  group('OrderScreen - Cart', () {
    testWidgets('displays cart summary and correct total for single item',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Check for cart summary text
      expect(find.text('Cart Summary:'), findsOneWidget);
      expect(find.textContaining('1 x footlong Veggie Delight on white bread'),
          findsOneWidget);
      // Calculate expected total
      final cart = Cart();
      cart.addItem(
          sandwich: Sandwich(
              type: SandwichType.veggieDelight,
              isFootlong: true,
              breadType: BreadType.white),
          quantity: 1);
      final expectedTotal = cart.totalPrice.toStringAsFixed(2);
      expect(find.text('Total: £$expectedTotal'), findsOneWidget);
    });

    testWidgets('stacks identical sandwiches and shows correct total',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addButton = find.byIcon(Icons.add);
      await tester.ensureVisible(addButton);
      await tester.tap(addButton); // quantity = 2
      await tester.pump();
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Should show 2 x footlong Veggie Delight on white bread
      expect(find.textContaining('2 x footlong Veggie Delight on white bread'),
          findsOneWidget);
      // Calculate expected total
      final cart = Cart();
      cart.addItem(
          sandwich: Sandwich(
              type: SandwichType.veggieDelight,
              isFootlong: true,
              breadType: BreadType.white),
          quantity: 2);
      final expectedTotal = cart.totalPrice.toStringAsFixed(2);
      expect(find.text('Total: £$expectedTotal'), findsOneWidget);
    });

    testWidgets(
        'shows multiple lines for different sandwiches and correct total',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Add first sandwich
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Change sandwich type
      await tester.tap(find.byKey(const ValueKey('sandwichTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();
      // Add second sandwich
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Should show both sandwiches in summary
      expect(find.textContaining('1 x footlong Veggie Delight on white bread'),
          findsOneWidget);
      expect(
          find.textContaining('1 x footlong Chicken Teriyaki on white bread'),
          findsOneWidget);
      // Calculate expected total
      final cart = Cart();
      cart.addItem(
          sandwich: Sandwich(
              type: SandwichType.veggieDelight,
              isFootlong: true,
              breadType: BreadType.white),
          quantity: 1);
      cart.addItem(
          sandwich: Sandwich(
              type: SandwichType.chickenTeriyaki,
              isFootlong: true,
              breadType: BreadType.white),
          quantity: 1);
      final expectedTotal = cart.totalPrice.toStringAsFixed(2);
      expect(find.text('Total: £$expectedTotal'), findsOneWidget);
    });
    testWidgets('shows correct message for six-inch Chicken Teriyaki on wheat',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Change sandwich type
      await tester.tap(find.byKey(const ValueKey('sandwichTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();
      // Change bread type
      await tester.tap(find.byKey(const ValueKey('breadTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      // Toggle size to six-inch
      await tester.tap(find.byType(Switch));
      await tester.pump();
      // Add to cart
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Check SnackBar message for six-inch
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining(
            'Added 1 six-inch Chicken Teriyaki sandwich(es) on wheat bread to cart'),
        findsOneWidget,
      );
    });
    testWidgets('shows correct message for Chicken Teriyaki on wheat',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Change sandwich type
      await tester.tap(find.byKey(const ValueKey('sandwichTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();
      // Change bread type
      await tester.tap(find.byKey(const ValueKey('breadTypeDropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      // Add to cart
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Check SnackBar message
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining(
            'Added 1 footlong Chicken Teriyaki sandwich(es) on wheat bread to cart'),
        findsOneWidget,
      );
    });
    testWidgets('adds item to cart when Add to Cart is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      // Check for SnackBar message
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining(
            'Added 1 footlong Veggie Delight sandwich(es) on white bread to cart'),
        findsOneWidget,
      );
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
      // Check for SnackBar message with correct quantity, sandwich, and bread type
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining(
            'Added 2 footlong Veggie Delight sandwich(es) on white bread to cart'),
        findsOneWidget,
      );
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
