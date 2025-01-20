import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/home/data/model/branch_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/category_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/product_model.dart';
import 'package:kachi_bari_pos/features/home/domain/repository/home_repository.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';


class HomeRepositoryImpl extends HomeRepository{
  final ApiService _apiService;
  HomeRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure,List<CategoryModel>>> getCategoryData() async{

    try{
      final response = await _apiService.get(endPoint: "category/get-all-category");
      final List<dynamic> jsonData = response.data;
      final data = jsonData.map((item) => CategoryModel.fromJson(item)).toList();
      return Right(data);
    }catch(error){

      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductData() async{
    try{
      final response = await _apiService.get(endPoint: "food/get-all-foods");
      final List<dynamic> jsonData = response.data;
      final data = jsonData.map((item) => ProductModel.fromJson(item)).toList();
      return Right(data);
    }catch(error){

      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BranchModel>> getBranchData(String branchId) async{
    try{
      final response = await _apiService.get(endPoint: "branch/$branchId");
      final data = BranchModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      log(error.toString());
      return Left(ErrorHandler.handle(error).failure);
    }
  }





}