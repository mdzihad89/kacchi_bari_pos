
import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/core/network/failure.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/error_handle.dart';
import '../domain/contact_repository.dart';
import 'model/contact_dto.dart';
import 'model/contact_model.dart';

class ContactRepoImpl implements ContactRepository {
  final ApiService _apiService;
  ContactRepoImpl( this._apiService);

  @override
  Future<Either<Failure, ContactModel>> addContact(ContactDto contactDto) async{
    try{
      final response = await _apiService.post(endPoint: "contact/create-contact", data: contactDto.toJson());
      final data = ContactModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }

  }


  @override
  Future<Either<Failure, List<ContactModel>>> getAllContacts(String branchId) async{
    try{
      final response = await _apiService.get(endPoint: "contact/get-all-contact", params: {"branchId": branchId});
      final data =   (response.data as List).map((e) => ContactModel.fromJson(e)).toList();
      return Right(data);
    }catch(error){

      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContact(String id)async {
    try{
      await _apiService.delete(endPoint: "contact/delete-contact/$id");
      return const Right(true);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }

  }


  @override
  Future<Either<Failure, ContactModel>> updateContact(String contactId,ContactDto contactDto) async{
    try{
      final response = await _apiService.put(endPoint: "contact/update-contact/$contactId", data: contactDto.toJson());
      final data = ContactModel.fromJson(response.data);
      return Right(data);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }

  }

}