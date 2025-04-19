import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_dto.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_filter.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_model.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_response_model.dart';
import 'package:kachi_bari_pos/features/expense/domain/repository/cash_repository.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';

class CashReposImpl extends CashRepository{
  final ApiService _apiService;
  CashReposImpl(this._apiService);


  @override
  Future<Either<Failure, CashModel>> addCashRecord(CashDTO cashDto) async{
    try{
      final response = await _apiService.post(endPoint: "cash/create-cash", data: cashDto.toJson());
      final data = CashModel.fromJson(response.data);
      return Right(data);
    }catch(error){

      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, CashResponseModel>> getCashRecord(CashFilter cashFilter) async{
    try{
      final response = await _apiService.get(endPoint: "cash/get-all-cash", params: cashFilter.toQueryParams());
      final data = CashResponseModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }





}