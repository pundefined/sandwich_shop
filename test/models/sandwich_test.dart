import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich Model', () {
    test('creates sandwich with correct properties', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      expect(sandwich.type, SandwichType.chickenTeriyaki);
      expect(sandwich.isFootlong, true);
      expect(sandwich.breadType, BreadType.wheat);
    });

    test('name getter returns correct sandwich name', () {
      final veggieDelight = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );
      expect(veggieDelight.name, 'Veggie Delight');

      final meatballMarinara = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      expect(meatballMarinara.name, 'Meatball Marinara');
    });

    test('image getter returns correct footlong image path', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.white,
      );
      expect(sandwich.image, 'assets/images/tunaMelt_footlong.png');
    });

    test('image getter returns correct six inch image path', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      expect(sandwich.image, 'assets/images/chickenTeriyaki_six_inch.png');
    });
  });
}
