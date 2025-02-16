import 'package:equatable/equatable.dart';

import '../../data/model/cart_model.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final int subtotal;
  final int discount;
  final int paidAmount;
  final int changeAmount;
  final int deliveryFee;
  final String errorMessage;
  final bool cartLoading;

  const CartState({
    this.cartItems = const [],
    this.subtotal = 0,
    this.discount = 0,
    this.paidAmount = 0,
    this.changeAmount = 0,
    this.deliveryFee = 0,
    this.errorMessage = '',
    this.cartLoading = false,
  });

  CartState copyWith({
    List<CartItem>? cartItems,
    int? subtotal,
    int? discount,
    int? paidAmount,
    int? changeAmount,
    int? deliveryFee,
    String? errorMessage,
    bool? cartLoading,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      paidAmount: paidAmount ?? this.paidAmount,
      changeAmount: changeAmount ?? this.changeAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      errorMessage: errorMessage ?? this.errorMessage,
      cartLoading: cartLoading ?? this.cartLoading,
    );
  }

  @override
  List<Object?> get props => [cartItems, subtotal, discount, paidAmount, changeAmount, deliveryFee, errorMessage, cartLoading];
}