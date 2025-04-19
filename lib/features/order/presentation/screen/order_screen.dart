import 'dart:developer';
import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/order/data/model/branch_order_model.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../../../core/common/drop_down_form_field.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/printer/printer_service.dart';
import '../../../../service_locator.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../home/data/model/delivery_payment_model.dart';
import '../../../home/data/model/dine_in_payment_model.dart';
import '../../../home/data/model/order_status_update_model.dart';
import '../../../home/data/model/pre_order_payment_model.dart';
import '../../data/model/order_filter_model.dart';
import '../../data/repositories/oreder_repository_impl.dart';
import '../widgets/cart_Item_view.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final tableController = PagedDataTableController<String, BranchOrder>();
  List<String> paymentMode = ["Cash", "Bkash", "Nagad"];
  List<String> paymentStatus = ["Done", "Pending"];
  List<String> orderTypes = ["Dine In", "Take Away", "Delivery", "Pre Order"];

  @override
  void initState() {
    super.initState();
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
      child: PagedDataTable<String, BranchOrder>(
        controller: tableController,
        initialPageSize: 20,
        fixedColumnCount: 3,
        configuration: const PagedDataTableConfiguration(),
        pageSizes: const [20, 30, 40, 50],
        fetcher: (pageSize, sortModel, filterModel, pageToken) async {
          final authLoadedState = context
              .read<AuthBloc>()
              .state as Authenticated;
          dynamic orderDateFrom = filterModel["orderDateRange"] != null
              ? (filterModel["orderDateRange"] as DateTimeRange).start
              .toIso8601String()
              : null;
          dynamic orderDateTo = filterModel["orderDateRange"] != null
              ? (filterModel["orderDateRange"] as DateTimeRange).end
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
            orderDateTo: orderDateTo,
            serialNumber: filterModel["serialNumber"],
            orderType: filterModel["orderType"],
          );

          OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
          final orderResult = await orderRepository.getAllOrder(orderFilter);

          return orderResult.fold(
                (failure) {
              ElegantNotification.error(
                title: const Text(
                    "Error", style: TextStyle(color: Colors.black)),
                description: Text(
                    failure.message, style: TextStyle(color: Colors.black),
                    maxLines: 1),
                width: 300,
                height: 100,
              ).show(context);

              return (List<BranchOrder>.empty(), null);
            },
                (orderResponse) =>
            (orderResponse.orders, orderResponse.nextPageToken),
          );
        },
        filters: [
          DropdownTableFilter<String>(
            items: orderTypes.map((e) =>
                DropdownMenuItem(value: e, child: Text(e, style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,))).toList(growable: false),
            chipFormatter: (value) => 'Order Type is ${value.toLowerCase()}',
            id: "orderType",
            name: "OrderType",
            decoration: InputDecoration(
              hintText: "Select OrderType",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Order Type",
            ),
          ),
          TextTableFilter(
            id: "invoiceNumber",
            chipFormatter: (value) => 'Invoice has "$value"',
            name: "Invoice Number",
            decoration: InputDecoration(
              hintText: "Type invoice number",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Invoice Number",
            ),
          ),
          TextTableFilter(
            id: "serialNumber",
            chipFormatter: (value) => 'Token has "$value"',
            name: "Token Number",
            decoration: InputDecoration(
              hintText: "Type token number",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Token Number",
            ),
          ),
          TextTableFilter(
            id: "customerPhoneNumber",
            chipFormatter: (value) => 'Phone Number has "$value"',
            name: "Phone Number",
            decoration: InputDecoration(
              hintText: "Type phone number",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Phone Number",
            ),
          ),
          DateTimePickerTableFilter(
            id: "orderDate",
            name: "Order Date",
            chipFormatter: (date) => "Date is ${DateFormat('dd/MM/yyyy').format(
                date)}",
            initialValue: null,
            firstDate: DateTime.now().subtract(const Duration(days: 1825)),
            lastDate: DateTime.now(),
            dateFormat: DateFormat('dd/MM/yyyy'),
            inputDecoration: InputDecoration(
              hintText: "Select order date",
              border: const OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Order Date",
            ),
          ),
          DropdownTableFilter<String>(
            items: paymentMode.map((e) =>
                DropdownMenuItem(value: e, child: Text(e, style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,))).toList(growable: false),
            chipFormatter: (value) => 'Payment Mode is ${value.toLowerCase()}',
            id: "paymentMode",
            name: "Payment Mode",
            decoration: InputDecoration(
              hintText: "Select payment mode",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Payment Mode",
            ),
          ),
          DropdownTableFilter<String>(
            items: paymentStatus.map((e) =>
                DropdownMenuItem(value: e, child: Text(e, style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,))).toList(growable: false),
            chipFormatter: (value) =>
            'Payment Status is ${value.toLowerCase()}',
            id: "paymentStatus",
            name: "Payment Status",
            decoration: InputDecoration(
              hintText: "Select payment status",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Payment Status",
            ),
          ),
          DateRangePickerTableFilter(
            id: "orderDateRange",
            name: "Order Date Range",
            chipFormatter: (date) => "Order date range is $date",
            initialValue: null,
            firstDate: DateTime.now().subtract(const Duration(days: 1825)),
            lastDate: DateTime.now(),
            enabled: true,
            formatter: (range) => "${(DateFormat('dd/MM/yyyy')).format(
                range.start)} - ${DateFormat('dd/MM/yyyy').format(range.end)}",
            inputDecoration: InputDecoration(
              hintText: "Select order date range",
              border: OutlineInputBorder(),
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              labelText: "Order Date Range",
            ),
          ),
        ],
        filterBarChild: PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
        child: const Text("Merge Row"),
        onTap: () {
          debugPrint(tableController.selectedRows.toString());
          debugPrint(tableController.selectedItems.toString());
        },
      )]),
        columns: [
          RowSelectorColumn(),
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
            cellBuilder: (context, item, index) => Text(
                DateFormat('dd-MM-yyyy').format(
                    DateTime.parse(item.orderDate))),
            size: const FixedColumnSize(120),
          ),
          TableColumn(
            title: const Text("SubTotal"),
            cellBuilder: (context, item, index) =>
                Text("${item.subtotalAmount} Tk"),
            size: FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Discount"),
            cellBuilder: (context, item, index) =>
                Text("${item.discountAmount} Tk"),
            size: const FixedColumnSize(100),
          ),

          TableColumn(
            title: const Text("Net Payable"),
            cellBuilder: (context, item, index) =>
                Text("${item.netPayableAmount} Tk"),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Paid"),
            cellBuilder: (context, item, index) =>
                Text("${item.paidAmount} Tk"),
            size: FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Change Amount"),
            cellBuilder: (context, item, index) =>
                Text("${item.changeAmount} Tk", style:
                TextStyle(
                    color: item.changeAmount < 0
                        ? Colors.red
                        : Colors.white
                ),),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Payment Status"),
            cellBuilder: (context, item, index) =>
                Text(item.paymentStatus, style: TextStyle(
                    color: item.paymentStatus == "Pending"
                        ? Colors.red
                        : Colors.white),),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Order Type"),
            cellBuilder: (context, item, index) => Text(item.orderType),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Order Status"),
            cellBuilder: (context, item, index) =>
                Text(item.orderStatus,
                  style: TextStyle(
                      color: item.orderStatus == "Pending"
                          ? Colors.red
                          : Colors.white),),
            size: const FixedColumnSize(100),
            onTap: (item, index) {
              if (item.orderStatus == "Pending") {
                showDialog(context: context, builder: (context) {
                  bool isLoading = false;
                  String orderStatusSelectValue = item.orderStatus;
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AlertDialog(
                      title: const Center(child: Text(
                        "Order Status", style: TextStyle(
                          color: ColorConstants.primaryColor
                      ),),),
                      content: StatefulBuilder(builder: (context, setState) {
                        return isLoading == true ? const Center(
                          child: CircularProgressIndicator(),)
                            :
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CDropdownFormField(
                              items: ["Pending", "Done"].map((e) =>
                                  DropdownMenuItem(
                                      value: e, child: Text(e, style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,))).toList(growable: false),
                              value: orderStatusSelectValue,
                              onChanged: (dynamic value) {
                                setState(() {
                                  orderStatusSelectValue = value.toString();
                                });
                              },
                              label: "Order Status",
                            ),

                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                    onPressed: () async {
                                      final orderStatusUpdateModel = OrderStatusUpdateModel(
                                        orderStatus: orderStatusSelectValue,
                                        id: item.id!,
                                      );
                                      setState(() {
                                        isLoading = true;
                                      });
                                      OrderRepositoryImpl orderRepository = instance<
                                          OrderRepositoryImpl>();
                                      final orderResult = await orderRepository
                                          .updatePendingOrderOnline(
                                          orderStatusUpdateModel);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      orderResult.fold(
                                              (failure) {
                                            ElegantNotification.error(
                                              title: const Text("Error",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              description: const Text(
                                                  "Something went wrong",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  maxLines: 1),
                                              width: 300,
                                              height: 100,
                                            ).show(context);
                                          }, (orderModel) {
                                        ElegantNotification.success(
                                          title: const Text("Success",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          description: const Text(
                                              "Order Status Updated",
                                              style: TextStyle(
                                                  color: Colors.black),
                                              maxLines: 1),
                                          width: 300,
                                          height: 100,
                                        ).show(context);
                                        tableController.refresh();
                                        Navigator.pop(context);
                                      }

                                      );
                                    },
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                          color:
                                          ColorConstants.primaryColor,
                                          fontSize: 16),
                                    )
                                )


                              ],
                            )
                          ],

                        );
                      },
                      ),

                    ),
                  );
                });
              }
            },
          ),
          TableColumnIconButton(
              title: const Text("Cart Item"),
              size: const FixedColumnSize(100),
              onPressed: (item, index) async {
                await showDialog(context: context, builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AlertDialog(
                      title: const Center(child: Text("Cart Items")),
                      titleTextStyle: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                      content: SizedBox(
                        width: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: item.cartItems.length,
                          itemBuilder: (context, index) {
                            final singleItem = CartItem.fromCart(
                                item.cartItems[index]);
                            //  here i want to convert Cart To Cart Item

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0),
                              child: CartItemViewIsar(
                                cartItem: singleItem,
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text("Close"))
                      ],
                    ),
                  );
                },

                    barrierDismissible: true);
              },
              icon: Icons.remove_red_eye,
              iconColor: ColorConstants.primaryColor,
              iconSize: 18
          ),
          TableColumnIconButton(
              title: const Text("Action"),
              size: const FixedColumnSize(100),
              onPressed: (item, index) async {
                if (item.orderType == "Dine In" &&
                    item.paymentStatus == "Pending") {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      String paymentModeSelectValue = "Cash";
                      TextEditingController _customerNumberController = TextEditingController();
                      TextEditingController _discountAmountController = TextEditingController();
                      TextEditingController _paidAmountController = TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      int netPayable = item.netPayableAmount;
                      bool isLoading = false;

                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                  color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(builder: (context,
                              setState) {
                            _discountAmountController.addListener(() {
                              setState(() {
                                if (_discountAmountController.text.isEmpty) {
                                  netPayable = item.netPayableAmount;
                                } else {
                                  netPayable = item.netPayableAmount -
                                      int.tryParse(
                                          _discountAmountController.text)!;
                                }
                                if (_paidAmountController.text.isNotEmpty) {
                                  changeAmount = int.tryParse(
                                      _paidAmountController.text)! - netPayable;
                                }
                              });
                            });
                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(
                                      _paidAmountController.text)! - netPayable;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child: isLoading == true ? const Center(
                                  child: CircularProgressIndicator(),) : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Net payable :"),
                                        Text("${item.netPayableAmount} Tk"),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: CDropdownFormField(
                                            items: paymentMode
                                                .map((e) =>
                                                DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: Theme
                                                        .of(context)
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
                                            controller: _customerNumberController,
                                            style: Theme
                                                .of(context)
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
                                              labelStyle: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              TextField(
                                                maxLines: 1,
                                                controller: _discountAmountController,
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                keyboardType: TextInputType
                                                    .number,
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
                                                  labelStyle: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text("Total Discount: ${item
                                                  .discountAmount +
                                                  (_discountAmountController
                                                      .text.isEmpty ? 0 : int
                                                      .tryParse(
                                                      _discountAmountController
                                                          .text)!)} Tk",
                                                style: TextStyle(
                                                    fontSize: 12),),
                                            ],
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
                                            style: Theme
                                                .of(context)
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
                                              labelStyle: Theme
                                                  .of(context)
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
                                                            color: Colors
                                                                .black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final dineInPaymentModelOnline = DineInPaymentModelOnline(
                                                    paymentStatus: "Done",
                                                    paymentMode: paymentModeSelectValue,
                                                    customerPhoneNumber: _customerNumberController
                                                        .text.isEmpty
                                                        ? ""
                                                        : _customerNumberController
                                                        .text,
                                                    discountAmount: _discountAmountController
                                                        .text.isEmpty ? item
                                                        .discountAmount : int
                                                        .tryParse(
                                                        _discountAmountController
                                                            .text)! +
                                                        item.discountAmount,
                                                    paidAmount: int.tryParse(
                                                        _paidAmountController
                                                            .text)!,
                                                    netPayableAmount: item
                                                        .netPayableAmount -
                                                        (_discountAmountController
                                                            .text.isEmpty
                                                            ? 0
                                                            : int.tryParse(
                                                            _discountAmountController
                                                                .text)!),
                                                    changeAmount: changeAmount!,
                                                    id: item.id!,
                                                  );
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  OrderRepositoryImpl orderRepository = instance<
                                                      OrderRepositoryImpl>();
                                                  final orderResult = await orderRepository
                                                      .updatePendingOrderOnline(
                                                      dineInPaymentModelOnline);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  orderResult.fold(
                                                          (failure) {
                                                        ElegantNotification
                                                            .error(
                                                          title: const Text(
                                                              "Error",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          description: const Text(
                                                              "Something went wrong",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                      }, (orderModel) async {
                                                    ElegantNotification.success(
                                                      title: const Text(
                                                          "Success",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      description: const Text(
                                                          "Payment Successful",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                          maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                    final printingService = instance<
                                                        PrintingService>();
                                                    await printingService
                                                        .printOrder(orderModel);
                                                    tableController.refresh();
                                                    Navigator.pop(context);
                                                  }

                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              "Pay",
                                              style: TextStyle(
                                                  color:
                                                  ColorConstants.primaryColor,
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
                }
                else if (item.orderType == "Delivery" &&
                    item.paymentStatus == "Pending") {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      String paymentModeSelectValue = "Cash";
                      TextEditingController _paidAmountController = TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      bool isLoading = false;

                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                  color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(builder: (context,
                              setState) {
                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(
                                      _paidAmountController.text)! -
                                      item.netPayableAmount;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child: isLoading == true ? const Center(
                                  child: CircularProgressIndicator(),) : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Net Payable :"),
                                        Text("${item.netPayableAmount} Tk"),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: CDropdownFormField(
                                            items: paymentMode
                                                .map((e) =>
                                                DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: Theme
                                                        .of(context)
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
                                            style: Theme
                                                .of(context)
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
                                              labelStyle: Theme
                                                  .of(context)
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
                                                            color: Colors
                                                                .black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final deliveryPaymentModelOnline = DeliveryPaymentModelOnline(
                                                    paymentStatus: "Done",
                                                    paymentMode: paymentModeSelectValue,
                                                    paidAmount: int.tryParse(
                                                        _paidAmountController
                                                            .text)!,
                                                    changeAmount: changeAmount!,
                                                    id: item.id!,
                                                  );
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  OrderRepositoryImpl orderRepository = instance<
                                                      OrderRepositoryImpl>();
                                                  final orderResult = await orderRepository
                                                      .updatePendingOrderOnline(
                                                      deliveryPaymentModelOnline);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                  orderResult.fold(
                                                          (failure) {
                                                        ElegantNotification
                                                            .error(
                                                          title: const Text(
                                                              "Error",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          description: const Text(
                                                              "Something went wrong",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                      }, (orderModel) async {
                                                    final printingService = instance<
                                                        PrintingService>();
                                                    ElegantNotification.success(
                                                      title: const Text(
                                                          "Success",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      description: const Text(
                                                          "Payment Successful",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                          maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                    tableController.refresh();
                                                    Navigator.pop(context);
                                                  }

                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              "Pay",
                                              style: TextStyle(
                                                  color:
                                                  ColorConstants.primaryColor,
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
                }
                else if (item.orderType == "Pre Order" &&
                    item.paymentStatus == "Pending") {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      String paymentModeSelectValue = item.paymentMode;
                      TextEditingController _discountAmountController = TextEditingController();
                      TextEditingController _paidAmountController = TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      int dueAmount = item.changeAmount.abs();
                      bool isLoading = false;

                      int discountAmount = 0;
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                  color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(
                              builder: (context, setState) {
                                _discountAmountController.addListener(() {
                                  setState(() {
                                    if (_discountAmountController.text
                                        .isEmpty) {
                                      dueAmount = item.changeAmount.abs();
                                    } else {
                                      dueAmount = item.changeAmount.abs() -
                                          int.tryParse(
                                              _discountAmountController.text)!;
                                    }
                                    if (_paidAmountController.text.isNotEmpty) {
                                      changeAmount = int.tryParse(
                                          _paidAmountController.text)! -
                                          dueAmount;
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
                                          dueAmount;
                                    }
                                  });
                                });
                                return SizedBox(
                                  width: 400,
                                  child: Form(
                                    key: _formKey,
                                    child: isLoading == true
                                        ? const Center(
                                      child: CircularProgressIndicator(),)
                                        : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Due Amount :"),
                                            Text("${dueAmount} Tk"),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        CDropdownFormField(
                                          items: paymentMode
                                              .map((e) =>
                                              DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: Theme
                                                      .of(context)
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
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                maxLines: 1,
                                                controller: _discountAmountController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    discountAmount = int
                                                        .tryParse(value) ?? 0;
                                                  });
                                                },
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                keyboardType: TextInputType
                                                    .number,
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
                                                  labelStyle: Theme
                                                      .of(context)
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
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                keyboardType: TextInputType
                                                    .number,
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
                                                  labelStyle: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text("Total Discount: ${item
                                            .discountAmount +
                                            (_discountAmountController.text
                                                .isEmpty ? 0 : int.tryParse(
                                                _discountAmountController
                                                    .text)!)} Tk",
                                          style: TextStyle(fontSize: 12),),

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
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel")),
                                            const SizedBox(width: 20,),
                                            TextButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (changeAmount! < 0) {
                                                      ElegantNotification.error(
                                                        title: const Text(
                                                            "Error",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        description: const Text(
                                                            "Insufficient Amount",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            maxLines: 1),
                                                        width: 300,
                                                        height: 100,
                                                      ).show(context);
                                                    } else {
                                                      final preOrderPaymentModelOnline = PreOrderPaymentModelOnline(
                                                        paymentStatus: "Done",
                                                        paymentMode: paymentModeSelectValue,
                                                        discountAmount: item
                                                            .discountAmount +
                                                            (_discountAmountController
                                                                .text.isEmpty
                                                                ? 0
                                                                : int.tryParse(
                                                                _discountAmountController
                                                                    .text)!),
                                                        paidAmount: item
                                                            .paidAmount + int
                                                            .tryParse(
                                                            _paidAmountController
                                                                .text)!,
                                                        netPayableAmount: item
                                                            .netPayableAmount -
                                                            (_discountAmountController
                                                                .text.isEmpty
                                                                ? 0
                                                                : int.tryParse(
                                                                _discountAmountController
                                                                    .text)!),
                                                        changeAmount: changeAmount!,
                                                        id: item.id!,
                                                      );
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      OrderRepositoryImpl orderRepository = instance<
                                                          OrderRepositoryImpl>();
                                                      final orderResult = await orderRepository
                                                          .updatePendingOrderOnline(
                                                          preOrderPaymentModelOnline);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      orderResult.fold(
                                                              (failure) {
                                                            ElegantNotification
                                                                .error(
                                                              title: const Text(
                                                                  "Error",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                              description: const Text(
                                                                  "Something went wrong",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  maxLines: 1),
                                                              width: 300,
                                                              height: 100,
                                                            ).show(context);
                                                          }, (
                                                          orderModel) async {
                                                        ElegantNotification
                                                            .success(
                                                          title: const Text(
                                                              "Success",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          description: const Text(
                                                              "Payment Successful",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                        final printingService = instance<
                                                            PrintingService>();
                                                        await printingService
                                                            .printOrder(
                                                            orderModel);
                                                        tableController
                                                            .refresh();
                                                        Navigator.pop(context);
                                                      }

                                                      );
                                                    }
                                                  }
                                                },
                                                child: const Text(
                                                  "Pay",
                                                  style: TextStyle(
                                                      color:
                                                      ColorConstants
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
                }
                else {
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
              iconSize: 18
          ),
          TableColumnIconButton(
            title: const Text("Print"),
            size: const FixedColumnSize(100),
            icon: Icons.print,
            iconColor: ColorConstants.primaryColor,
            iconSize: 18,
            onPressed: (item, index)async {
              showDialog(context: context,
                builder: (context) {

                  return AlertDialog(
                    title: const Text("Print Receipt"),
                    content: const Text(
                        "Are you sure you want to print receipt?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          final printingService = instance<PrintingService>();
                          final orderModel = OrderModel(
                              cartItems:  item.cartItems.map((e) {
                                return CartItem(productName: e.productName, unitPrice: e.unitPrice, productID: e.productID, quantity: e.quantity);
                              },).toList(),
                              subtotalAmount:  item.subtotalAmount,
                              paidAmount: item.paidAmount,
                              changeAmount: item.changeAmount,
                              orderDate:  item.orderDate,
                              discountAmount:  item.discountAmount,
                              customerPhoneNumber:  item.customerPhoneNumber,
                              netPayableAmount:  item.netPayableAmount,
                              tableNumber:  item.tableNumber,
                              orderType:  item.orderType,
                              branchId:  item.branchId,
                              branchName: item.branchName,
                              managerId: item.managerId,
                              managerName: item.managerName,
                              branchPhoneNumber: item.branchPhoneNumber,
                              branchAddress: item.branchAddress,
                              paymentMode: item.paymentMode,
                              paymentStatus:  item.paymentStatus,
                              invoiceNumber: item.branchPhoneNumber,
                              branchBinNumber: item.branchBinNumber,
                              serialNumber:  item.serialNumber,
                              deliveryAddress:  item.deliveryAddress,
                              customerName: item.customerName,
                              deliveryDateAndTime: item. deliveryDateAndTime,
                              note:  item.note,
                              orderStatus:  item.orderStatus,
                              deliveryFee: item.deliveryFee,
                              deliveryBoyName: item.deliveryBoyName,
                              isOnlyPrint: true
                          );
                          printingService.printOrder(orderModel);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
             
            },
          ),
          TableColumn(
            title: const Text("Payment Mode"),
            cellBuilder: (context, item, index) => Text(item.paymentMode),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Table"),
            cellBuilder: (context, item, index) => Text(item.tableNumber),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Token"),
            cellBuilder: (context, item, index) => Text(item.serialNumber),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Deliver Time"),
            cellBuilder: (context, item, index) =>
                Text(item.deliveryDateAndTime),
            size: const FixedColumnSize(200),
          ),
          TableColumn(
            title: const Text("Delivery Fee"),
            cellBuilder: (context, item, index) =>
                Text("${item.deliveryFee} Tk"),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Deliver Address"),
            cellBuilder: (context, item, index) => Text(
              item.deliveryAddress, maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            size: const FixedColumnSize(250),
            format: const AlignColumnFormat(alignment: Alignment.center),

            onTap: (item, index) {
              showDialog(context: context, builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AlertDialog(
                    title: const Center(child: Text("Delivery Address")),
                    content: Text(item.deliveryAddress),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text("Close"))
                    ],
                  ),
                );
              });
            },
          ),
          TableColumn(
            title: const Text("Deliver Boy"),
            cellBuilder: (context, item, index) => Text(
              item.deliveryBoyName, maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            size: const FixedColumnSize(150),
            format: const AlignColumnFormat(alignment: Alignment.center),
          ),
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
            title: const Text("Customer Name"),
            cellBuilder: (context, item, index) => Text(
              item.customerName, maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            size: const FixedColumnSize(200),
          ),
          TableColumn(
            title: const Text("Note"),
            cellBuilder: (context, item, index) =>
                Text(item.note, maxLines: 1, overflow: TextOverflow.ellipsis,),
            size: const FixedColumnSize(150),
            onTap: (item, index) {
              showDialog(context: context, builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AlertDialog(
                    title: const Center(child: Text("Note")),
                    content: Text(item.note),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text("Close"))
                    ],
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
