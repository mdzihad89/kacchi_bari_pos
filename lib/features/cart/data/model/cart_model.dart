import '../../../order/data/model/branch_order_model.dart';

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


  factory CartItem.fromCart(Cart cart) {
    return CartItem(
      productName: cart.productName,
      unitPrice: cart.unitPrice,
      productID: cart.productID,
      quantity: cart.quantity,
    );
  }
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productName: json['productName'],
      unitPrice: json['unitPrice'],
      productID: json['productID'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'productName': productName,
      'unitPrice': unitPrice,
      'productID': productID,
      'quantity': quantity,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'CartItem{productName: $productName, unitPrice: $unitPrice, productID: $productID, quantity: $quantity, price: $price}';
  }
}