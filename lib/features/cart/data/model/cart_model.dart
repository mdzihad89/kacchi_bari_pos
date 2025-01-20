class CartItem {
  final String productName;
  final int unitPrice;
  final String productID;
  int quantity;
  int price;

  CartItem({
    required this.productName,
    required this.unitPrice,
    required this.productID,
    required this.quantity,
  }) : price = unitPrice * quantity;

  void updatePrice() {
    price = unitPrice * quantity;
  }

  @override
  String toString() {
    return 'CartItem{productName: $productName, unitPrice: $unitPrice, productID: $productID, quantity: $quantity, price: $price}';
  }
}