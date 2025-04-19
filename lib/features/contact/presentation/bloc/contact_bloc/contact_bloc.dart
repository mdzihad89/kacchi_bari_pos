
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kachi_bari_pos/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../../auth/presentation/bloc/state/auth_state.dart';
import '../../../data/model/contact_dto.dart';
import '../../../data/model/contact_model.dart';
import '../../../domain/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;
  final AuthBloc authBloc;
   List<ContactModel> contacts = [];


  ContactBloc({required this.contactRepository, required this.authBloc}) : super(ContactInitial()){
    on<GetAllContacts>(_onGetAllContacts);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);

  }

  void _onGetAllContacts(GetAllContacts event, Emitter<ContactState> emit) async {
    emit( ContactLoading());
     if(authBloc.state is Authenticated){
       final branchId = (authBloc.state as Authenticated).user.branchId;
       final contactResult = await contactRepository.getAllContacts(branchId);
       contactResult.fold(
         (failure) => emit(ContactError( failure.message)),
         (contacts) {
            emit(ContactLoaded(contacts));
            this.contacts = contacts;
         },
       );
      }else{
        emit(const ContactError('User is not authenticated'));
     }
  }

  void _onAddContact(AddContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded || state is ContactOperationError) {
      emit(ContactOperationLoading());
      final branchId = (authBloc.state as Authenticated).user.branchId;
      final contactDto = ContactDto(
        branchId: branchId,
        name: event.name,
        number: event.phone,
      );
      final contactResult = await contactRepository.addContact(contactDto);
      contactResult.fold(
            (failure) => emit(ContactOperationError(failure.message)),
            (contact) {
          contacts.add(contact);
          emit(ContactOperationSuccess());
          emit(ContactLoaded(contacts));
        },
      );
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      emit(ContactOperationLoading());
      final contactResult = await contactRepository.deleteContact(event.id);
      contactResult.fold(
            (failure) => emit(ContactOperationError(failure.message)),
            (contact) {
          contacts.removeWhere((element) => element.id == event.id);
          emit(ContactOperationSuccess());
          emit(ContactLoaded(contacts));
        },
      );
    }
  }


void _onUpdateContact(UpdateContact event, Emitter<ContactState> emit) async {
  if (state is ContactLoaded || state is ContactOperationError) {
    emit(ContactOperationLoading());
    final contactResult = await contactRepository.updateContact(
        event.contactId, event.contactDto);
    contactResult.fold(
          (failure) => emit(ContactOperationError(failure.message)),
          (contact) {
            final index = contacts.indexWhere((element) => element.id == event.contactId);
            if (index != -1) {
            contacts[index] = contact;
            }
            emit(ContactOperationSuccess());
            emit(ContactLoaded(contacts));


      },
    );
  }
}
}