import '../models/sandwich.dart';
import '../repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {}; // Map of Sandwich -> quantity
  final PricingRepository _pricingRepository = PricingRepository();

  void addItem({required Sandwich sandwich, int quantity = 1}) {
    _items[sandwich] = (_items[sandwich] ?? 0) + quantity;
  }

  void removeItem({required Sandwich sandwich, int quantity = 1}) {
    if (!_items.containsKey(sandwich)) return;

    _items[sandwich] = _items[sandwich]! - quantity;
    if (_items[sandwich]! <= 0) {
      _items.remove(sandwich);
    }
  }

  void clearCart() {
    _items.clear();
  }

  double get totalPrice {
    double total = 0.0;
    for (final entry in _items.entries) {
      total += _pricingRepository.calculatePrice(
        quantity: entry.value,
        isFootlong: entry.key.isFootlong,
      );
    }
    return total;
  }

  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.values.fold(0, (sum, qty) => sum + qty);
}
