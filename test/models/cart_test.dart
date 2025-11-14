import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late Sandwich veggieSixInch;
    late Sandwich veggieFootlong;
    late Sandwich chickenSixInch;

    setUp(() {
      cart = Cart();
      veggieSixInch = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      veggieFootlong = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      chickenSixInch = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );
    });

    test('isEmpty returns true for new cart', () {
      expect(cart.isEmpty, isTrue);
    });

    test('addItem increases item count', () {
      cart.addItem(sandwich: veggieSixInch);
      expect(cart.itemCount, equals(1));
    });

    test('addItem with quantity adds multiple items', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 3);
      expect(cart.itemCount, equals(3));
    });

    test('addItem stacks quantities for same sandwich', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 2);
      cart.addItem(sandwich: veggieSixInch, quantity: 3);
      expect(cart.items[veggieSixInch], equals(5));
    });

    test('removeItem decreases quantity', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 3);
      cart.removeItem(sandwich: veggieSixInch);
      expect(cart.itemCount, equals(2));
    });

    test('removeItem removes sandwich when quantity reaches zero', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 1);
      cart.removeItem(sandwich: veggieSixInch);
      expect(cart.items.containsKey(veggieSixInch), isFalse);
    });

    test('removeItem does nothing for non-existent sandwich', () {
      cart.removeItem(sandwich: veggieSixInch);
      expect(cart.isEmpty, isTrue);
    });

    test('clearCart empties the cart', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 2);
      cart.addItem(sandwich: chickenSixInch, quantity: 1);
      cart.clearCart();
      expect(cart.isEmpty, isTrue);
      expect(cart.itemCount, equals(0));
    });

    test('items returns unmodifiable map', () {
      cart.addItem(sandwich: veggieSixInch);
      final items = cart.items;
      expect(() => items[chickenSixInch] = 5, throwsUnsupportedError);
    });

    test('itemCount calculates total quantity correctly', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 2);
      cart.addItem(sandwich: chickenSixInch, quantity: 3);
      expect(cart.itemCount, equals(5));
    });

    test('different sandwiches are tracked separately', () {
      cart.addItem(sandwich: veggieSixInch, quantity: 2);
      cart.addItem(sandwich: veggieFootlong, quantity: 1);
      expect(cart.items.length, equals(2));
    });
  });
}
