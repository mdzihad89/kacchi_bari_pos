import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/printer/printer_service.dart';
import '../../data/model/cart_model.dart';
import '../../domain/repository/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  final PrintingService printingService;

  CartBloc({required this.cartRepository, required this.printingService}) : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<UpdateDiscount>(_onUpdateDiscount);
    on<UpdatePaidAmount>(_onUpdatePaidAmount);
    on<PlaceOrder>(_onPlaceOrder);
    on<UpdateDeliveryFee>(_onUpdateDeliveryFee); // Register the new event handler
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

    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price) + state.deliveryFee;
    final changeAmount = state.paidAmount - (subtotal - state.discount);
    emit(state.copyWith(cartItems: updatedCart, subtotal: subtotal, changeAmount: changeAmount));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedCart = state.cartItems.where((item) => item.productID != event.productID).toList();
    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price) + state.deliveryFee;
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

    final subtotal = updatedCart.fold(0, (sum, item) => sum + item.price) + state.deliveryFee;
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

  void _onPlaceOrder(PlaceOrder event, Emitter<CartState> emit) async {
    final orderModel = event.orderModel;
    emit(state.copyWith(cartLoading: true));
    final result = await cartRepository.addOrder(orderModel);
    result.fold(
            (failure) => emit(state.copyWith(errorMessage: failure.message, cartLoading: false)),
            (string) async {
          emit(state.copyWith(cartItems: [], subtotal: 0, discount: 0, paidAmount: 0, changeAmount: 0,deliveryFee: 0, cartLoading: false));
          await printingService.printOrder(orderModel);
        }
    );
  }

  void _onUpdateDeliveryFee(UpdateDeliveryFee event, Emitter<CartState> emit) {
    final deliveryFee = event.deliveryFee;
    final subtotal = state.cartItems.fold(0, (sum, item) => sum + item.price) + deliveryFee;
    final changeAmount = state.paidAmount - (subtotal - state.discount);
    emit(state.copyWith(deliveryFee: deliveryFee, subtotal: subtotal, changeAmount: changeAmount));
  }
}