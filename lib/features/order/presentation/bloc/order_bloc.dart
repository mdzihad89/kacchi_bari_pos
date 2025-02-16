

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  OrderBloc({required this.orderRepository}) : super(const OrderInitial()){
    on<GetAllOrderEvent>(_onGetAllOrder);
    on<GetUnsyncOrderEvent>(_onGetUnsyncOrderEvent);

  }

  void _onGetAllOrder(GetAllOrderEvent event, Emitter<OrderState> emit) async {
    emit(const OrderLoading());
    final orderResult = await orderRepository.getAllOrder(event.orderFilter);
    orderResult.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (orderResponse) => emit(OrderLoaded(orderResponse: orderResponse)),
    );
  }

  void _onGetUnsyncOrderEvent(GetUnsyncOrderEvent event, Emitter<OrderState> emit) async {
    emit(const OrderLoading());
    final orderResult = await orderRepository.getAllUnsyncOrder(event.orderFilter);
    orderResult.fold(
      (failure) => emit(UnsyncOrderError(message: failure.message)),
      (orders) => emit(UnsyncOrderLoaded(orderResponse: orders)),
    );
  }

}