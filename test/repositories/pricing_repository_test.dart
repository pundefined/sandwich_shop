import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('calculates single footlong price as 11', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('footlong', 1);
      expect(repo.price, 11);
    });

    test('calculates single six-inch price as 7', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('six-inch', 1);
      expect(repo.price, 7);
    });

    test('calculates multiple footlong orders', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('footlong', 3);
      expect(repo.price, 33);
    });

    test('calculates multiple six-inch orders', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('six-inch', 4);
      expect(repo.price, 28);
    });

    test('returns zero for unknown sandwich type', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('unknown', 2);
      expect(repo.price, 0);
    });

    test('handles zero quantity of footlong', () {
      final repo = PricingRepository();
      repo.calculateOrderPrice('footlong', 0);
      expect(repo.price, 0);
    });
  });
}
