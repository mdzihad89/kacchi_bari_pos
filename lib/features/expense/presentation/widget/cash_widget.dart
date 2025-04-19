import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_dto.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_filter.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_model.dart';
import 'package:kachi_bari_pos/features/expense/data/repositories/cash_repo_impl.dart';
import 'package:paged_datatable/paged_datatable.dart';

import '../../../../core/common/textform_field.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../service_locator.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';

class CashWidget extends StatefulWidget {
  const CashWidget({super.key});

  @override
  State<CashWidget> createState() => _CashWidgetState();
}

class _CashWidgetState extends State<CashWidget> {
  TextEditingController currentCash = TextEditingController();
  TextEditingController cashDateTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final tableController = PagedDataTableController<String, CashModel>();
  bool isLoading = false;
  String? cashSelectedDate ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: CTextFormField(
                  labelText: 'Current Cash',
                  textEditingController: currentCash,
                  validatorText: 'Enter current cash',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CTextFormField(
                  labelText: "Date & Time",
                  validatorText:
                  "Enter date & time",
                  textEditingController: cashDateTime,
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        cashDateTime.text =DateFormat.yMMMd().format(selectedDate);
                        cashSelectedDate = selectedDate.toIso8601String();

                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      final authLoadedState =
                      context.read<AuthBloc>().state as Authenticated;
                      final cashDTO = CashDTO(
                          currentCash: int.parse(currentCash.text),
                          branchId: authLoadedState.user.branchId,
                          cashDate: cashSelectedDate!,
                      );

                      CashReposImpl cashReposImpl = instance<CashReposImpl>();
                      cashReposImpl.addCashRecord(cashDTO).then((value) {
                        value.fold(
                              (failure) {
                                log(failure.message);
                            setState(() {
                              isLoading = false;
                            });
                            ElegantNotification.error(
                              title: const Text("Error",
                                  style: TextStyle(color: Colors.black)),
                              description: Text(failure.message,
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 1),
                              width: 300,
                              height: 100,
                            ).show(context);
                          },
                              (expenseModel) {
                            setState(() {
                              isLoading = false;
                            });

                            ElegantNotification.success(
                              title: const Text("Success",
                                  style: TextStyle(color: Colors.black)),
                              description: const Text(
                                  "Cash added successfully",
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1),
                              width: 300,
                              height: 100,
                            ).show(context);
                            tableController.insertAt(0, expenseModel);
                            currentCash.clear();
                          },
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 45),
                    backgroundColor: ColorConstants.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Text(
                    'Add Cash',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: PagedDataTableTheme(
            data: PagedDataTableThemeData(
              selectedRow: Colors.grey[700],
              rowColor: (index) =>
              index.isEven ? Colors.grey[900] : Colors.grey[850],
              backgroundColor: Colors.black,
              headerTextStyle:
              const TextStyle(color: Colors.white, fontSize: 14),
              cellTextStyle: const TextStyle(color: Colors.white),
              footerTextStyle: const TextStyle(color: Colors.white),
              horizontalScrollbarVisibility: true,
              verticalScrollbarVisibility: true,
              cellPadding:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            child: PagedDataTable<String, CashModel>(
              controller: tableController,
              initialPageSize: 20,
              fixedColumnCount: 2,
              configuration: const PagedDataTableConfiguration(),
              pageSizes: const [20, 30, 40, 50],
              fetcher: (pageSize, sortModel, filterModel, pageToken) async {
                final authLoadedState =
                context.read<AuthBloc>().state as Authenticated;
                dynamic cashDate = filterModel["cashDate"] != null
                    ? (filterModel["cashDate"] as DateTime).toIso8601String()
                    : null;

                CashFilter cashFilter = CashFilter(
                    branchId: authLoadedState.user.branchId,
                   cashDate: cashDate,
                    pageLimit: pageSize.toString(),
                    pageToken: pageToken);

                CashReposImpl cashRepo = instance<CashReposImpl>();
                final cashResult = await cashRepo.getCashRecord(cashFilter);

                return cashResult.fold(
                      (failure) {
                    ElegantNotification.error(
                      title: const Text("Error",
                          style: TextStyle(color: Colors.black)),
                      description: Text(failure.message,
                          style: TextStyle(color: Colors.black), maxLines: 1),
                      width: 300,
                      height: 100,
                    ).show(context);

                    return (List<CashModel>.empty(), null);
                  },
                      (cashResponse){
                        return(cashResponse.cashRecords, cashResponse.nextPageToken);},
                );
              },
              filters: [
                DateTimePickerTableFilter(
                  id: "cashDate",
                  name: "Cash Date",
                  chipFormatter: (date) =>
                  "Date is ${DateFormat('dd/MM/yyyy').format(date)}",
                  initialValue: null,
                  firstDate: DateTime.now().subtract(const Duration(days: 1825)),
                  lastDate: DateTime.now(),
                  dateFormat: DateFormat('dd/MM/yyyy'),
                  inputDecoration: InputDecoration(
                    hintText: "Select cash date",
                    border: const OutlineInputBorder(),
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    labelText: "Cash Date",
                  ),
                ),
              ],
              columns: [
                TableColumn(
                  title: const Text("Current Cash"),
                  cellBuilder: (context, item, index) => Text("${item.currentCash} Tk"),
                  size: const FixedColumnSize(150),
                ),
                TableColumn(
                  title: const Text("Cash Date"),
                  cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy').format(item.cashDate)),
                  size: const RemainingColumnSize()
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
