import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CheckoutScreen', () {
    testWidgets('displays order summary and total',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 1);

      final CheckoutScreen screen = CheckoutScreen(cart: cart);
      final MaterialApp app = MaterialApp(home: screen);

      await tester.pumpWidget(app);

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('1x ${sandwich.name}'), findsOneWidget);
      // per-item price should be present and the Total label should be shown
      expect(find.text('£11.00'), findsExactly(2));
      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('confirm payment shows processing and returns confirmation',
        (WidgetTester tester) async {
      final Cart cart = Cart();
      final Sandwich sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      cart.add(sandwich, quantity: 2);

      Map? confirmation;

      final MaterialApp app = MaterialApp(
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<Map>(
                    context,
                    MaterialPageRoute<Map>(
                      builder: (_) => CheckoutScreen(cart: cart),
                    ),
                  );
                  confirmation = result;
                },
                child: const Text('Go to Checkout'),
              ),
            ),
          );
        }),
      );

      await tester.pumpWidget(app);

      // Navigate to checkout
      await tester.tap(find.text('Go to Checkout'));
      await tester.pumpAndSettle();

      // Confirm button should be present
      expect(find.text('Confirm Payment'), findsOneWidget);

      // Tap confirm payment; this triggers a 2-second simulated processing delay
      await tester.tap(find.text('Confirm Payment'));

      // Let the UI update (processing indicator appears)
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Advance the clock by 2 seconds to finish processing
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // After processing, the route should pop and a confirmation map should be returned
      expect(confirmation, isNotNull);
      expect(confirmation, isA<Map>());
      expect(confirmation!['orderId'], startsWith('ORD'));
      expect(confirmation!['totalAmount'], equals(cart.totalPrice));
      expect(confirmation!['itemCount'], equals(cart.countOfItems));
    });
  });
}
