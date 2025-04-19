import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/local/model/order_model_isar.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/dine_in_payment_model.dart';
import 'package:kachi_bari_pos/features/order/data/model/branch_order_model.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/order_filter_model.dart';


abstract class OrderRepository{

  Future<Either<Failure,OrderResponse>> getAllOrder( OrderFilter orderFilter);
  Future<Either<Failure, OfflineOrderResponse>> getAllUnsyncOrder(OrderFilter orderFilter);
  Future<Either<Failure, OrderModel>> updateOrder(dynamic paymentOrderModel , String orderType);
  Future<Either<Failure, OrderModel>> updatePendingOrderOnline(DineInPaymentModelOnline dineInPaymentModelOnline);


}