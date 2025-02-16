
import 'package:equatable/equatable.dart';
import 'package:kachi_bari_pos/core/local/model/branch_model_isar.dart';
import 'package:kachi_bari_pos/core/local/model/order_model_isar.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/order/data/model/branch_order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

}

class OrderInitial extends OrderState {
  const OrderInitial();

  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {
  const OrderLoading();

  @override
  List<Object?> get props => [];
}

class OrderLoaded extends OrderState {
  final OrderResponse orderResponse;

  const OrderLoaded({required this.orderResponse});

  @override
  List<Object?> get props => [orderResponse];
}


class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object?> get props => [message];
}



class UnsyncOrderLoaded extends OrderState {
  final OfflineOrderResponse orderResponse;

  const UnsyncOrderLoaded({required this.orderResponse});

  @override
  List<Object?> get props => [orderResponse];
}

class UnsyncOrderError extends OrderState {
  final String message;

  const UnsyncOrderError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnsyncOrderLoading extends OrderState {
  const UnsyncOrderLoading();
  @override
  List<Object?> get props => [];
}
