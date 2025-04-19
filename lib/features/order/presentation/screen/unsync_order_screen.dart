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
import '../../../home/data/model/delivery_payment_model.dart';
import '../../../home/data/model/order_status_update_model.dart';
import '../../../home/data/model/pre_order_payment_model.dart';
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
            title: const Text("Discount"),
            cellBuilder: (context, item, index) =>  Text("${item.discountAmount} Tk"),
            size: const FixedColumnSize(100),
          ),

          TableColumn(
            title: const Text("Net Payable"),
            cellBuilder: (context, item, index) =>  Text("${item.netPayableAmount} Tk"),
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
            cellBuilder: (context, item, index) =>  Text("${item.changeAmount} Tk",style:
            TextStyle(
                color: item.changeAmount < 0
                    ? Colors.red
                    : Colors.white
            ),),
            size: const FixedColumnSize(100),
          ),

          TableColumn(
            title: const Text("Payment Mode"),
            cellBuilder: (context, item, index) => Text(item.paymentMode),
            size: const FixedColumnSize(100),
          ),
          TableColumn(
            title: const Text("Payment Status"),
            cellBuilder: (context, item, index) => Text(item.paymentStatus, style: TextStyle(
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
            cellBuilder: (context, item, index) => Text(item.orderStatus ,
              style: TextStyle(
                  color: item.orderStatus == "Pending"
                      ? Colors.red
                      : Colors.white),),
            size: const FixedColumnSize(100),
            onTap: (item, index) {
              if(item.orderStatus=="Pending"){
                showDialog(context: context, builder: (context) {
                  bool isLoading=false;
                  String orderStatusSelectValue = item.orderStatus;
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AlertDialog(
                      title: const Center(child: Text("Order Status",style: TextStyle(
                          color: ColorConstants.primaryColor
                      ),),),
                      content: StatefulBuilder(builder: (context, setState) {

                        return   isLoading==true?const Center(child: CircularProgressIndicator(),)
                            :
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CDropdownFormField(items: ["Pending","Done"].map((e) => DropdownMenuItem(value: e, child: Text(e,style: Theme.of(context).textTheme.bodyMedium,))).toList(growable: false),
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
                                    onPressed: () async{
                                      final orderStatusUpdateModel = OrderStatusUpdateModelOffline(
                                        orderStatus: orderStatusSelectValue,
                                        invoiceNumber: item.invoiceNumber
                                      );
                                      setState(() {
                                        isLoading=true;
                                      });
                                      OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
                                      final orderResult = await orderRepository.updateOrder(orderStatusUpdateModel, "PreOrderStatus");
                                      setState(() {
                                        isLoading=false;
                                      });
                                      orderResult.fold(
                                              (failure) {
                                            ElegantNotification .error(
                                              title: const Text("Error", style: TextStyle(color: Colors.black)),
                                              description: const Text("Something went wrong", style: TextStyle(color: Colors.black), maxLines: 1),
                                              width: 300,
                                              height: 100,
                                            ).show(context);
                                          }, (orderModel) {
                                        ElegantNotification.success(
                                          title: const Text("Success", style: TextStyle(color: Colors.black)),
                                          description: const Text("Order Status Updated", style: TextStyle(color: Colors.black),maxLines: 1),
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

                if (item.orderType == "Dine In" &&item.paymentStatus == "Pending") {
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
                      bool isLoading=false;

                      return BackdropFilter(
                        filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(builder: (context, setState) {
                            _discountAmountController.addListener(() {
                              setState(() {
                                if (_discountAmountController.text.isEmpty) {
                                  netPayable = item.netPayableAmount;
                                } else {
                                  netPayable = item.netPayableAmount - int.tryParse(_discountAmountController.text)!;
                                }
                                if (_paidAmountController.text.isNotEmpty) {
                                  changeAmount = int.tryParse(_paidAmountController.text)! - netPayable;
                                }
                              });
                            });
                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(_paidAmountController.text)! - netPayable;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child:isLoading==true?const Center(child: CircularProgressIndicator(),): Column(
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
                                            controller: _customerNumberController,
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

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                maxLines: 1,
                                                controller: _discountAmountController,
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
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text("Total Discount: ${item.discountAmount+(_discountAmountController.text.isEmpty? 0:int.tryParse(_discountAmountController.text)!)} Tk", style: TextStyle(fontSize: 12),),
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
                                            onPressed: () async{
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (changeAmount! < 0) {
                                                  ElegantNotification.error(
                                                    title: const Text("Error",
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color: Colors.black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final dineInPaymentModelOnline = DineInPaymentModel(
                                                    paymentStatus: "Done",
                                                    paymentMode: paymentModeSelectValue,
                                                    customerPhoneNumber: _customerNumberController.text.isEmpty?"":_customerNumberController.text,
                                                    discountAmount: _discountAmountController.text.isEmpty? item.discountAmount:int.tryParse(_discountAmountController.text)!+item.discountAmount,
                                                    paidAmount: int.tryParse(_paidAmountController.text)!,
                                                    netPayableAmount:  item.netPayableAmount-(_discountAmountController.text.isEmpty?0:int.tryParse(_discountAmountController.text)!),
                                                    changeAmount:  changeAmount!,
                                                   invoiceNumber: item.invoiceNumber,
                                                  );
                                                  setState(() {
                                                    isLoading=true;
                                                  });
                                                  OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
                                                  final orderResult = await orderRepository.updateOrder(dineInPaymentModelOnline , "Dine In");
                                                  setState(() {
                                                    isLoading=false;
                                                  });
                                                  orderResult.fold(
                                                          (failure) {
                                                        ElegantNotification .error(
                                                          title: const Text("Error", style: TextStyle(color: Colors.black)),
                                                          description: const Text("Something went wrong", style: TextStyle(color: Colors.black), maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                      }, (orderModel) async{
                                                    ElegantNotification.success(
                                                      title: const Text("Success", style: TextStyle(color: Colors.black)),
                                                      description: const Text("Payment Successful", style: TextStyle(color: Colors.black),maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                    final printingService = instance<PrintingService>();
                                                    await printingService.printOrder(orderModel);
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
                else if( item.orderType == "Delivery" && item.paymentStatus == "Pending"){
                  await showDialog(
                    context: context,
                    builder: (context) {
                      String paymentModeSelectValue = "Cash";
                      TextEditingController _paidAmountController = TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      bool isLoading=false;

                      return BackdropFilter(
                        filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(builder: (context, setState) {
                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(_paidAmountController.text)! - item.netPayableAmount;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child:isLoading==true?const Center(child: CircularProgressIndicator(),): Column(
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
                                            onPressed: () async{
                                              if (_formKey.currentState!.validate()) {
                                                if (changeAmount! < 0) {
                                                  ElegantNotification.error(
                                                    title: const Text("Error",
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color: Colors.black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final deliveryPaymentModelOnline = DeliveryPaymentModel(
                                                    paymentStatus: "Done",
                                                    paymentMode: paymentModeSelectValue,
                                                    paidAmount: int.tryParse(_paidAmountController.text)!,
                                                    changeAmount:  changeAmount!,
                                                    invoiceNumber: item.invoiceNumber,

                                                  );
                                                  setState(() {
                                                    isLoading=true;
                                                  });
                                                  OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
                                                  final orderResult = await orderRepository.updateOrder(deliveryPaymentModelOnline  ,item.orderType );
                                                  setState(() {
                                                    isLoading=false;
                                                  });
                                                  orderResult.fold(
                                                          (failure) {
                                                        ElegantNotification .error(
                                                          title: const Text("Error", style: TextStyle(color: Colors.black)),
                                                          description: const Text("Something went wrong", style: TextStyle(color: Colors.black), maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                      }, (orderModel) async{
                                                    final printingService = instance<PrintingService>();
                                                    ElegantNotification.success(
                                                      title: const Text("Success", style: TextStyle(color: Colors.black)),
                                                      description: const Text("Payment Successful", style: TextStyle(color: Colors.black),maxLines: 1),
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

                else if( item.orderType == "Pre Order" && item.paymentStatus == "Pending")  {
                  await showDialog(
                    context: context,
                    builder: (context)  {
                      String paymentModeSelectValue = item.paymentMode;
                      TextEditingController _discountAmountController = TextEditingController();
                      TextEditingController _paidAmountController = TextEditingController();
                      int? changeAmount;
                      final _formKey = GlobalKey<FormState>();
                      int dueAmount = item.changeAmount.abs();
                      bool isLoading=false;

                      int discountAmount = 0;
                      return BackdropFilter(
                        filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: AlertDialog(
                          title: const Center(
                            child: Text(
                              "Payment",
                              style: TextStyle(color: ColorConstants.primaryColor),
                            ),
                          ),
                          content: StatefulBuilder(builder: (context, setState) {
                            _discountAmountController.addListener(() {
                              setState(() {
                                if (_discountAmountController.text.isEmpty) {
                                  dueAmount = item.changeAmount.abs();
                                } else {
                                  dueAmount = item.changeAmount.abs() - int.tryParse(_discountAmountController.text)!;
                                }
                                if (_paidAmountController.text.isNotEmpty) {
                                  changeAmount = int.tryParse(_paidAmountController.text)! - dueAmount;
                                }
                              });
                            });
                            _paidAmountController.addListener(() {
                              setState(() {
                                if (_paidAmountController.text.isEmpty) {
                                  changeAmount = 0;
                                } else {
                                  changeAmount = int.tryParse(_paidAmountController.text)! -   dueAmount;
                                }
                              });
                            });
                            return SizedBox(
                              width: 400,
                              child: Form(
                                key: _formKey,
                                child:isLoading==true?const Center(child: CircularProgressIndicator(),): Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            maxLines: 1,
                                            controller: _discountAmountController,
                                            onChanged: (value) {
                                              setState(() {
                                                discountAmount = int.tryParse(value) ?? 0;
                                              });
                                            },
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
                                    const SizedBox(height: 10),
                                    Text("Total Discount: ${item.discountAmount+(_discountAmountController.text.isEmpty? 0:int.tryParse(_discountAmountController.text)!)} Tk",
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        const SizedBox(width: 20,),
                                        TextButton(
                                            onPressed: () async{
                                              if (_formKey.currentState!.validate()) {
                                                if (changeAmount! < 0) {
                                                  ElegantNotification.error(
                                                    title: const Text("Error",
                                                        style: TextStyle(
                                                            color: Colors.black)),
                                                    description: const Text(
                                                        "Insufficient Amount",
                                                        style: TextStyle(
                                                            color: Colors.black),
                                                        maxLines: 1),
                                                    width: 300,
                                                    height: 100,
                                                  ).show(context);
                                                } else {
                                                  final preOrderPaymentModel = PreOrderPaymentModel(
                                                    paymentStatus: "Done",
                                                    paymentMode: paymentModeSelectValue,
                                                    discountAmount: item.discountAmount + (_discountAmountController.text.isEmpty?0:int.tryParse(_discountAmountController.text)!),
                                                    paidAmount: item.paidAmount+int.tryParse(_paidAmountController.text)!,
                                                    netPayableAmount:  item.netPayableAmount -(_discountAmountController.text.isEmpty?0:int.tryParse(_discountAmountController.text)!),
                                                    changeAmount:  changeAmount!,
                                                    invoiceNumber: item.invoiceNumber
                                                  );
                                                  setState(() {
                                                    isLoading=true;
                                                  });
                                                  OrderRepositoryImpl orderRepository = instance<OrderRepositoryImpl>();
                                                  final orderResult = await orderRepository.updateOrder(preOrderPaymentModel,item.orderType);
                                                  setState(() {
                                                    isLoading=false;
                                                  });
                                                  orderResult.fold(
                                                          (failure) {
                                                        ElegantNotification .error(
                                                          title: const Text("Error", style: TextStyle(color: Colors.black)),
                                                          description: const Text("Something went wrong", style: TextStyle(color: Colors.black), maxLines: 1),
                                                          width: 300,
                                                          height: 100,
                                                        ).show(context);
                                                      }, (orderModel) async{
                                                    ElegantNotification.success(
                                                      title: const Text("Success", style: TextStyle(color: Colors.black)),
                                                      description: const Text("Payment Successful", style: TextStyle(color: Colors.black),maxLines: 1),
                                                      width: 300,
                                                      height: 100,
                                                    ).show(context);
                                                    final printingService = instance<PrintingService>();
                                                    await printingService.printOrder(orderModel);
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















                // if (item.paymentStatus == "Pending") {
                //   await showDialog(
                //     context: context,
                //     builder: (context) {
                //       String paymentModeSelectValue = "Cash";
                //       TextEditingController _customerNumberController =
                //           TextEditingController();
                //       TextEditingController _discountAmountController =
                //           TextEditingController();
                //       TextEditingController _paidAmountController =
                //           TextEditingController();
                //       int? changeAmount;
                //       final _formKey = GlobalKey<FormState>();
                //       int subtotal = item.subtotalAmount;
                //
                //       return BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                //         child: AlertDialog(
                //           title: const Center(
                //             child: Text(
                //               "Payment",
                //               style:
                //                   TextStyle(color: ColorConstants.primaryColor),
                //             ),
                //           ),
                //           content:
                //               StatefulBuilder(builder: (context, setState) {
                //             _discountAmountController.addListener(() {
                //               setState(() {
                //                 if (_discountAmountController.text.isEmpty) {
                //                   subtotal = item.subtotalAmount;
                //                 } else {
                //                   subtotal = item.subtotalAmount -
                //                       int.tryParse(
                //                           _discountAmountController.text)!;
                //                 }
                //                 if (_paidAmountController.text.isNotEmpty) {
                //                   changeAmount = int.tryParse(
                //                           _paidAmountController.text)! -
                //                       subtotal;
                //                 }
                //               });
                //             });
                //
                //             _paidAmountController.addListener(() {
                //               setState(() {
                //                 if (_paidAmountController.text.isEmpty) {
                //                   changeAmount = 0;
                //                 } else {
                //                   changeAmount = int.tryParse(
                //                           _paidAmountController.text)! -
                //                       subtotal;
                //                 }
                //               });
                //             });
                //             return SizedBox(
                //               width: 400,
                //               child: Form(
                //                 key: _formKey,
                //                 child: Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text("SubTotal :"),
                //                         Text("${item.subtotalAmount} Tk"),
                //                       ],
                //                     ),
                //                     const SizedBox(height: 20),
                //                     Row(
                //                       children: [
                //                         SizedBox(
                //                           width: 200,
                //                           child: CDropdownFormField(
                //                             items: paymentMode
                //                                 .map((e) => DropdownMenuItem(
                //                                       value: e,
                //                                       child: Text(
                //                                         e,
                //                                         style: Theme.of(context)
                //                                             .textTheme
                //                                             .bodyMedium,
                //                                       ),
                //                                     ))
                //                                 .toList(),
                //                             value: paymentModeSelectValue,
                //                             onChanged: (dynamic value) {
                //                               setState(() {
                //                                 paymentModeSelectValue =
                //                                     value.toString();
                //                               });
                //                             },
                //                             label: "Payment Mode",
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           width: 10,
                //                         ),
                //                         Expanded(
                //                           child: TextField(
                //                             maxLines: 1,
                //                             controller:
                //                                 _customerNumberController,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodyMedium,
                //                             keyboardType: TextInputType.number,
                //                             inputFormatters: [
                //                               FilteringTextInputFormatter
                //                                   .digitsOnly
                //                             ],
                //                             decoration: InputDecoration(
                //                               enabledBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               focusedBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               errorBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: Colors.red),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               border: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               labelText: "Customer Number",
                //                               labelStyle: Theme.of(context)
                //                                   .textTheme
                //                                   .bodyMedium,
                //                             ),
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                     const SizedBox(height: 20),
                //                     Row(
                //                       children: [
                //                         Expanded(
                //                           child: TextField(
                //                             maxLines: 1,
                //                             controller:
                //                                 _discountAmountController,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodyMedium,
                //                             keyboardType: TextInputType.number,
                //                             inputFormatters: [
                //                               FilteringTextInputFormatter
                //                                   .digitsOnly
                //                             ],
                //                             decoration: InputDecoration(
                //                               enabledBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               focusedBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               errorBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: Colors.red),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               border: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               labelText: "Discount Amount",
                //                               labelStyle: Theme.of(context)
                //                                   .textTheme
                //                                   .bodyMedium,
                //                             ),
                //                           ),
                //                         ),
                //                         const SizedBox(
                //                           width: 10,
                //                         ),
                //                         Expanded(
                //                           child: TextFormField(
                //                             maxLines: 1,
                //                             validator: (value) {
                //                               if (value == null ||
                //                                   value.isEmpty) {
                //                                 return "Enter paid amount";
                //                               }
                //                               return null;
                //                             },
                //                             controller: _paidAmountController,
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodyMedium,
                //                             keyboardType: TextInputType.number,
                //                             inputFormatters: [
                //                               FilteringTextInputFormatter
                //                                   .digitsOnly
                //                             ],
                //                             decoration: InputDecoration(
                //                               enabledBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               focusedBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               errorBorder: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: Colors.red),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               border: OutlineInputBorder(
                //                                 borderSide: const BorderSide(
                //                                     color: ColorConstants
                //                                         .primaryColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(10),
                //                               ),
                //                               labelText: "Paid Amount",
                //                               labelStyle: Theme.of(context)
                //                                   .textTheme
                //                                   .bodyMedium,
                //                             ),
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                     const SizedBox(height: 20),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         const Text("Change Amount :"),
                //                         Text("${changeAmount ?? 0} Tk"),
                //                       ],
                //                     ),
                //                     const SizedBox(height: 30),
                //                     Row(
                //                       mainAxisAlignment: MainAxisAlignment.end,
                //                       children: [
                //                         TextButton(
                //                             onPressed: () {
                //                               Navigator.pop(context);
                //                             },
                //                             child: Text("Cancel")),
                //                         SizedBox(
                //                           width: 20,
                //                         ),
                //                         TextButton(
                //                             onPressed: () async {
                //                               if (_formKey.currentState!
                //                                   .validate()) {
                //                                 if (changeAmount! < 0) {
                //                                   ElegantNotification.error(
                //                                     title: const Text("Error",
                //                                         style: TextStyle(
                //                                             color:
                //                                                 Colors.black)),
                //                                     description: const Text(
                //                                         "Insufficient Amount",
                //                                         style: TextStyle(
                //                                             color:
                //                                                 Colors.black),
                //                                         maxLines: 1),
                //                                     width: 300,
                //                                     height: 100,
                //                                   ).show(context);
                //                                 } else {
                //                                   final dineInPaymentModel =
                //                                       DineInPaymentModel(
                //                                     paymentStatus: "Done",
                //                                     paymentMode:
                //                                         paymentModeSelectValue,
                //                                     customerPhoneNumber:
                //                                         _customerNumberController
                //                                                 .text.isEmpty
                //                                             ? ""
                //                                             : _customerNumberController
                //                                                 .text,
                //                                     discountAmount:
                //                                         _discountAmountController
                //                                                 .text.isEmpty
                //                                             ? 0
                //                                             : int.tryParse(
                //                                                 _discountAmountController
                //                                                     .text)!,
                //                                     paidAmount: int.tryParse(
                //                                         _paidAmountController
                //                                             .text)!,
                //                                     netPayableAmount: item
                //                                             .subtotalAmount -
                //                                         (_discountAmountController
                //                                                 .text.isEmpty
                //                                             ? 0
                //                                             : int.tryParse(
                //                                                 _discountAmountController
                //                                                     .text)!),
                //                                     changeAmount: changeAmount!,
                //                                     invoiceNumber:
                //                                         item.invoiceNumber,
                //                                   );
                //                                   OrderRepositoryImpl
                //                                       orderRepository =
                //                                       instance<
                //                                           OrderRepositoryImpl>();
                //                                   final orderResult =
                //                                       await orderRepository
                //                                           .updateOrder(
                //                                               dineInPaymentModel);
                //                                   orderResult.fold((failure) {
                //                                     ElegantNotification.error(
                //                                       title: const Text("Error",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .black)),
                //                                       description: const Text(
                //                                           "Something went wrong",
                //                                           style: TextStyle(
                //                                               color:
                //                                                   Colors.black),
                //                                           maxLines: 1),
                //                                       width: 300,
                //                                       height: 100,
                //                                     ).show(context);
                //                                   }, (orderModel) async {
                //                                     final printingService =
                //                                         instance<
                //                                             PrintingService>();
                //                                     await printingService
                //                                         .printOrder(orderModel);
                //                                     ElegantNotification.success(
                //                                       title: const Text(
                //                                           "Success",
                //                                           style: TextStyle(
                //                                               color: Colors
                //                                                   .black)),
                //                                       description: const Text(
                //                                           "Payment Successful",
                //                                           style: TextStyle(
                //                                               color:
                //                                                   Colors.black),
                //                                           maxLines: 1),
                //                                       width: 300,
                //                                       height: 100,
                //                                     ).show(context);
                //                                     tableController.refresh();
                //                                     Navigator.pop(context);
                //                                   });
                //                                 }
                //                               }
                //                             },
                //                             child: const Text(
                //                               "Pay",
                //                               style: TextStyle(
                //                                   color: ColorConstants
                //                                       .primaryColor,
                //                                   fontSize: 16),
                //                             ))
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           }),
                //         ),
                //       );
                //     },
                //   );
                // } else {
                //   ElegantNotification.error(
                //     title: const Text("Error",
                //         style: TextStyle(color: Colors.black)),
                //     description: const Text("This order is Complete",
                //         style: TextStyle(color: Colors.black), maxLines: 1),
                //     width: 300,
                //     height: 100,
                //   ).show(context);
                // }
              },
              icon: Icons.edit,
              iconColor: ColorConstants.primaryColor,
              iconSize: 18),

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
            cellBuilder: (context, item, index) => Text( item.deliveryDateAndTime),
            size: const FixedColumnSize(200),
          ),
          TableColumn(
            title: const Text("Delivery Fee"),
            cellBuilder: (context, item, index) =>  Text("${item.discountAmount} Tk"),
            size: const FixedColumnSize(100),
          ),

          TableColumn(
            title: const Text("Deliver Address"),
            cellBuilder: (context, item, index) =>  Text(item.deliveryAddress,maxLines: 1,overflow: TextOverflow.ellipsis,),
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
            cellBuilder: (context, item, index) =>  Text(item.deliveryBoyName,maxLines: 1,overflow: TextOverflow.ellipsis,),
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
            cellBuilder: (context, item, index) => Text(item.customerName,maxLines: 1,overflow: TextOverflow.ellipsis,),
            size: const FixedColumnSize(200),
          ),
          TableColumn(
            title: const Text("Note"),
            cellBuilder: (context, item, index) => Text(item.note,maxLines: 1,overflow: TextOverflow.ellipsis,),
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
                      style: const TextStyle(color: Colors.black), maxLines: 1),
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
