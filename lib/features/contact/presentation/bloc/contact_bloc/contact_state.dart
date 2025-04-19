import 'package:equatable/equatable.dart';
import '../../../data/model/contact_model.dart';

class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;

  const ContactLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object> get props => [message];
}

class ContactOperationLoading extends ContactState {}

class ContactOperationError extends ContactState {
  final String message;

  const ContactOperationError(this.message);

  @override
  List<Object> get props => [message];
}

class ContactOperationSuccess extends ContactState {}
