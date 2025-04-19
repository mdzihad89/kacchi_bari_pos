
import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';
import '../data/model/contact_dto.dart';
import '../data/model/contact_model.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactModel>>> getAllContacts( String branchId);
  Future<Either<Failure, ContactModel>> addContact(ContactDto contactDto);
  Future<Either<Failure, bool>> deleteContact(String id);
  Future<Either<Failure, ContactModel>> updateContact(String contactId,ContactDto contactDto);
}