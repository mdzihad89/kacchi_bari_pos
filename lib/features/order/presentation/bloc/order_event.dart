
import 'package:equatable/equatable.dart';

import '../../data/model/order_filter_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

}

class GetAllOrderEvent extends OrderEvent{
  final OrderFilter orderFilter;

  const GetAllOrderEvent({required this.orderFilter});

  @override
  List<Object?> get props => [orderFilter];
}

class GetUnsyncOrderEvent extends OrderEvent{
  final OrderFilter orderFilter;
  const GetUnsyncOrderEvent({required this.orderFilter});

  @override
  List<Object?> get props => [orderFilter];
}