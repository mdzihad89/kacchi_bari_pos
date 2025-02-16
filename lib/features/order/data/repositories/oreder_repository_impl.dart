import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import 'package:kachi_bari_pos/core/network/api_service.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/order/data/model/branch_order_model.dart';
import 'package:kachi_bari_pos/features/order/domain/repository/order_repository.dart';
import '../../../../core/network/error_handle.dart';
import '../../../home/data/model/dine_in_payment_model.dart';
import '../model/order_filter_model.dart';

class OrderRepositoryImpl extends OrderRepository{
  final ApiService _apiService;
  final LocalDataSource _localDataSource;

  OrderRepositoryImpl(this._apiService, this._localDataSource);
  @override
  Future<Either<Failure, OrderResponse>> getAllOrder(OrderFilter orderFilter) async{
    try{
      final response = await _apiService.get(endPoint: "order/get-all-order", params: orderFilter.toQueryParams());
      final data =  OrderResponse.fromJson(response.data);
      return Right(data);
    }catch(error){
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, OfflineOrderResponse>> getAllUnsyncOrder(OrderFilter orderFilter) async{
    try{
      final data = await _localDataSource.getOfflineAllOrder( orderFilter);
      return Right(data);
    } catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, OrderModel>> updateOrder(DineInPaymentModel dineInPaymentModel)async {
    try{
      final data= await _localDataSource.updateOrderPayment(dineInPaymentModel);
      return  Right(data);
    }catch (error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, OrderModel>> updatePendingOrderOnline(dynamic paymentModel) async{
    try{
      final response = await _apiService.post(endPoint: "order/update-pending-order", data: paymentModel.toJson());
      final data = OrderModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }


  }



}