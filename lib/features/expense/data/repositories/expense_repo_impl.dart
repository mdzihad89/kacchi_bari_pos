
 import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/expense/data/model/expense_report_dto.dart';
import 'package:kachi_bari_pos/features/expense/data/model/expense_report_model.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';
import '../../domain/repository/expense_repository.dart';
import '../model/expense_dto.dart';
import '../model/expense_filter.dart';
import '../model/expense_model.dart';
import '../model/expense_response_model.dart';

class ExpenseRepoImpl extends ExpenseRepository{
  final ApiService _apiService;
  ExpenseRepoImpl(this._apiService);
  @override
  Future<Either<Failure, ExpenseResponseModel>> getExpenses(ExpenseFilter expenseFilter) async{
    try{
      final response = await _apiService.get(endPoint: "expense/get-all-expenses", params: expenseFilter.toQueryParams());
      final data = ExpenseResponseModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }

  }

  @override
  Future<Either<Failure, ExpenseModel>> addExpenses(ExpenseDto expenseDto)async {
    try{
      final response =await _apiService.post(endPoint: "expense/create-expense", data: expenseDto.toJson());
      final data = ExpenseModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ExpenseReportModel>> getExpenseReport(ExpenseReportDTO expenseReportDTO)async {
    try{
      final response = await _apiService.get(endPoint: "expense/get-expense-report", params: expenseReportDTO.toJson());
      final data = ExpenseReportModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }


}