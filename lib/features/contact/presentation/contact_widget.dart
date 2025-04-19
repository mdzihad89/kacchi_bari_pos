import 'dart:async';
import 'dart:math';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/common/textform_field.dart';
import '../../../core/constants/color_constants.dart';
import '../data/model/contact_dto.dart';
import '../data/model/contact_model.dart';
import 'bloc/contact_bloc/contact_bloc.dart';
import 'bloc/contact_bloc/contact_event.dart';
import 'bloc/contact_bloc/contact_state.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({super.key});

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<ContactBloc>().add(const GetAllContacts());
    super.initState();
  }

  Timer? _debounce;
  List<ContactModel> _filteredContacts = [];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _filteredContacts = context.read<ContactBloc>().contacts.where((contact) {
          return contact.name.toLowerCase().contains(query.toLowerCase()) ||
              contact.number.contains(query);
        }).toList();

      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _contactNameController.dispose();
    _contactNumberController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  ContactModel? _selectedContact;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: CTextFormField(
                        labelText: "Contact Name",
                        validatorText: "Name is required",
                        textEditingController: _contactNameController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CTextFormField(
                        labelText: "Contact Number",
                        validatorText: "Number is required",
                        textEditingController: _contactNumberController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CTextFormField(
                      labelText: "Search here",
                      validatorText: "Search text required",
                      textEditingController: _searchController,
                      onChanged: (value) {
                        _onSearchChanged(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  BlocConsumer<ContactBloc, ContactState>(
                    listener: (context, state) {
                      if (state is ContactOperationError) {
                        ElegantNotification.error(
                          title: const Text(
                            "Error",
                            style: TextStyle(color: Colors.black),
                          ),
                          description: Text(
                            state.message,
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                          width: 300,
                          height: 100,
                        ).show(context);
                      }
                      if (state is ContactOperationSuccess) {
                        ElegantNotification.success(
                          title: const Text(
                            "Success",
                            style: TextStyle(color: Colors.black),
                          ),
                          description: const Text(
                            "Operation Successful",
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                          width: 300,
                          height: 100,
                        ).show(context);

                        _contactNumberController.clear();
                        _contactNameController.clear();
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if(_selectedContact != null){
                              context.read<ContactBloc>().add(UpdateContact(contactId: _selectedContact!.id, contactDto: ContactDto(branchId:_selectedContact!.branchId,name: _contactNameController.text, number: _contactNumberController.text)));
                              _selectedContact = null;
                            }else{
                              context.read<ContactBloc>().add(AddContact(
                                name: _contactNameController.text,
                                phone: _contactNumberController.text,
                              ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 45),
                          backgroundColor: ColorConstants.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: state is ContactOperationLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: BlocBuilder<ContactBloc, ContactState>(
                buildWhen: (previous, current) {
                  return current is ContactLoaded;
                },
                builder: (context, state) {
                  if (state is ContactLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ContactLoaded) {
                    final contactsToShow = _searchController.text.isEmpty
                        ? state.contacts
                        : _filteredContacts;
                    return ListView.builder(
                      itemCount: contactsToShow.length,
                      itemBuilder: (context, index) {
                        final sortedContacts = List<ContactModel>.from(contactsToShow)
                          ..sort((a, b) =>
                              a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.50,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(context: context,
                                    builder: (context) {

                                      return AlertDialog(
                                        title: const Text("Edit Contact"),
                                        content: const Text(
                                            "Are you sure you want to edit this contact?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _selectedContact = sortedContacts[index];
                                                _contactNameController.text = sortedContacts[index].name;
                                                _contactNumberController.text = sortedContacts[index].number;
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: const Text("Edit"),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                },
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Delete Contact"),
                                          content: const Text(
                                              "Are you sure you want to delete this contact?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.read<ContactBloc>().add(DeleteContact(sortedContacts[index].id));
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      });

                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),

                            ],

                          ),

                          child: ListTile(
                            title: Text(sortedContacts[index].name),
                            subtitle: Text(sortedContacts[index].number),
                          ),
                        );
                      },
                    );
                  } else if (state is ContactError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )),
            ],
          ),
        ),
        Expanded(flex:5,child: Container())
      ],
    );
  }
}
