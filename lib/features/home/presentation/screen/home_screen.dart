import 'dart:async';
import 'dart:math';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/core/constants/color_constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:super_banners/super_banners.dart';
import '../../../../core/common/drop_down_form_field.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/event/auth_event.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../../cart/data/data_sources/local/isar/orders.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../data/model/product_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'package:image/image.dart' as img;
import 'package:usb_esc_printer_windows/usb_esc_printer_windows.dart' as usb_esc_printer_windows;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final TextEditingController _searchController = TextEditingController();
  final _searchSubject = BehaviorSubject<String>();
  StreamSubscription<String>? _searchSubscription;
  int? _selectedIndex;
  String? _selectedCategoryId;
  List<String> orderTypes = ["Dine In", "Take Away", "Delivery"];
  List<String> paymentModes = ["Cash", "Bkash", "Roket"];
  String? orderTypeSelectedValue;
  String? tableNumberSelectedValue;
  String paymentModeSelectValue="Cash";
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController customerNumberController = TextEditingController();
  final String _printerName = "RONGTA 80mm Series Printer";
  late Future<CapabilityProfile> _profile;
  late img.Image posLogo;
  late img.Image posFooter;



  String generateInvoiceNumber() {
    final now = DateTime.now();
    final random = Random();
    final timePart = now.microsecondsSinceEpoch % 100000000;
    final randomPart = random.nextInt(100000000);
    final invoiceNumber = (timePart + randomPart) % 100000000;
    return invoiceNumber.toString().padLeft(8, '0');
  }
  Future loadPosImage() async {
    final ByteData logoData = await rootBundle.load('assets/svg/pos_logo.png');
    final ByteData footerData = await rootBundle.load('assets/svg/pos_footer.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final Uint8List footerBytes = footerData.buffer.asUint8List();
    posLogo=img.decodeImage(logoBytes)!;
    posFooter=img.decodeImage(footerBytes)!;

  }
  Future printReq( Orders order) async {
    List<int> bytes = [];
    final profile = await _profile;
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.image(posLogo, align: PosAlign.center);

    bytes += generator.text(
      order.branchAddress,
      styles: const PosStyles(
        align: PosAlign.center,
        fontType: PosFontType.fontB,
      ),
    );

    bytes += generator.text(
      'Phone : ${order.branchPhoneNumber},',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size1,
          width: PosTextSize.size1,
        bold: true

      ),
    );

    bytes += generator.text(
      'Bin : ${order.branchBinNumber},',
      styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true

      ),
    );


    bytes += generator.feed(1);
    bytes += generator.text(
      'Invoice No:${order.invoiceNumber},',
      styles: const PosStyles(
          align: PosAlign.left,
      ),
    );
    bytes += generator.text(
      'Date: ${DateFormat('dd-MM-yyyy h:mm a').format(DateTime.parse(order.orderDate))}',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );

    if(order.customerPhoneNumber.isNotEmpty){
      bytes += generator.text(
        'Customer Phone: ${order.customerPhoneNumber}',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      );
    }
    bytes += generator.text(
      'Payment Mode: ${order.paymentMode}',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );

    bytes += generator.text(
      'Order Type: ${order.orderType}',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );

    if(order.tableNumber.isNotEmpty){
      bytes += generator.text(
        'Table -  ${order.tableNumber}',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      );
    }

    bytes += generator.feed(1);


    bytes.addAll(generator.row([
      PosColumn(text: 'S/N.', width: 1, styles: PosStyles(bold: true,align: PosAlign.left)),
      PosColumn(text: 'Item',width:8, styles: PosStyles(bold: true,align: PosAlign.center)),
      PosColumn(text: 'Qty', width: 1, styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(text: 'Price', width:2, styles: PosStyles(align: PosAlign.right, bold: true)),
    ]));

    bytes.addAll(generator.hr());
    order.cartItems.asMap().forEach((index, item) {
      bytes.addAll(generator.row([
        PosColumn(text:  '${index + 1}.', width: 1,styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: "${item.productName!}.",width: 8, styles: PosStyles(align: PosAlign.left,fontType: PosFontType.fontA, height: PosTextSize.size1,codeTable: "CP437")),
        PosColumn(text: item.quantity.toString(), width: 1, styles: PosStyles(align: PosAlign.center)),
        PosColumn(text: "${item.price.toString()} Tk", width: 2, styles: PosStyles(align: PosAlign.right)),
      ]));
    });

    bytes.addAll(generator.hr());

    bytes.addAll(generator.row([
      PosColumn(text: 'Subtotal', width: 8),
      PosColumn(text:  "${order.subtotalAmount.toString()} Tk", width: 4, styles: PosStyles(align: PosAlign.right)),
    ]));


    if(order.discountAmount>0){
      bytes.addAll(generator.row([
        PosColumn(text: 'Discount', width: 8),
        PosColumn(text: "${order.discountAmount.toString()} Tk", width: 4, styles: PosStyles(align: PosAlign.right)),
      ]));
    }
    bytes.addAll(generator.row([
      PosColumn(text: 'Net Payable', width: 8),
      PosColumn(text: "${order.netPayableAmount.toString()} Tk", width: 4, styles: PosStyles(align: PosAlign.right)),
    ]));
    bytes.addAll(generator.hr());
    bytes.addAll(generator.row([
      PosColumn(text: 'Cash Paid', width: 8),
      PosColumn(text: "${order.paidAmount.toString()} Tk", width: 4, styles: PosStyles(align: PosAlign.right)),
    ]));

    bytes.addAll(generator.row([
      PosColumn(text: 'Change Amount', width: 8),
      PosColumn(text: "${order.changeAmount.toString()} Tk", width: 4, styles: PosStyles(align: PosAlign.right)),
    ]));

    bytes += generator.feed(1);

    bytes += generator.image(posFooter, align: PosAlign.center);


    bytes.addAll(generator.text(
      'Powered by Hundredit',
      styles: const PosStyles(align: PosAlign.center),

    ));
    bytes += generator.cut();

    bytes += generator.text(
      'Kitchen copy',
      styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true
      ),
    );



    bytes += generator.text(
      'Invoice No:${order.invoiceNumber},',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
    bytes += generator.text(
      'Date: ${DateFormat('dd-MM-yyyy h:mm a').format(DateTime.parse(order.orderDate))}',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );

    if(order.customerPhoneNumber.isNotEmpty){
      bytes += generator.text(
        'Customer Phone: ${order.customerPhoneNumber}',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      );
    }
    bytes += generator.text(
      'Order Type: ${order.orderType}',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );

    if(order.tableNumber.isNotEmpty){
      bytes += generator.text(
        'Table -  ${order.tableNumber}',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      );
    }


    bytes += generator.feed(1);

    bytes.addAll(generator.row([
      PosColumn(text: 'S/N.', width: 1, styles: PosStyles(bold: true,align: PosAlign.left)),
      PosColumn(text: 'Item',width:8, styles: PosStyles(bold: true,align: PosAlign.center)),
      PosColumn(text: 'Qty', width: 1, styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(text: 'Price', width:2, styles: PosStyles(align: PosAlign.right, bold: true)),
    ]));

    bytes.addAll(generator.hr());
    order.cartItems.asMap().forEach((index, item) {
      bytes.addAll(generator.row([
        PosColumn(text:  '${index + 1}.', width: 1,styles: PosStyles(align: PosAlign.left)),
        PosColumn(text: "${item.productName!}.",width: 8, styles: PosStyles(align: PosAlign.left,fontType: PosFontType.fontA, height: PosTextSize.size1,codeTable: "CP437")),
        PosColumn(text: item.quantity.toString(), width: 1, styles: PosStyles(align: PosAlign.center)),
        PosColumn(text: "${item.price.toString()} Tk", width: 2, styles: PosStyles(align: PosAlign.right)),
      ]));
    });
    bytes += generator.cut();

    final res = await usb_esc_printer_windows.sendPrintRequest(bytes, _printerName);

    String msg = "";

    if (res == "success") {
      msg = "Printed Successfully";
    } else {
      msg = "Failed to generate a print please make sure to use the correct printer name";
    }
    print(msg);
  }




@override
  void initState() {
    super.initState();
    _profile = CapabilityProfile.load();
      loadPosImage();
      context.read<HomeBloc>().add(GetHomeEvent());
    _searchSubscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 300))
        .listen((searchText) {
      setState(() {
        _selectedIndex = null;
      });
    });
  }

  @override
  void dispose() {
    _searchSubscription?.cancel();
    _searchSubject.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.replace('/login');
        } else if (state is Authenticated) {
          context.read<HomeBloc>().add(GetHomeEvent());
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            appBar: AppBar(
              backgroundColor: ColorConstants.cardBackgroundColor,
              title: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text("New Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text("Pending Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text("Today's Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                  )
                ],
              ),
              actions: [
                Text(
                  state.user.branchName,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: PopupMenuButton(
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.primaryColor,
                      radius: 20,
                      child: state.user.image == ""
                          ? Text(state.user.name
                          .split("")
                          .first
                          .toUpperCase())
                          : Image.network(state.user.image),
                    ),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'logout',
                          child: Text('Logout'),
                        ),
                        const PopupMenuItem(
                          value: 'profile',
                          child: Text('Profile'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == "profile") {} else if (value == "logout") {
                        context.read<AuthBloc>().add(SignOutRequested());
                      }
                    },
                  ),
                ),
              ],
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  final searchText = _searchSubject.valueOrNull ?? '';
                  final filteredProducts = _selectedIndex == null
                      ? state.products
                      .where((product) =>
                      product.name
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList()
                      : state.products
                      .where((product) =>
                  product.categoryId == _selectedCategoryId)
                      .toList();

                  return Row(
                    children: [
                      Container(
                        width: size.width * 0.6,
                        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
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
                                    icon: const Icon(Icons.search,
                                        color: Colors.white),
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
                                      children:
                                      state.categories.map((category) {
                                        int index =
                                        state.categories.indexOf(category);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
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
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius
                                                        .vertical(
                                                        top:
                                                        Radius.circular(
                                                            10)),
                                                    child: Image.network(
                                                      category.image,
                                                      height: 40,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        category.name,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                        ),
                                                        textAlign:
                                                        TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Expanded(
                                    child: LayoutBuilder(
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
                                                product:
                                                filteredProducts[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: size.width * 0.4,
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
                                  width:150,
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
                                    style:
                                    Theme
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
                                        borderSide:
                                        const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorConstants.primaryColor),
                                        borderRadius: BorderRadius.circular(10),
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
                            orderTypeSelectedValue == "Dine In"
                                ? const SizedBox(
                              height: 20,
                            )
                                : const SizedBox.shrink(),
                            orderTypeSelectedValue == "Dine In"
                                ? CDropdownFormField<String>(
                              value: tableNumberSelectedValue,
                              onChanged: (dynamic value) {
                                setState(() {
                                  tableNumberSelectedValue =
                                      value.toString();
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
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: BlocConsumer<CartBloc, CartState>(
                                listener: (context, state) {

                                  if(state.errorMessage != null){
                                    ElegantNotification.error(
                                      title: const Text(
                                        "Error",
                                        style: TextStyle(
                                            color: Colors.black),
                                      ),
                                      description:  Text(
                                       state.errorMessage.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
                                        maxLines: 1,
                                      ),
                                      width: 300,
                                      height: 100,
                                    ).show(context);
                                  }


                                },

                                builder: (context, state) {
                                  final subtotal = state.subtotal;
                                  final homeLoadedState=context.read<HomeBloc>().state as HomeLoaded;
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
                                                color: ColorConstants
                                                    .primaryColor),
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
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
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("Rate",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textAlign:
                                                    TextAlign.center),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("Qty",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textAlign:
                                                    TextAlign.center),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("Total",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textAlign:
                                                    TextAlign.center),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("Action",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    textAlign:
                                                    TextAlign.center),
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
                                            children:
                                            state.cartItems.map((item) {
                                              return TableRow(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child:
                                                    Text(item.productName),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Text(
                                                        "Tk ${item.unitPrice}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.remove,
                                                              color: Colors.red,
                                                              size: 16),
                                                          onPressed: () {
                                                            if (item.quantity >
                                                                1) {
                                                              context
                                                                  .read<
                                                                  CartBloc>()
                                                                  .add(
                                                                  UpdateQuantity(
                                                                    productID: item
                                                                        .productID,
                                                                    quantity:
                                                                    item
                                                                        .quantity -
                                                                        1,
                                                                  ));
                                                            }
                                                          },
                                                        ),
                                                        Text(item.quantity
                                                            .toString()),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                              Colors.green,
                                                              size: 16),
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                CartBloc>()
                                                                .add(
                                                                UpdateQuantity(
                                                                  productID: item
                                                                      .productID,
                                                                  quantity:
                                                                  item
                                                                      .quantity +
                                                                      1,
                                                                ));
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Text(
                                                        "Tk ${(item.price)}"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        context
                                                            .read<CartBloc>()
                                                            .add(RemoveFromCart(
                                                            productID: item
                                                                .productID));
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const Text("Subtotal:",
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(width: 20,),
                                            Text("Tk $subtotal",
                                                style: const TextStyle(
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),

                                      // Cash Paid
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  const Text("Discount:",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  SizedBox(width: 20,),
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
                                                        const EdgeInsets
                                                            .symmetric(
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
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: ColorConstants
                                                                  .primaryColor),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                        errorBorder:
                                                        OutlineInputBorder(
                                                          borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .red),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: ColorConstants
                                                                  .primaryColor),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        final discount = int.tryParse(value) ?? 0;
                                                        context.read<CartBloc>().add(UpdateDiscount(discount: discount));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  const Text("Paid:",
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                  SizedBox(width: 20,),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 30,
                                                    child: TextField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                      controller: paidAmountController,
                                                      keyboardType: TextInputType
                                                          .number,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10,
                                                            horizontal: 10)
                                                            .copyWith(top: 5),
                                                        hintText: "Amount",
                                                        hintStyle: const TextStyle(
                                                            fontSize: 16),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: ColorConstants
                                                                  .primaryColor),
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: ColorConstants
                                                                  .primaryColor),
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                        ),
                                                        errorBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: Colors
                                                                  .red),
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                        ),
                                                        border: OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                              color: ColorConstants
                                                                  .primaryColor),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        final paidAmount = int
                                                            .tryParse(value) ??
                                                            0;
                                                        context
                                                            .read<CartBloc>()
                                                            .add(
                                                            UpdatePaidAmount(
                                                                paidAmount: paidAmount));
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Change:",
                                                style: TextStyle(fontSize: 18)),
                                            Text(
                                              "Tk ${state.changeAmount < 0
                                                  ? 0
                                                  : state.changeAmount}",
                                              style:
                                              const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Pay Button
                                      ElevatedButton(
                                        onPressed: () async{
                                          if (state.cartItems.isEmpty) {
                                            ElegantNotification.error(
                                              title: const Text(
                                                "Error",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              description: Text(
                                                "Cart is Empty",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                maxLines: 1,
                                              ),
                                              width: 300,
                                              height: 100,
                                            ).show(context);
                                          }
                                          else if (orderTypeSelectedValue == null) {
                                            ElegantNotification.error(
                                              title: const Text(
                                                "Error",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              description:Text(
                                                "Select Order Type",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                maxLines: 1,
                                              ),
                                              width: 300,
                                              height: 100,
                                            ).show(context);
                                          }
                                          else if (orderTypeSelectedValue == "Take Away") {
                                              if (paidAmountController.text.isEmpty) {
                                                ElegantNotification.error(
                                                  title: const Text(
                                                    "Error",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  description: const Text(
                                                    "Enter Amount",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                  ),
                                                  width: 300,
                                                  height: 100,
                                                ).show(context);
                                              }
                                              else if (int.tryParse(paidAmountController.text)! < (subtotal - state.discount)) {
                                                ElegantNotification.error(
                                                  title: const Text(
                                                    "Error",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  description: const Text(
                                                    "Insufficient cash paid!",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    maxLines: 1,
                                                  ),
                                                  width: 300,
                                                  height: 100,
                                                ).show(context);
                                              }
                                              else {
                                                final order = Orders(
                                                  cartItems: state.cartItems.map((e) => Cart(
                                                    productName: e.productName,
                                                    unitPrice: e.unitPrice,
                                                    productID: e.productID,
                                                    quantity: e.quantity,
                                                    price: e.price,
                                                  )).toList(),
                                                  subtotalAmount: subtotal,
                                                  paidAmount: int.tryParse(paidAmountController.text)!,
                                                  netPayableAmount: state.discount == 0 ? subtotal : subtotal - state.discount,
                                                  changeAmount: state.changeAmount,
                                                  orderDate: DateTime.now().toIso8601String(),
                                                  tableNumber: "",
                                                  discountAmount: discountController.text.isEmpty ? 0 : int.tryParse(discountController.text)!,
                                                  customerPhoneNumber: customerNumberController.text.isEmpty ? "" : customerNumberController.text.toString(),
                                                  orderType: orderTypeSelectedValue!,
                                                  branchId: homeLoadedState.branchModel.id,
                                                  branchName: homeLoadedState.branchModel.name,
                                                  managerId: homeLoadedState.branchModel.managerId,
                                                  managerName: homeLoadedState.branchModel.managerName,
                                                  branchPhoneNumber: homeLoadedState.branchModel.branchPhoneNumber,
                                                  branchAddress: homeLoadedState.branchModel.address,
                                                  paymentMode: paymentModeSelectValue,
                                                  paymentStatus: "Done",
                                                  syncStatus: false,
                                                  branchBinNumber: homeLoadedState.branchModel.branchBinNumber,
                                                  invoiceNumber: generateInvoiceNumber()
                                                );
                                                context.read<CartBloc>().add(PlaceOrder(orders: order));

                                                await printReq(order);
                                                discountController.clear();
                                                paidAmountController.clear();
                                                customerNumberController.clear();
                                                orderTypeSelectedValue = orderTypeSelectedValue;
                                              }
                                            }
                                          else if(orderTypeSelectedValue=="Dine In"){
                                          }else if(orderTypeSelectedValue=="Delivery"){

                                          }

                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 40),
                                          backgroundColor:
                                          ColorConstants.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
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
                    ],
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Text(
                      '${state.errorSource}: ${state.message}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          );
        } else if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthError) {
          return Center(
              child: Text(state.message,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium));
        }
        return const SizedBox();
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.read<CartBloc>().add(AddToCart(product: product));
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    product.image,
                    height: 60,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tk ${product.price}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          product.type == "package"
                              ? ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Select Variation"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: product.variations
                                            .map((variation) {
                                          return ListTile(
                                            title: Text(
                                                "Person: ${variation
                                                    .personCount}"),
                                            subtitle: Text(
                                                "Price: Tk ${variation.price}"),
                                            onTap: () {
                                              context
                                                  .read<CartBloc>()
                                                  .add(AddToCart(
                                                  product: product,
                                                  variation:
                                                  variation));
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                color: Colors.red)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(70, 10),
                              padding: const EdgeInsets.all(0),
                              backgroundColor:
                              ColorConstants.primaryColor,
                            ),
                            child: Text(
                              "Person",
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        product.type == "package"
            ? const CornerBanner(
          bannerPosition: CornerBannerPosition.topLeft,
          bannerColor: ColorConstants.primaryColor,
          child: Text("Package"),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}
