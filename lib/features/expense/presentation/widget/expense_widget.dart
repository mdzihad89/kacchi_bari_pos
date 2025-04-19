
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../../../core/common/textform_field.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/printer/printer_service.dart';
import '../../../../service_locator.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../data/model/expense_dto.dart';
import '../../data/model/expense_filter.dart';
import '../../data/model/expense_model.dart';
import '../../data/model/expense_report_dto.dart';
import '../../data/repositories/expense_repo_impl.dart';

class ExpenseWidget extends StatefulWidget {
  const ExpenseWidget({super.key});

  @override
  State<ExpenseWidget> createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget> {
  TextEditingController expenseDescriptionController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final tableController = PagedDataTableController<String, ExpenseModel>();
  bool isLoading = false;

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
              Expanded(
                child: CTextFormField(
                  labelText: 'Enter Expense Description',
                  textEditingController: expenseDescriptionController,
                  validatorText: 'Please enter expense description',
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: CTextFormField(
                  labelText: 'Amount',
                  textEditingController: expenseAmountController,
                  validatorText: 'Enter expense amount',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
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
                      final expenseDto = ExpenseDto(
                          expenseAmount: expenseAmountController.text,
                          expenseDescription: expenseDescriptionController.text,
                          branchId: authLoadedState.user.branchId,
                          expenseDate: DateTime.now().toIso8601String());

                      ExpenseRepoImpl expenseRepository = instance<ExpenseRepoImpl>();
                      expenseRepository.addExpenses(expenseDto).then((value) {
                        value.fold(
                          (failure) {
                            setState(() {
                              isLoading = false;
                            });
                            ElegantNotification.error(
                              title: const Text("Error",
                                  style: TextStyle(color: Colors.black)),
                              description: Text(failure.message,
                                  style: TextStyle(color: Colors.black),
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
                                  "Expense added successfully",
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 1),
                              width: 300,
                              height: 100,
                            ).show(context);
                            tableController.insertAt(0, expenseModel);
                            expenseDescriptionController.clear();
                            expenseAmountController.clear();
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
                          'Add Expense',
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
            child: PagedDataTable<String, ExpenseModel>(
              controller: tableController,
              initialPageSize: 20,
              fixedColumnCount: 3,
              configuration: const PagedDataTableConfiguration(),
              pageSizes: const [20, 30, 40, 50],
              fetcher: (pageSize, sortModel, filterModel, pageToken) async {
                final authLoadedState =
                    context.read<AuthBloc>().state as Authenticated;
                dynamic expenseDateFrom =
                    filterModel["expenseDateRange"] != null
                        ? (filterModel["expenseDateRange"] as DateTimeRange)
                            .start
                            .toIso8601String()
                        : null;
                dynamic expenseDateTo = filterModel["expenseDateRange"] != null
                    ? (filterModel["expenseDateRange"] as DateTimeRange)
                        .end
                        .toIso8601String()
                    : null;
                dynamic expenseDate = filterModel["expenseDate"] != null
                    ? (filterModel["expenseDate"] as DateTime).toIso8601String()
                    : null;

                ExpenseFilter expenseFilter = ExpenseFilter(
                    branchId: authLoadedState.user.branchId,
                    expenseDate: expenseDate,
                    expenseDateFrom: expenseDateFrom,
                    expenseDateTo: expenseDateTo,
                    pageLimit: pageSize.toString(),
                    pageToken: pageToken);

                ExpenseRepoImpl expenseRepository = instance<ExpenseRepoImpl>();
                final expenseResult = await expenseRepository.getExpenses(expenseFilter);

                return expenseResult.fold(
                  (failure) {
                    ElegantNotification.error(
                      title: const Text("Error",
                          style: TextStyle(color: Colors.black)),
                      description: Text(failure.message,
                          style: TextStyle(color: Colors.black), maxLines: 1),
                      width: 300,
                      height: 100,
                    ).show(context);

                    return (List<ExpenseModel>.empty(), null);
                  },
                  (expenseResponse) =>
                      (expenseResponse.expenses, expenseResponse.nextPageToken),
                );
              },
              filterBarChild: IconButton(onPressed: ()async {
                ExpenseRepoImpl expenseRepository = instance<ExpenseRepoImpl>();
                final authLoadedState = context.read<AuthBloc>().state as Authenticated;
                final expenseReportDto = ExpenseReportDTO(
                  branchId: authLoadedState.user.branchId,
                 expenseDate: DateTime.now().toIso8601String(),
                  //expenseDate: "2025-03-09",
                );

                final expenseResult = await expenseRepository.getExpenseReport(expenseReportDto);
                expenseResult.fold(
                  (failure) {
                    ElegantNotification.error(
                      title: const Text("Error",
                          style: TextStyle(color: Colors.black)),
                      description: Text(failure.message,
                          style: const TextStyle(color: Colors.black), maxLines: 1),
                      width: 300,
                      height: 100,
                    ).show(context);
                  },
                  (expenseReport)async {
                    final printingService = instance<PrintingService>();
                    await  printingService.printExpenseReport(
                      expenses: expenseReport.expenses.reversed.toList(),
                      todaysCash: expenseReport.todaysCash,
                      previousDayCash: expenseReport.previousDayCash,
                      branchName:  authLoadedState.user.branchName,
                    );

                  },
                );

              }, icon: const Icon(Icons.print)),
              filters: [
                DateTimePickerTableFilter(
                  id: "expenseDate",
                  name: "Expense Date",
                  chipFormatter: (date) =>
                      "Date is ${DateFormat('dd/MM/yyyy').format(date)}",
                  initialValue: null,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 1825)),
                  lastDate: DateTime.now(),
                  dateFormat: DateFormat('dd/MM/yyyy'),
                  inputDecoration: InputDecoration(
                    hintText: "Select expense date",
                    border: const OutlineInputBorder(),
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    labelText: "Expense Date",
                  ),
                ),
                DateRangePickerTableFilter(
                  id: "expenseDateRange",
                  name: "Expense Date Range",
                  chipFormatter: (date) => "Expense date range is $date",
                  initialValue: null,
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 1825)),
                  lastDate: DateTime.now(),
                  enabled: true,
                  formatter: (range) =>
                      "${(DateFormat('dd/MM/yyyy')).format(range.start)} - ${DateFormat('dd/MM/yyyy').format(range.end)}",
                  inputDecoration: InputDecoration(
                    hintText: "Select expense date range",
                    border: const OutlineInputBorder(),
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    labelText: "Expense Date Range",
                  ),
                ),
              ],
              columns: [
                TableColumn(
                  title: const Text("Expense Date"),
                  cellBuilder: (context, item, index) => Text(
                      DateFormat('dd-MM-yyyy h:mm a')
                          .format(DateTime.parse(item.expenseDate))),
                  size: const FixedColumnSize(200),
                ),
                TableColumn(
                  title: const Text("Amount"),
                  cellBuilder: (context, item, index) =>
                      Text("${item.expenseAmount} Tk"),
                  size: const FixedColumnSize(120),
                ),
                TableColumn(
                  title: const Text("Expense Description"),
                  cellBuilder: (context, item, index) =>
                      Text(item.expenseDescription),
                  size: const RemainingColumnSize(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
