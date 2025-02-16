import 'dart:ui';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/core/constants/color_constants.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/dine_in_payment_model.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../../../core/common/drop_down_form_field.dart';
import '../../../../core/printer/printer_service.dart';
import '../../../../service_locator.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../data/model/order_filter_model.dart';
import '../../data/repositories/oreder_repository_impl.dart';
import '../widgets/cart_Item_view.dart';

class UnSyncedOrderScreen extends StatefulWidget {
  const UnSyncedOrderScreen({super.key});

  @override
  State<UnSyncedOrderScreen> createState() => _UnSyncedOrderScreenState();
}

class _UnSyncedOrderScreenState extends State<UnSyncedOrderScreen> with SingleTickerProviderStateMixin {
  List<String> paymentStatus = ["Done", "Pending"];
  final tableController = PagedDataTableController<String, OrderModel>();
  List<String> paymentMode = ["Cash", "Bkash", "Nagad"];
  bool syncButtonLoadingState = false;
  late AnimationController _controller;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PagedDataTableTheme(
      data: PagedDataTableThemeData(
        selectedRow: Colors.grey[700],
        rowColor: (index) => index.isEven ? Colors.grey[900] : Colors.grey[850],
        backgroundColor: Colors.black,
        headerTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        cellTextStyle: const TextStyle(color: Colors.white),
        footerTextStyle: const TextStyle(color: Colors.white),
        horizontalScrollbarVisibility: true,
        verticalScrollbarVisibility: true,
        cellPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      ),
      child: PagedDataTable<String, OrderModel>(
        controller: tableController,
        initialPageSize: 20,
        fixedColumnCount: 3,
        configuration: const PagedDataTableConfiguration(),
        pageSizes: const [20, 30, 40, 50],
        fetcher: (pageSize, sortModel, filterModel, pageToken) async {
          final authLoadedState =
              context.read<AuthBloc>().state as Authenticated;
          dynamic orderDateFrom = filterModel["orderDateRange"] != null
              ? (filterModel["orderDateRange"] as DateTimeRange)
                  .start
                  .toIso8601String()
              : null;
          dynamic orderDateTo = filterModel["orderDateRange"] != null
              ? (filterModel["orderDateRange"] as DateTimeRange)
                  .end
                  .toIso8601String()
              : null;
          OrderFilter orderFilter = OrderFilter(
              branchId: authLoadedState.user.branchId,
              pageLimit: pageSize.toString(),
              paymentStatus: filterModel["paymentStatus"],
              paymentMode: filterModel["paymentMode"],
              orderDate: filterModel["orderDate"] != null
                  ? (filterModel["orderDate"] as DateTime).toIso8601String()
                  : null,
              invoiceNumber: filterModel["invoiceNumber"],
              customerPhoneNumber: filterModel["customerPhoneNumber"],
              pageToken: pageToken,
              orderDateFrom: orderDateFrom,
              orderDateTo: orderDateTo);
          OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
          final orderResult =
              await orderRepository.getAllUnsyncOrder(orderFilter);
          return orderResult.fold(
            (failure) {
              ElegantNotification.error(
                title:
                    const Text("Error", style: TextStyle(color: Colors.black)),
                description: const Text("Something went wrong",
                    style: TextStyle(color: Colors.black), maxLines: 1),
                width: 300,
                height: 100,
              ).show(context);

              return (List<OrderModel>.empty(), null);
            },
            (orderResponse) {
              return (orderResponse.orders, orderResponse.nextPageToken);
            },
          );
        },
        filters: [
          TextTableFilter(
            id: "invoiceNumber",
            chipFormatter: (value) => 'Invoice has "$value"',
            name: "Invoice Number",
            decoration: InputDecoration(
              hintText: "Type invoice number",
              border: OutlineInputBorder(),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelText: "Invoice Number",
            ),
          ),
          // TextTableFilter(
          //   id: "customerPhoneNumber",
          //   chipFormatter: (value) => 'Phone Number has "$value"',
          //   name: "Phone Number",
          //   decoration:  InputDecoration(
          //     hintText: "Type phone number",
          //     border: OutlineInputBorder(),
          //     hintStyle: Theme.of(context).textTheme.bodyMedium,
          //     labelText: "Phone Number",
          //   ),
          // ),
          // DateTimePickerTableFilter(
          //   id: "orderDate",
          //   name: "Order Date",
          //   chipFormatter: (date) => "Date is ${DateFormat('dd/MM/yyyy').format(date)}",
          //   initialValue: null,
          //   firstDate: DateTime.now().subtract(const Duration(days: 1825)),
          //   lastDate: DateTime.now(),
          //   dateFormat: DateFormat('dd/MM/yyyy'),
          //   inputDecoration:  InputDecoration(
          //     hintText: "Select order date",
          //     border: const OutlineInputBorder(),
          //     hintStyle: Theme.of(context).textTheme.bodyMedium,
          //     labelText: "Order Date",
          //   ),
          // ),
          // DropdownTableFilter<String>(
          //   items: paymentMode.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(growable: false),
          //   chipFormatter: (value) =>
          //   'Payment Mode is ${value.toLowerCase()}',
          //   id: "paymentMode",
          //   name: "Payment Mode",
          //   decoration:  InputDecoration(
          //     hintText: "Select payment mode",
          //     border: OutlineInputBorder(),
          //     hintStyle:  Theme.of(context).textTheme.bodyMedium,
          //     labelText: "Payment Mode",
          //   ),
          // ),
          DropdownTableFilter<String>(
            items: paymentStatus
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )))
                .toList(growable: false),
            chipFormatter: (value) => 'Payment Status is $value',
            id: "paymentStatus",
            name: "Payment Status",
            decoration: InputDecoration(
              hintText: "Select payment status",
              border: const OutlineInputBorder(),
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              labelText: "Payment Status",
            ),
          ),
          // DateRangePickerTableFilter(
          //   id: "orderDateRange",
          //   name: "Order Date Range",
          //   chipFormatter: (date) => "Order date range is $date",
          //   initialValue: null,
          //   firstDate: DateTime.now().subtract(const Duration(days:1825 )),
          //   lastDate: DateTime.now(),
          //   enabled: true,
          //   formatter: (range) => "${(DateFormat('dd/MM/yyyy')).format(range.start)} - ${DateFormat('dd/MM/yyyy').format(range.end)}",
          //   inputDecoration:  InputDecoration(
          //     hintText: "Select order date range",
          //     border: OutlineInputBorder(),
          //     hintStyle: Theme.of(context).textTheme.bodyMedium,
          //     labelText: "Order Date Range",
          //   ),
          // ),
        ],
        columns: [
          // RowSelectorColumn(),
          TableColumn(
            title: const Text("Invoice"),
            cellBuilder: (context, item, index) => Text(item.invoiceNumber),
            size: const FixedColumnSize(120),
            onTap: (item, index) {
              Clipboard.setData(ClipboardData(text: item.invoiceNumber));
            },
          ),
          TableColumn(
            title: const Text("Order Date"),
            cellBuilder: (context, item, index) => Text(DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(item.orderDate))),
            size: const FixedColumnSize(120),
          ),
          TableColumn(
            title: const Text("SubTotal"),
            cellBuilder: (context, item, index) =>
                Text("${item.subtotalAmount} Tk"),
            size: FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Paid"),
            cellBuilder: (context, item, index) =>
                Text("${item.paidAmount} Tk"),
            size: FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Discount"),
            cellBuilder: (context, item, index) =>
                Text("${item.discountAmount} Tk"),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Change Amount"),
            cellBuilder: (context, item, index) =>
                Text("${item.changeAmount} Tk"),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Payment Mode"),
            cellBuilder: (context, item, index) => Text(item.paymentMode),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Payment Status"),
            cellBuilder: (context, item, index) => Text(
              item.paymentStatus,
              style: TextStyle(
                  color: item.paymentStatus == "Pending"
                      ? Colors.red
                      : Colors.white),
            ),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text(
              "Table Number",
              style: TextStyle(),
            ),
            cellBuilder: (context, item, index) => Text(item.tableNumber),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text(
              "Order Type",
              style: TextStyle(),
            ),
            cellBuilder: (context, item, index) => Text(item.orderType),
            size: const FixedColumnSize(100),
          ),
          TableColumnIconButton(
              title: const Text("Cart Item"),
              size: const FixedColumnSize(100),
              onPressed: (item, index) async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Center(child: Text("Cart Items")),
                        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                        content: Container(
                          width: 350,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.cartItems.length,
                            itemBuilder: (context, index) {
                              final singleItem = item.cartItems[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: CartItemViewIsar(
                                  cartItem: singleItem,
                                ),
                              );
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Close"))
                        ],
                      );
                    },
                    barrierDismissible: true);
              },
              icon: Icons.remove_red_eye,
              iconColor: ColorConstants.primaryColor,
              iconSize: 18),
          TableColumnIconButton(
              title: const Text("Action"),
              size: const FixedColumnSize(100),
              onPressed: (item, index) async {
                if (item.paymentStatus == "Pending") {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      String paymentModeSelectValue = "Cash";
                      TextEditingController _customerNumberController =
                          TextEditingController();
                      TextEditingController _discountAmountController =
                          TextEditingController();
                      TextEditingController _paidAmountController =
                          TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      int subtotal = item.subtotalAmount;

                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style:
                                  TextStyle(color: ColorConstants.primaryColor),
                            ),
                          ),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            _discountAmountController.addListener(() {
                              setState(() {
                                if (_discountAmountController.text.isEmpty) {
                                  subtotal = item.subtotalAmount;
                                } else {
                                  subtotal = item.subtotalAmount -
                                      int.tryParse(
                                          _discountAmountController.text)!;
                                }
                                if (_paidAmountController.text.isNotEmpty) {
                                  changeAmount = int.tryParse(
                                          _paidAmountController.text)! -
                                      subtotal;
                                }
                              });
                            });

                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(
                                          _paidAmountController.text)! -
                                      subtotal;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("SubTotal :"),
                                        Text("${item.subtotalAmount} Tk"),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: CDropdownFormField(
                                            items: paymentMode
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ))
                                                .toList(),
                                            value: paymentModeSelectValue,
                                            onChanged: (dynamic value) {
                                              setState(() {
                                                paymentModeSelectValue =
                                                    value.toString();
                                              });
                                            },
                                            label: "Payment Mode",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            maxLines: 1,
                                            controller:
                                                _customerNumberController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelText: "Customer Number",
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            maxLines: 1,
                                            controller:
                                                _discountAmountController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelText: "Discount Amount",
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            maxLines: 1,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter paid amount";
                                              }
                                              return null;
                                            },
                                            controller: _paidAmountController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: ColorConstants
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelText: "Paid Amount",
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Change Amount :"),
                                        Text("${changeAmount ?? 0} Tk"),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel")),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (changeAmount! < 0) {
                                                  ElegantNotification.error(
                                                    title: const Text("Error",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final dineInPaymentModel =
                                                      DineInPaymentModel(
                                                    paymentStatus: "Done",
                                                    paymentMode:
                                                        paymentModeSelectValue,
                                                    customerPhoneNumber:
                                                        _customerNumberController
                                                                .text.isEmpty
                                                            ? ""
                                                            : _customerNumberController
                                                                .text,
                                                    discountAmount:
                                                        _discountAmountController
                                                                .text.isEmpty
                                                            ? 0
                                                            : int.tryParse(
                                                                _discountAmountController
                                                                    .text)!,
                                                    paidAmount: int.tryParse(
                                                        _paidAmountController
                                                            .text)!,
                                                    netPayableAmount: item
                                                            .subtotalAmount -
                                                        (_discountAmountController
                                                                .text.isEmpty
                                                            ? 0
                                                            : int.tryParse(
                                                                _discountAmountController
                                                                    .text)!),
                                                    changeAmount: changeAmount!,
                                                    invoiceNumber:
                                                        item.invoiceNumber,
                                                  );
                                                  OrderRepositoryImpl
                                                      orderRepository =
                                                      instance<
                                                          OrderRepositoryImpl>();
                                                  final orderResult =
                                                      await orderRepository
                                                          .updateOrder(
                                                              dineInPaymentModel);
                                                  orderResult.fold((failure) {
                                                    ElegantNotification.error(
                                                      title: const Text("Error",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      description: const Text(
                                                          "Something went wrong",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                  }, (orderModel) async {
                                                    final printingService =
                                                        instance<
                                                            PrintingService>();
                                                    await printingService
                                                        .printOrder(orderModel);
                                                    ElegantNotification.success(
                                                      title: const Text(
                                                          "Success",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      description: const Text(
                                                          "Payment Successful",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                    tableController.refresh();
                                                    Navigator.pop(context);
                                                  });
                                                }
                                              }
                                            },
                                            child: const Text(
                                              "Pay",
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 16),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
                } else {
                  ElegantNotification.error(
                    title: const Text("Error",
                        style: TextStyle(color: Colors.black)),
                    description: const Text("This order is Complete",
                        style: TextStyle(color: Colors.black), maxLines: 1),
                    width: 300,
                    height: 100,
                  ).show(context);
                }
              },
              icon: Icons.edit,
              iconColor: ColorConstants.primaryColor,
              iconSize: 18),
          TableColumn(
            title: const Text("Customer Number"),
            cellBuilder: (context, item, index) =>
                Text(item.customerPhoneNumber),
            size: const FixedColumnSize(150),
            onTap: (item, index) {
              Clipboard.setData(ClipboardData(text: item.customerPhoneNumber));
            },
          ),
          TableColumn(
            title: const Text("Deliver Address"),
            cellBuilder: (context, item, index) => Text(
              item.deliveryAddress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            size: const FixedColumnSize(250),
            format: const AlignColumnFormat(alignment: Alignment.centerRight),
            onTap: (item, index) {
              Clipboard.setData(ClipboardData(text: item.deliveryAddress));
            },
          ),
        ],
        filterBarChild: syncButtonLoadingState
            ? RotationTransition(
          turns: _controller,
          child: const Icon(Icons.sync, color: ColorConstants.primaryColor, size: 30),
        )  :IconButton(
          onPressed: () async {
            AuthRepositoryImpl authRepositoryImpl = instance<AuthRepositoryImpl>();
            setState(() {
              syncButtonLoadingState=true;
            });
            final result = await authRepositoryImpl.syncOrder();
            setState(() {
              syncButtonLoadingState=false;
            });
            result.fold(
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
              (message) {
                ElegantNotification.success(
                  title: const Text("Success",
                      style: TextStyle(color: Colors.black)),
                  description: Text(message,
                      style: TextStyle(color: Colors.black), maxLines: 1),
                  width: 300,
                  height: 100,
                ).show(context);
                tableController.refresh();
              },
            );
          },
          tooltip: "Sync Order",
          icon: const Icon(
              Icons.sync,
              color: ColorConstants.primaryColor, size: 30),
        ),
      ),
    );
  }
}
