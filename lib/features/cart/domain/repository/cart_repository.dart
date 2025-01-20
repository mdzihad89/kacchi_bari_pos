import 'package:dartz/dartz.dart';
import '../../../../core/network/failure.dart';
import '../../data/data_sources/local/isar/orders.dart';
import '../../data/model/order_model.dart';



abstract class CartRepository {
  Future<Either<Failure, Unit>> addOrderLocalDatabase(Orders orders);
}