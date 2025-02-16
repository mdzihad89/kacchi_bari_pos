
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import '../../../../core/app/app_prefs.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/error_handle.dart';
import '../../../../core/network/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/login_request_dto.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl extends AuthRepository{
  final ApiService _apiService;
  final AppPreferences _appPref;
  final LocalDataSource _localDataSource;
  AuthRepositoryImpl(this._apiService, this._appPref, this._localDataSource);



  @override
  Future<Either<Failure, User>> signInWithEmailPassword(LoginRequestDto loginRequestDto) async{
    try{
      final response = await _apiService.post(endPoint: "user/login", data: loginRequestDto.toJson());
      final data = userFromJson(jsonEncode(response.data));
      if(data.role=="manager"){
        if(data.branchId!="" && data.branchName!=""){
          await _appPref.saveCredential(data.token!);
          await _localDataSource.saveUserModel(data);
          return Right(data);
        }else{
          return Left(Failure(ResponseCode.forbidden, "Branch not assigned to this user."));
        }
      }else{
        return Left(Failure(ResponseCode.forbidden, "Only managers are allowed to sign in."));
      }
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<bool> signOut() async{
   await _appPref.removeCredential();
    await _localDataSource.deleteUserModel();
    return Future.value(true);
  }

  @override
  Future<Either<Failure, User>> getUserData() async{
   try{
     final response= await _apiService.get(endPoint: "user/get-user-data");
     final data = userFromJson(jsonEncode(response.data));
     return Right(data);
   }catch(error){
     try{
        final data = await _localDataSource.getUserModel();
        return Right(data);

     }catch(e){
       return Left(ErrorHandler.handle(error).failure);
     }

   }
  }

  @override
  Future<Either<Failure, String>>  syncOrder() async{
    try{
      final unSyncOrder =await _localDataSource.getAllUnsyncOrder();

      if(unSyncOrder.isNotEmpty){
        final List<Map<String, dynamic>> ordersJson = unSyncOrder.map((order) => order.toMap()).toList();
        final response = await _apiService.post(
          endPoint: "order/sync-order",
          data: jsonEncode(ordersJson),
        );
        if(response.statusCode==200){
          await _localDataSource.deleteOfflineOrder();
          return  const Right( 'Order synced successfully');
        }
      }
      return const Right('No order to sync');
    }catch(error){

      return  Left(ErrorHandler.handle(error).failure) ;
    }
  }



}