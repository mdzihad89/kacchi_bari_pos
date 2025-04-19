import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import 'package:kachi_bari_pos/features/home/data/model/branch_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/category_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/product_model.dart';
import 'package:kachi_bari_pos/features/home/domain/repository/home_repository.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';


class HomeRepositoryImpl extends HomeRepository{
  final LocalDataSource _localDataSource;
  final ApiService _apiService;
  HomeRepositoryImpl(this._apiService, this._localDataSource);

  @override
  Future<Either<Failure,List<CategoryModel>>> getCategoryData() async{

    try{
      final data = await _localDataSource.getAllCategories();
      if(data.isEmpty){
        final response = await _apiService.get(endPoint: "category/get-all-category");
        final List<dynamic> jsonData = response.data;
        final data = jsonData.map((item) => CategoryModel.fromJson(item)).toList();
        await _localDataSource.saveAllCategories(data);
        return Right(data);
      }else{
        return Right(data);
      }
    }catch(error){
      // try{
      //   final data = await _localDataSource.getAllCategories();
      //   return Right(data);
      // }catch(error){
      //   return Left(ErrorHandler.handle(error).failure);
      // }
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductData() async{
    try{
      final data = await _localDataSource.getAllProducts();

      log(data.toString());
      if(data.isEmpty){
        final response = await _apiService.get(endPoint: "food/get-all-foods");
        final List<dynamic> jsonData = response.data;
        final data = jsonData.map((item) => ProductModel.fromJson(item)).toList();
        await _localDataSource.saveAllProducts(data);
        return Right(data);
      }else{
        return Right(data);
      }
    }catch(error){
      //
      // try{
      //   final data = await _localDataSource.getAllProducts();
      //   return Right(data);
      //
      // }catch(error){
      //   return Left(ErrorHandler.handle(error).failure);
      // }
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BranchModel>> getBranchData(String branchId) async{
    try{
      final data = await _localDataSource.getBranch();
      if(data==null){
        final response = await _apiService.get(endPoint: "branch/$branchId");
        final data = BranchModel.fromJson(response.data);
        await _localDataSource.saveBranch(data);
        return Right(data);
      }else{
        return Right(data);
      }

    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }





}