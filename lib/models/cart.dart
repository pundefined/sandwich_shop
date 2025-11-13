import '../repositories/pricing_repository.dart';

class Cart {
  final Map<bool, int> _items = {}; // Map of isFootlong -> quantity
  final PricingRepository _pricingRepository = PricingRepository();

  void addItem({required bool isFootlong, int quantity = 1}) {
    _items[isFootlong] = (_items[isFootlong] ?? 0) + quantity;
  }

  void removeItem({required bool isFootlong, int quantity = 1}) {
    if (!_items.containsKey(isFootlong)) return;

    _items[isFootlong] = _items[isFootlong]! - quantity;
    if (_items[isFootlong]! <= 0) {
      _items.remove(isFootlong);
    }
  }

  void clearCart() {
    _items.clear();
  }

  double get totalPrice {
    return _items.entries.fold(0.0, (sum, entry) {
      return sum +
          _pricingRepository.calculatePrice(
            quantity: entry.value,
            isFootlong: entry.key,
          );
    });
  }

  Map<bool, int> get items => Map.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.values.fold(0, (sum, qty) => sum + qty);
}
