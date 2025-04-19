
import 'package:equatable/equatable.dart';
import '../../../data/model/contact_dto.dart';


abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class GetAllContacts extends ContactEvent {


  const GetAllContacts();

  @override
  List<Object> get props => [];
}

class AddContact extends ContactEvent {
  final String name;
  final String phone;

  const AddContact({required this.name, required this.phone});

  @override
  List<Object> get props => [name, phone];
}

class DeleteContact extends ContactEvent {
  final String id;
  const DeleteContact(this.id);

  @override
  List<Object> get props => [id];
}


class UpdateContact extends ContactEvent {
  final String contactId;
   final ContactDto contactDto;

  const UpdateContact({required this.contactId,  required this.contactDto });

  @override
  List<Object> get props => [contactId, contactDto];
}