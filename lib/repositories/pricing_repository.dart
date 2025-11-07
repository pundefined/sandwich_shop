class PricingRepository {
  int _price = 0;

  int get price => _price;

  void calculateOrderPrice(String sandwichType, int quantity) {
    if (sandwichType == 'footlong') {
      _price = 11;
    } else if (sandwichType == 'six-inch') {
      _price = 7;
    } else {
      _price = 0;
    }
    _price = price * quantity;
  }
}
