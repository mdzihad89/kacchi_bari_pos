import 'package:dartz/dartz.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/order_model.dart';



abstract class CartRepository {
  Future<Either<Failure, String>> addOrder(OrderModel orderModel);
}