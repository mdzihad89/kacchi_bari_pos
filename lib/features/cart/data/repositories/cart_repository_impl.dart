import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/core/printer/printer_service.dart';
import 'package:kachi_bari_pos/features/cart/domain/repository/cart_repository.dart';
import '../../../../core/local/local_data_source.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';
import '../model/order_model.dart';

class CartRepositoryImpl extends CartRepository {
  final LocalDataSource _localDataSource;
  final ApiService _apiService;
  CartRepositoryImpl( this._localDataSource,this._apiService);

@override
Future<Either<Failure, String>> addOrder(OrderModel orderModel) async {
  try {
    final response = await _apiService.post(
      endPoint: "order/create-order",
      data: orderModel.toMap()
    );
  if(response.statusCode==200){
    final message =  response.data['message'];
    return Right(message);
  }else{
    try {
      await _localDataSource.addOfflineOrder(orderModel);
      return const Right("Order added to local storage");
    } catch (localError) {
      return Left(ErrorHandler.handle(localError).failure);
    }
  }
  } catch (error) {
    // if ( error is DioException && error.type == DioExceptionType.connectionError) {
    //   try {
    //     await _localDataSource.addOrder(orderModel);
    //     return const Right("Order added to local storage");
    //   } catch (localError) {
    //     return Left(ErrorHandler.handle(localError).failure);
    //   }
    // } else {
    //   return Left(ErrorHandler.handle(error).failure);
    // }

      try {
        await _localDataSource.addOfflineOrder(orderModel);
        return const Right("Order added to local storage");
      } catch (localError) {
        return Left(ErrorHandler.handle(localError).failure);
      }
  }
}


}
