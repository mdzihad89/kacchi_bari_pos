import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/cart/data/data_sources/local/order_local_data_sources.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/cart/domain/repository/cart_repository.dart';
import '../../../../core/network/error_handle.dart';
import '../data_sources/local/isar/orders.dart';

class CartRepositoryImpl extends CartRepository {
  final OrdersLocalDataSource _ordersLocalDataSource;

  CartRepositoryImpl( this._ordersLocalDataSource);

  @override
  Future<Either<Failure, Unit>> addOrderLocalDatabase(Orders orders) async {
    try {
      await _ordersLocalDataSource.addOrder(orders);
      return const Right(unit);
    } catch (error) {
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
