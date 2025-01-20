import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/cart_model.dart';
import '../../domain/repository/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<UpdateDiscount>(_onUpdateDiscount);
    on<UpdatePaidAmount>(_onUpdatePaidAmount);
    on<PlaceOrder>(_onPlaceOrder);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cartItems);
    final productID = event.variation != null ? '${event.product.id}-${event.variation!.id}' : event.product.id;
    final existingIndex = updatedCart.indexWhere((item) => item.productID == productID);

    if (existingIndex != -1) {
      updatedCart[existingIndex].quantity += 1;
      updatedCart[existingIndex].updatePrice();
    } else {
      final unitPrice = event.variation?.price ?? event.product.price;
      final productName = event.variation != null ? '${event.product.name} - 1 : ${event.variation!.personCount}' : event.product.name;
      updatedCart.add(CartItem(
        productName: productName,
        unitPrice: unitPrice,
        productID: productID,
        quantity: 1,
      ));
    }

    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price);
    final changeAmount = state.paidAmount - (subtotal - state.discount);
    emit(state.copyWith(cartItems: updatedCart, subtotal: subtotal, changeAmount: changeAmount));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedCart = state.cartItems.where((item) => item.productID != event.productID).toList();
    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price);
    final changeAmount = state.paidAmount - (subtotal - state.discount);
    emit(state.copyWith(cartItems: updatedCart, subtotal: subtotal, changeAmount: changeAmount));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final updatedCart = state.cartItems.map((item) {
      if (item.productID == event.productID) {
        item.quantity = event.quantity;
        item.updatePrice();
      }
      return item;
    }).toList();

    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price);
    final changeAmount = state.paidAmount - (subtotal - state.discount);
    emit(state.copyWith(cartItems: updatedCart, subtotal: subtotal, changeAmount: changeAmount));
  }

  void _onUpdateDiscount(UpdateDiscount event, Emitter<CartState> emit) {
    final discount = event.discount;
    final subtotal = state.subtotal;
    final paidAmount = state.paidAmount;
    final changeAmount = paidAmount - (subtotal - discount);

    emit(state.copyWith(discount: discount, changeAmount: changeAmount));
  }

  void _onUpdatePaidAmount(UpdatePaidAmount event, Emitter<CartState> emit) {
    final paidAmount = event.paidAmount;
    final subtotal = state.subtotal;
    final discount = state.discount;
    final changeAmount = paidAmount - (subtotal - discount);

    emit(state.copyWith(paidAmount: paidAmount, changeAmount: changeAmount));
  }

  void _onPlaceOrder(PlaceOrder event, Emitter<CartState> emit) async{
    final orders = event.orders;
    final result= await cartRepository.addOrderLocalDatabase(orders);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (unit) => emit( state.copyWith(cartItems: [], subtotal: 0, discount: 0, paidAmount: 0, changeAmount: 0))
    );



  }
}