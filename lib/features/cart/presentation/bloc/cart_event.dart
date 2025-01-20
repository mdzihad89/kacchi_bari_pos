import 'package:equatable/equatable.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/product_model.dart';

import '../../data/data_sources/local/isar/orders.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final ProductModel product;
  final Variation? variation;

  const AddToCart({required this.product, this.variation});

  @override
  List<Object?> get props => [product, variation];
}

class RemoveFromCart extends CartEvent {
  final String productID;

  const RemoveFromCart({required this.productID});

  @override
  List<Object> get props => [productID];
}

class UpdateQuantity extends CartEvent {
  final String productID;
  final int quantity;

  const UpdateQuantity({required this.productID, required this.quantity});

  @override
  List<Object> get props => [productID, quantity];
}

class UpdateDiscount extends CartEvent {
  final int discount;

  const UpdateDiscount({required this.discount});

  @override
  List<Object> get props => [discount];
}

class UpdatePaidAmount extends CartEvent {
  final int paidAmount;

  const UpdatePaidAmount({required this.paidAmount});

  @override
  List<Object> get props => [paidAmount];
}

class PlaceOrder extends CartEvent {
  final Orders orders;
  const PlaceOrder({required this.orders});

  @override
  List<Object> get props => [];
}
