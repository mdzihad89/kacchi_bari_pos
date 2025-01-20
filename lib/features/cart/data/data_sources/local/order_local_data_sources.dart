
import 'package:dartz/dartz.dart';
import '../../model/order_model.dart';
import 'isar/orders.dart';


abstract class OrdersLocalDataSource {
  Future<bool> initDb();
  // Future<List<OrderModel>> getAllOrder();
  Future<Unit> addOrder(Orders orders);
  // Future<Unit> deleteOrder(String id);
}