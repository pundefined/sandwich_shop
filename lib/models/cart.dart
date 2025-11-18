import 'sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {};

  // Returns a read-only copy of the items and their quantities
  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  void add(Sandwich sandwich, {int quantity = 1}) {
    if (_items.containsKey(sandwich)) {
      _items[sandwich] = _items[sandwich]! + quantity;
    } else {
      _items[sandwich] = quantity;
    }
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    if (_items.containsKey(sandwich)) {
      final currentQty = _items[sandwich]!;
      if (currentQty > quantity) {
        _items[sandwich] = currentQty - quantity;
      } else {
        _items.remove(sandwich);
      }
    }
  }

  /// Set the exact quantity for [sandwich].
  /// If [quantity] <= 0 the sandwich is removed from the cart.
  void updateQuantity(Sandwich sandwich, int quantity) {
    if (quantity <= 0) {
      _items.remove(sandwich);
      return;
    }

    _items[sandwich] = quantity;
  }

  /// Convenience method to increment quantity by [by] (default 1).
  /// Throws [ArgumentError] if [by] is negative.
  void increment(Sandwich sandwich, {int by = 1}) {
    if (by < 0) {
      throw ArgumentError.value(by, 'by', 'Increment must be non-negative');
    }
    add(sandwich, quantity: by);
  }

  /// Convenience method to decrement quantity by [by] (default 1).
  /// If resulting quantity <= 0 the item is removed.
  /// Throws [ArgumentError] if [by] is negative.
  void decrement(Sandwich sandwich, {int by = 1}) {
    if (by < 0) {
      throw ArgumentError.value(by, 'by', 'Decrement must be non-negative');
    }
    remove(sandwich, quantity: by);
  }

  void clear() {
    _items.clear();
  }

  double get totalPrice {
    final pricingRepository = PricingRepository();
    double total = 0.0;

    for (Sandwich sandwich in _items.keys) {
      int quantity = _items[sandwich]!;
      total += pricingRepository.calculatePrice(
        quantity: quantity,
        isFootlong: sandwich.isFootlong,
      );
    }

    return total;
  }

  bool get isEmpty => _items.isEmpty;

  int get length => _items.length;

  int get countOfItems {
    int total = 0;
    for (Sandwich sandwich in _items.keys) {
      total += _items[sandwich]!;
    }
    return total;
  }

  int getQuantity(Sandwich sandwich) {
    if (_items.containsKey(sandwich)) {
      return _items[sandwich]!;
    }
    return 0;
  }

  /// Returns the total price for [sandwich] in the cart (unit price * quantity)
  /// Uses [PricingRepository] as the single source of pricing rules.
  double itemTotalPrice(Sandwich sandwich) {
    final pricingRepository = PricingRepository();
    final qty = getQuantity(sandwich);
    if (qty == 0) return 0.0;
    return pricingRepository.calculatePrice(
      quantity: qty,
      isFootlong: sandwich.isFootlong,
    );
  }

  /// Returns the unit price for [sandwich] (price for quantity == 1).
  double unitPrice(Sandwich sandwich) {
    final pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: 1,
      isFootlong: sandwich.isFootlong,
    );
  }
}
