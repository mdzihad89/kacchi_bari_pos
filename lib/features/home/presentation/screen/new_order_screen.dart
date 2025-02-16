import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/core/common/textform_field.dart';
import 'package:kachi_bari_pos/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/app/app_prefs.dart';
import '../../../../core/common/drop_down_form_field.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../../cart/data/model/order_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/product_item.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedIndex;
  String? _selectedCategoryId;
  Timer? timer;
  final _searchSubject = BehaviorSubject<String>();
  StreamSubscription<String>? _searchSubscription;

  List<String> orderTypes = ["Dine In", "Take Away", "Delivery", "Pre Order"];
  List<String> paymentModes = ["Cash", "Bkash", "Nagad"];

  String? orderTypeSelectedValue;
  String? tableNumberSelectedValue;
  String? paymentModeSelectValue = "Cash";
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController customerNumberController =
  TextEditingController();
  final TextEditingController deliveryAddressController =
  TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController deliveryDateAndTime = TextEditingController();
  final TextEditingController deliveryBoyNameController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();

  String generateInvoiceNumber() {
    final now = DateTime.now();
    final random = Random();
    final timePart = now.microsecondsSinceEpoch % 100000000;
    final randomPart = random.nextInt(100000000);
    final invoiceNumber = (timePart + randomPart) % 100000000;
    return invoiceNumber.toString().padLeft(8, '0');
  }

  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    player = AudioPlayer();

    context.read<HomeBloc>().add(GetHomeEvent());
    _searchSubscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen((searchText) {
      setState(() {
        _selectedIndex = null;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubject.close();
    _searchSubscription?.cancel();
    player.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is HomeError) {
        return Center(
          child: Text(
            state.errorSource,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
          ),
        );
      }
      if (state is HomeLoaded) {
        final searchText = _searchSubject.valueOrNull ?? '';
        final filteredProducts = _selectedIndex == null
            ? state.products
            .where((product) =>
            product.name
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList()
            : state.products
            .where((product) => product.categoryId == _selectedCategoryId)
            .toList();

        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      maxLines: 1,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Search here ...",
                        fillColor: ColorConstants.cardBackgroundColor,
                        filled: true,
                        isDense: true,
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: ColorConstants.primaryColor,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        _searchSubject.add(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.all(8),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = null;
                                        _selectedCategoryId = null;
                                      });
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: _selectedIndex == null
                                            ? ColorConstants.primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Center(
                                        child: Text(
                                          "ALL",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ...state.categories.map((category) {
                                  int index =
                                  state.categories.indexOf(category);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = index;
                                          _selectedCategoryId = category.id;
                                        });
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: _selectedIndex == index
                                              ? ColorConstants.primaryColor
                                              : Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(10),
                                                ),
                                                child: CachedNetworkImage(
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  imageUrl: category.image,
                                                  placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                      CircularProgressIndicator()),
                                                  errorWidget: (context, url,
                                                      error) =>
                                                  const Icon(Icons.error),
                                                )),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  category.name,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: filteredProducts.isEmpty
                                ? Center(
                              child: Text(
                                "No Product Found",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                            )
                                : LayoutBuilder(
                              builder: (context, constraints) {
                                const double itemWidth = 160.0;
                                const double itemHeight = 150.0;
                                int crossAxisCount =
                                ((constraints.maxWidth + 8.0) /
                                    (itemWidth + 8.0))
                                    .floor();
                                return GridView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio:
                                    itemWidth / itemHeight,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                  ),
                                  itemCount: filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    return ProductItem(
                                      product: filteredProducts[index],
                                      audioPlayer: player,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CDropdownFormField<String>(
                            value: orderTypeSelectedValue,
                            onChanged: (dynamic value) {
                              setState(() {
                                orderTypeSelectedValue = value.toString();
                                if (orderTypeSelectedValue == "Dine In" ||
                                    orderTypeSelectedValue == "Delivery") {
                                  paymentModeSelectValue = null;
                                }
                              });
                            },
                            validator: (dynamic value) {
                              if (value == null) {
                                return "Please select order type";
                              }
                              return null;
                            },
                            items: orderTypes
                                .map((e) =>
                                DropdownMenuItem<String>(
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
                            label: "Select Order Type",
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: CDropdownFormField(
                            items: paymentModes
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
                            validator: (dynamic value) {
                              if (value == null) {
                                return "Please select payment mode";
                              }
                              return null;
                            },
                            onChanged: (dynamic value) {
                              setState(() {
                                paymentModeSelectValue = value.toString();
                              });
                            },
                            label: "Payment Mode",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            controller: customerNumberController,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorConstants.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorConstants.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorConstants.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Customer Number",
                              labelStyle:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                    orderTypeSelectedValue == "Dine In" ||
                        orderTypeSelectedValue == "Delivery" ||
                        orderTypeSelectedValue == "Pre Order"
                        ? const SizedBox(
                      height: 10,
                    )
                        : const SizedBox.shrink(),
                    orderTypeSelectedValue == "Dine In"
                        ? CDropdownFormField<String>(
                      value: tableNumberSelectedValue,
                      onChanged: (dynamic value) {
                        setState(() {
                          tableNumberSelectedValue = value.toString();
                        });
                      },
                      validator: (dynamic value) {
                        if (value == null) {
                          return "Please select table number";
                        }
                        return null;
                      },
                      items: List.generate(
                        state.branchModel.table,
                            (index) =>
                            DropdownMenuItem<String>(
                              value: (index + 1).toString(),
                              child: Text(
                                (index + 1).toString(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                            ),
                      ),
                      label: "Select Table Number",
                    )
                        : orderTypeSelectedValue == "Delivery" ||
                        orderTypeSelectedValue == "Pre Order"
                        ? CTextFormField(
                      labelText: "Delivery Address",
                      validatorText: "Please enter delivery address",
                      textEditingController:
                      deliveryAddressController,
                    )
                        : const SizedBox.shrink(),
                    orderTypeSelectedValue == "Pre Order"
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CTextFormField(
                            labelText: "Customer Name",
                            validatorText: "Please enter customer name",
                            textEditingController: customerNameController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CTextFormField(
                            labelText: "Note",
                            validatorText: "please enter note",
                            textEditingController: noteController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CTextFormField(
                            labelText: "Delivery Date & Time",
                            validatorText:
                            "please enter delivery date & time",
                            textEditingController: deliveryDateAndTime,
                            onTap: () async {
                              await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((selectedTime) {
                                    if (selectedTime != null) {
                                      DateTime selectedDateTime =
                                      DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      deliveryDateAndTime.text =
                                          DateFormat.yMMMd()
                                              .add_jm()
                                              .format(selectedDateTime);
                                    }
                                  });
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ) :
                    orderTypeSelectedValue == "Delivery" ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CTextFormField(
                              labelText: "Delivery boy name",
                          validatorText: "Please enter delivery boy name",
                          textEditingController: deliveryBoyNameController,
                        ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child:  TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: deliveryFeeController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            labelText: "Delivery Fee",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            enabledBorder:
                            OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorConstants
                                      .primaryColor),
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            focusedBorder:
                            OutlineInputBorder(
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
                          ),
                          onChanged: (value) {
                            final deliveryFee =
                                int.tryParse(value) ?? 0;
                            context.read<CartBloc>().add(UpdateDeliveryFee(deliveryFee: deliveryFee));
                          },
                        ),
                        ),
                      ],
                    )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: BlocConsumer<CartBloc, CartState>(
                        listener: (context, state) {
                          if (state.errorMessage.isNotEmpty) {
                            ElegantNotification.error(
                              title: const Text(
                                "Error",
                                style: TextStyle(color: Colors.black),
                              ),
                              description: Text(
                                state.errorMessage.toString(),
                                style: const TextStyle(color: Colors.black),
                                maxLines: 1,
                              ),
                              width: 300,
                              height: 100,
                            ).show(context);
                          }
                        },
                        builder: (context, state) {
                          if (state.cartLoading == true) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final homeLoadedState =
                          context
                              .read<HomeBloc>()
                              .state as HomeLoaded;
                          return Column(
                            children: [
                              Table(
                                border: TableBorder.all(
                                    color: Colors.white, width: 1),
                                columnWidths: const {
                                  0: FlexColumnWidth(3.5),
                                  1: FlexColumnWidth(1.5),
                                  2: FlexColumnWidth(2.5),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(
                                        color: ColorConstants.primaryColor),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text(
                                          "Item",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text("Rate",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text("Qty",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text("Total",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text("Action",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Table(
                                    border: TableBorder.all(
                                        color: Colors.grey, width: 1),
                                    columnWidths: const {
                                      0: FlexColumnWidth(3.5),
                                      1: FlexColumnWidth(1.5),
                                      2: FlexColumnWidth(2.5),
                                      3: FlexColumnWidth(2),
                                      4: FlexColumnWidth(1),
                                    },
                                    children: state.cartItems.map((item) {
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(item.productName),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Tk ${item.unitPrice}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onLongPress: () {
                                                    timer = Timer.periodic(
                                                        const Duration(
                                                            milliseconds: 200), (
                                                        timer) {
                                                      if (item.quantity > 1) {
                                                        context.read<CartBloc>()
                                                            .add(UpdateQuantity(
                                                          productID: item
                                                              .productID,
                                                          quantity: item
                                                              .quantity - 1,
                                                        ));
                                                      } else {
                                                        timer.cancel();
                                                      }
                                                    });
                                                  },
                                                  onLongPressEnd: (details) {
                                                    timer?.cancel();
                                                  },
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.red,
                                                        size: 16),
                                                    onPressed: () {
                                                      if (item.quantity > 1) {
                                                        context.read<CartBloc>()
                                                            .add(UpdateQuantity(
                                                          productID: item
                                                              .productID,
                                                          quantity: item
                                                              .quantity - 1,
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Text(item.quantity.toString()),
                                                GestureDetector(
                                                  onLongPress: () {
                                                    timer = Timer.periodic(
                                                        const Duration(
                                                            milliseconds: 200), (
                                                        timer) {
                                                      context.read<CartBloc>()
                                                          .add(UpdateQuantity(
                                                        productID: item
                                                            .productID,
                                                        quantity: item
                                                            .quantity + 1,
                                                      ));
                                                    });
                                                  },
                                                  onLongPressEnd: (details) {
                                                    timer?.cancel();
                                                  },
                                                  child: IconButton(
                                                    icon: const Icon(Icons.add,
                                                        color: Colors.green,
                                                        size: 16),
                                                    onPressed: () {
                                                      context.read<CartBloc>()
                                                          .add(UpdateQuantity(
                                                        productID: item
                                                            .productID,
                                                        quantity: item
                                                            .quantity + 1,
                                                      ));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Tk ${(item.price)}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                context.read<CartBloc>().add(
                                                    RemoveFromCart(
                                                        productID:
                                                        item.productID));
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              // Subtotal
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Subtotal:",
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Tk ${state.subtotal}",
                                        style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),

                              // Cash Paid
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const Text("Discount:",
                                              style: TextStyle(fontSize: 18)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: TextField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              controller: discountController,
                                              keyboardType:
                                              TextInputType.number,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10)
                                                    .copyWith(top: 5),
                                                hintText: "Amount",
                                                hintStyle: const TextStyle(
                                                    fontSize: 16),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: ColorConstants
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
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
                                              ),
                                              onChanged: (value) {
                                                final discount =
                                                    int.tryParse(value) ?? 0;
                                                context.read<CartBloc>().add(
                                                    UpdateDiscount(
                                                        discount: discount));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          const Text("Paid:",
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: TextField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              controller: paidAmountController,
                                              keyboardType:
                                              TextInputType.number,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10)
                                                    .copyWith(top: 5),
                                                hintText: "Amount",
                                                hintStyle: const TextStyle(
                                                    fontSize: 16),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: ColorConstants
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
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
                                              ),
                                              onChanged: (value) {
                                                final paidAmount =
                                                    int.tryParse(value) ?? 0;
                                                context.read<CartBloc>().add(
                                                    UpdatePaidAmount(
                                                        paidAmount:
                                                        paidAmount));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Change Amount
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Change:",
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                      "Tk ${state.changeAmount}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              // Pay Button
                              ElevatedButton(
                                onPressed: () async {
                                  if (state.cartItems.isEmpty) {
                                    ElegantNotification.error(
                                      title: const Text(
                                        "Error",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      description: const Text(
                                        "Cart is Empty",
                                        style: TextStyle(
                                            color: Colors.black),
                                        maxLines: 1,
                                      ),
                                      width: 300,
                                      height: 100,
                                    ).show(context);
                                  } else if (orderTypeSelectedValue == null) {
                                    ElegantNotification.error(
                                      title: const Text(
                                        "Error",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      description: Text(
                                        "Select Order Type",
                                        style: const TextStyle(
                                            color: Colors.black),
                                        maxLines: 1,
                                      ),
                                      width: 300,
                                      height: 100,
                                    ).show(context);
                                  } else if (orderTypeSelectedValue ==
                                      "Take Away") {
                                    if (paidAmountController.text.isEmpty) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Enter Amount",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    } else if (paymentModeSelectValue == null) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Select Payment Mode",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    } else if (state.changeAmount < 0) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Insufficient cash paid!",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    } else {
                                      final orderModel = OrderModel(
                                          cartItems: state.cartItems
                                              .map((e) =>
                                              CartItem(
                                                productName: e.productName,
                                                unitPrice: e.unitPrice,
                                                productID: e.productID,
                                                quantity: e.quantity,
                                              ))
                                              .toList(),
                                          subtotalAmount: state.subtotal,
                                          paidAmount: int.tryParse(
                                              paidAmountController.text)!,
                                          netPayableAmount: state.discount == 0
                                              ? state.subtotal
                                              : state.subtotal - state.discount,
                                          changeAmount: state.changeAmount,
                                          orderDate:
                                          DateTime.now().toIso8601String(),
                                          tableNumber: "",
                                          discountAmount:
                                          discountController.text.isEmpty
                                              ? 0
                                              : int.tryParse(
                                              discountController.text)!,
                                          customerPhoneNumber:
                                          customerNumberController.text.isEmpty
                                              ? ""
                                              : customerNumberController.text
                                              .toString(),
                                          orderType: orderTypeSelectedValue!,
                                          branchId:
                                          homeLoadedState.branchModel.id,
                                          branchName:
                                          homeLoadedState.branchModel.name,
                                          managerId: homeLoadedState
                                              .branchModel.managerId,
                                          managerName: homeLoadedState
                                              .branchModel.managerName,
                                          branchPhoneNumber: homeLoadedState
                                              .branchModel.branchPhoneNumber,
                                          branchAddress: homeLoadedState
                                              .branchModel.address,
                                          paymentMode: paymentModeSelectValue!,
                                          paymentStatus: "Done",
                                          serialNumber:
                                          await instance<AppPreferences>()
                                              .getSerialNumber(),
                                          branchBinNumber: homeLoadedState
                                              .branchModel.branchBinNumber,
                                          invoiceNumber: generateInvoiceNumber(),
                                          deliveryAddress: "",
                                          customerName: "",
                                          deliveryDateAndTime: "",
                                          note: "",
                                          orderStatus: "Done",
                                          deliveryFee: 0,
                                          deliveryBoyName: "",
                                      );
                                      context.read<CartBloc>().add(
                                          PlaceOrder(orderModel: orderModel));
                                      paidAmountController.clear();
                                      discountController.clear();
                                      customerNumberController.clear();
                                    }
                                  } else if (orderTypeSelectedValue ==
                                      "Delivery") {
                                    if (deliveryAddressController
                                        .text.isEmpty) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Enter Delivery Address",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else if (paidAmountController.text.isNotEmpty && paymentModeSelectValue == null) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Select Payment Mode",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else if (paidAmountController.text.isNotEmpty &&
                                        state.changeAmount < 0) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Insufficient cash paid!",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    //
                                    // else if (state.changeAmount < 0) {
                                    //   ElegantNotification.error(
                                    //     title: const Text(
                                    //       "Error",
                                    //       style: TextStyle(color: Colors.black),
                                    //     ),
                                    //     description: const Text(
                                    //       "Insufficient cash paid!",
                                    //       style: TextStyle(color: Colors.black),
                                    //       maxLines: 1,
                                    //     ),
                                    //     width: 300,
                                    //     height: 100,
                                    //   ).show(context);
                                    // }
                                    else {
                                      if (paidAmountController.text.isEmpty && paymentModeSelectValue != null) {
                                        setState(() {
                                          paymentModeSelectValue = null;
                                        });
                                      }
                                      final orderModel = OrderModel(
                                          cartItems: state.cartItems
                                              .map((e) =>
                                              CartItem(
                                                productName: e.productName,
                                                unitPrice: e.unitPrice,
                                                productID: e.productID,
                                                quantity: e.quantity,
                                              ))
                                              .toList(),
                                          subtotalAmount: state.subtotal-state.deliveryFee,
                                          paidAmount: paidAmountController.text
                                              .isNotEmpty ? int.tryParse(
                                              paidAmountController.text)! : 0,
                                          changeAmount: state.changeAmount,
                                          orderDate: DateTime.now()
                                              .toIso8601String(),
                                          discountAmount: discountController
                                              .text.isEmpty ? 0 : int.tryParse(
                                              discountController.text)!,
                                          customerPhoneNumber: customerNumberController
                                              .text.isEmpty
                                              ? ""
                                              : customerNumberController.text
                                              .toString(),
                                          netPayableAmount: state.discount == 0
                                              ? state.subtotal
                                              : state.subtotal- state.discount,
                                          tableNumber: "",
                                          orderType: orderTypeSelectedValue!,
                                          branchId: homeLoadedState.branchModel
                                              .id,
                                          branchName: homeLoadedState
                                              .branchModel.name,
                                          managerId: homeLoadedState.branchModel
                                              .managerId,
                                          managerName: homeLoadedState
                                              .branchModel.managerName,
                                          branchPhoneNumber: homeLoadedState
                                              .branchModel.branchPhoneNumber,
                                          branchAddress: homeLoadedState
                                              .branchModel.address,
                                          paymentMode: paymentModeSelectValue ==
                                              null
                                              ? ""
                                              : paymentModeSelectValue!,
                                          paymentStatus: state.changeAmount < 0
                                              ? "Pending"
                                              : "Done",
                                          invoiceNumber: generateInvoiceNumber(),
                                          branchBinNumber: homeLoadedState
                                              .branchModel.branchBinNumber,
                                          serialNumber: "",
                                          deliveryAddress: deliveryAddressController
                                              .text,
                                          customerName: "",
                                          deliveryDateAndTime: "",
                                          note: "",
                                          orderStatus: "Done",
                                          deliveryFee: state.deliveryFee,
                                          deliveryBoyName: deliveryBoyNameController.text.isEmpty ? "" : deliveryBoyNameController.text,

                                      );
                                      context.read<CartBloc>().add(PlaceOrder(orderModel: orderModel));
                                      paidAmountController.clear();
                                      discountController.clear();
                                      customerNumberController.clear();
                                      deliveryAddressController.clear();
                                      deliveryBoyNameController.clear();
                                      deliveryFeeController.clear();
                                      setState(() {
                                        paymentModeSelectValue = null;
                                      });
                                    }
                                  } else if (orderTypeSelectedValue == "Dine In") {
                                    if (tableNumberSelectedValue == null) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Select Table Number",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else if(paidAmountController.text.isNotEmpty && state.changeAmount < 0){
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Insufficient cash paid!",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }


                                    else if (paidAmountController.text.isNotEmpty && paymentModeSelectValue == null) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Select Payment Mode",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }

                                    else {

                                      if (paidAmountController.text.isEmpty && paymentModeSelectValue != null) {
                                        setState(() {
                                          paymentModeSelectValue = null;
                                        });
                                      }
                                      final orderModel = OrderModel(
                                          cartItems: state.cartItems
                                              .map((e) =>
                                              CartItem(
                                                productName: e.productName,
                                                unitPrice: e.unitPrice,
                                                productID: e.productID,
                                                quantity: e.quantity,
                                              ))
                                              .toList(),
                                          subtotalAmount: state.subtotal,
                                          paidAmount: paidAmountController.text.isEmpty ? 0 : int.tryParse(paidAmountController.text)!,
                                          changeAmount: state.changeAmount,
                                          orderDate: DateTime.now().toIso8601String(),
                                          discountAmount: discountController.text.isEmpty ? 0 : int.tryParse(discountController.text)!,
                                          customerPhoneNumber: customerNumberController.text.isEmpty ? "" : customerNumberController.text.toString(),
                                          netPayableAmount: state.discount == 0 ? state.subtotal : state.subtotal - state.discount,
                                          tableNumber: tableNumberSelectedValue!,
                                          orderType: orderTypeSelectedValue!,
                                          branchId: homeLoadedState.branchModel.id,
                                          branchName: homeLoadedState.branchModel.name,
                                          managerId: homeLoadedState.branchModel.managerId,
                                          managerName: homeLoadedState.branchModel.managerName,
                                          branchPhoneNumber: homeLoadedState.branchModel.branchPhoneNumber,
                                          branchAddress: homeLoadedState.branchModel.address,
                                          paymentMode: paymentModeSelectValue==null?"":paymentModeSelectValue!,
                                          paymentStatus: state.changeAmount < 0 ? "Pending" : "Done",
                                          invoiceNumber: generateInvoiceNumber(),
                                          branchBinNumber: homeLoadedState.branchModel.branchBinNumber,
                                          serialNumber: "",
                                          deliveryAddress: "",
                                          deliveryDateAndTime: "",
                                          customerName: "",
                                          note: "",
                                          orderStatus: "Done",
                                          deliveryFee: 0,
                                          deliveryBoyName: "",
                                      );

                                      context.read<CartBloc>().add(PlaceOrder(orderModel: orderModel));
                                      paidAmountController.clear();
                                      discountController.clear();
                                      customerNumberController.clear();
                                      setState(() {
                                        tableNumberSelectedValue = null;
                                      });
                                    }
                                  }
                                  else if (orderTypeSelectedValue == "Pre Order") {
                                    if (customerNameController.text.isEmpty) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Enter Customer Name",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else if (deliveryDateAndTime.text.isEmpty) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Enter Delivery Date & Time",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else if (paidAmountController.text.isEmpty) {
                                      ElegantNotification.error(
                                        title: const Text(
                                          "Error",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        description: const Text(
                                          "Please enter paid amount",
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        width: 300,
                                        height: 100,
                                      ).show(context);
                                    }
                                    else {
                                      final orderModel = OrderModel(
                                          cartItems: state.cartItems.map((e) =>
                                              CartItem(
                                                productName: e.productName,
                                                unitPrice: e.unitPrice,
                                                productID: e.productID,
                                                quantity: e.quantity,
                                              )).toList(),
                                          subtotalAmount: state.subtotal,
                                          paidAmount: paidAmountController.text.isEmpty ? 0 : int.tryParse(paidAmountController.text)!,
                                          changeAmount: state.changeAmount,
                                          orderDate: DateTime.now().toIso8601String(),
                                          discountAmount: discountController.text.isEmpty ? 0 : int.tryParse(discountController.text)!,
                                          customerPhoneNumber: customerNumberController.text.isEmpty ? "" : customerNumberController.text.toString(),
                                          netPayableAmount: state.discount == 0 ? state.subtotal : state.subtotal - state.discount,
                                          tableNumber: "",
                                          orderType: orderTypeSelectedValue!,
                                          branchId: homeLoadedState.branchModel.id,
                                          branchName: homeLoadedState.branchModel.name,
                                          managerId: homeLoadedState.branchModel.managerId,
                                          managerName: homeLoadedState.branchModel.managerName,
                                          branchPhoneNumber: homeLoadedState.branchModel.branchPhoneNumber,
                                          branchAddress: homeLoadedState.branchModel.address,
                                          paymentMode: paymentModeSelectValue!,
                                          paymentStatus: state.changeAmount < 0 ? "Pending" : "Done",
                                          invoiceNumber: generateInvoiceNumber(),
                                          branchBinNumber: homeLoadedState.branchModel.branchBinNumber,
                                          serialNumber: "",
                                          deliveryAddress: deliveryAddressController.text.isEmpty ? "" : deliveryAddressController.text,
                                          deliveryDateAndTime: deliveryDateAndTime.text,
                                          customerName: customerNameController.text,
                                          note: noteController.text.isEmpty ? "" : noteController.text,
                                          orderStatus: "Pending",
                                          deliveryFee: 0,
                                          deliveryBoyName: "",
                                      );
                                      context.read<CartBloc>().add(PlaceOrder(orderModel: orderModel));
                                      paidAmountController.clear();
                                      discountController.clear();
                                      customerNumberController.clear();
                                      deliveryAddressController.clear();
                                      deliveryDateAndTime.clear();
                                      customerNameController.clear();
                                      noteController.clear();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 40),
                                  backgroundColor: ColorConstants.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Place Order",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }
      return const SizedBox();
    });
  }
}
