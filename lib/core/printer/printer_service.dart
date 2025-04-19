import 'dart:developer';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:usb_esc_printer_windows/usb_esc_printer_windows.dart' as usb_esc_printer_windows;
import 'package:intl/intl.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';

import '../../features/expense/data/model/expense_model.dart';

class PrintingService {
  final String _printerName = "RONGTA 80mm Series Printer";
  late Future<CapabilityProfile> _profile;
  late img.Image posLogo;
  late img.Image posFooter;

  PrintingService() {
    _profile = CapabilityProfile.load();
    _loadPosImage();
  }

  Future<void> _loadPosImage() async {
    final ByteData logoData = await rootBundle.load('assets/svg/pos_logo.png');
    final ByteData footerData = await rootBundle.load(
        'assets/svg/pos_footer.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final Uint8List footerBytes = footerData.buffer.asUint8List();
    posLogo = img.decodeImage(logoBytes)!;
    posFooter = img.decodeImage(footerBytes)!;
  }

  Future<String> printOrder(OrderModel order) async {
    try {
      List<int> bytes = [];
      final profile = await _profile;
      final generator = Generator(PaperSize.mm80, profile);

      if (order.orderType == "Take Away") {
        bytes += generator.image(posLogo, align: PosAlign.center);
        bytes += generator.text(order.branchAddress, styles: const PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontB));
        bytes += generator.text('Phone : ${order.branchPhoneNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.text('Bin : ${order.branchBinNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.feed(1);
        bytes += generator.text('Invoice No:${order.invoiceNumber},',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
            DateTime.parse(order.orderDate))}',
            styles: const PosStyles(align: PosAlign.left));
        if (order.customerPhoneNumber.isNotEmpty) {
          bytes += generator.text(
              'Customer Phone: ${order.customerPhoneNumber}',
              styles: const PosStyles(align: PosAlign.left));
        }
        bytes += generator.text('Payment Mode: ${order.paymentMode}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Order Type: ${order.orderType}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Payment Status: Paid',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.feed(1);

        bytes.addAll(generator.row([
          PosColumn(text: 'S/N.',
              width: 1,
              styles: PosStyles(bold: true, align: PosAlign.left)),
          PosColumn(text: 'Item',
              width: 7,
              styles: PosStyles(bold: true, align: PosAlign.center)),
          PosColumn(text: 'Qty',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total',
              width: 2,
              styles: PosStyles(align: PosAlign.right, bold: true)),
        ]));
        bytes.addAll(generator.hr());
        order.cartItems.asMap().forEach((index, item) {
          bytes.addAll(generator.row([
            PosColumn(text: '${index + 1}.',
                width: 1,
                styles: PosStyles(align: PosAlign.left)),
            PosColumn(text: "${item.productName}.",
                width: 7,
                styles: PosStyles(align: PosAlign.left,
                    fontType: PosFontType.fontA,
                    height: PosTextSize.size1,
                    codeTable: "CP437")),
            PosColumn(text: "${item.quantity.toString()}x${item.unitPrice
                .toString()}",
                width: 2,
                styles: PosStyles(align: PosAlign.center)),
            PosColumn(text: "${item.price.toString()} Tk",
                width: 2,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        });



        bool hasKitchenItem = order.cartItems.any((element) => element.productName.startsWith("Morog") ||element.productName.startsWith("Kacchi") || element.productName.startsWith("Basmati Rice") || element.productName.startsWith("Extra Mutton") || element.productName.startsWith("Extra Chicken"));



        bytes.addAll(generator.hr());
        bytes.addAll(generator.row([
          PosColumn(text: 'Subtotal', width: 8),
          PosColumn(text: "${order.subtotalAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));
        if (order.discountAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Discount', width: 8),
            PosColumn(text: "${order.discountAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }

        bytes.addAll(generator.row([
          PosColumn(text: 'Net Payable', width: 8),
          PosColumn(text: "${order.netPayableAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));

        bytes.addAll(generator.hr());

        bytes.addAll(generator.row([
          PosColumn(text: 'Paid Amount', width: 8),
          PosColumn(text: "${order.paidAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));

        bytes.addAll(generator.row([
          PosColumn(text: 'Change Amount', width: 8),
          PosColumn(text: "${order.changeAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));
        bytes += generator.feed(1);
        bytes += generator.image(posFooter, align: PosAlign.center);
        bytes.addAll(generator.text('Powered by Hundredit.',
            styles: const PosStyles(align: PosAlign.center)));
        bytes += generator.cut();

        if(order.paymentMode=="Cash" &&( order.isOnlyPrint==null || order.isOnlyPrint==false) && !hasKitchenItem){
          bytes += [0x1B, 0x70, 0x00, 0x19, 0xFA];
        }

        if((order.isOnlyPrint==false || order.isOnlyPrint==null) && hasKitchenItem){
          bytes += generator.text(
            'Customer copy',
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
              align: PosAlign.center,
            ),
          );
          bytes += generator.text(
            'Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
                DateTime.parse(order.orderDate))}',
            styles: const PosStyles(
              align: PosAlign.center,
            ),
          );



          // bytes += generator.text(
          //   'Order Type: ${order.orderType}',
          //   styles: const PosStyles(
          //     align: PosAlign.left,
          //   ),
          // );



          bytes += generator.feed(1);


          bytes += generator.text(
            'Token No : ${order.serialNumber}',
            styles: const PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            ),
          );
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
            'Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
                DateTime.parse(order.orderDate))}',
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
          if(order.note.isNotEmpty){
            bytes += generator.text(
              'Note: ${order.note}',
              styles: const PosStyles(
                align: PosAlign.left,
                height: PosTextSize.size1,
                bold: true,
                fontType:  PosFontType.fontB,
              ),
            );
          }
          bytes += generator.feed(1);
          bytes += generator.text(
            'Token No : ${order.serialNumber}',
            styles: const PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            ),
          );



          bytes += generator.feed(1);

          bytes.addAll(generator.row([
            PosColumn(text: 'S/N.',
                width: 1,
                styles: PosStyles(bold: true, align: PosAlign.left)),
            PosColumn(text: 'Item',
                width: 7,
                styles: PosStyles(bold: true, align: PosAlign.center)),
            PosColumn(text: 'Qty',
                width: 2,
                styles: PosStyles(align: PosAlign.center, bold: true)),
            PosColumn(text: 'Price',
                width: 2,
                styles: PosStyles(align: PosAlign.right, bold: true)),
          ]));
          bytes.addAll(generator.hr());
          order.cartItems.asMap().forEach((index, item) {
            bytes.addAll(generator.row([
              PosColumn(text: '${index + 1}.',
                  width: 1,
                  styles: PosStyles(align: PosAlign.left)),
              PosColumn(text: "${item.productName}.",
                  width: 7,
                  styles: PosStyles(align: PosAlign.left,
                      fontType: PosFontType.fontA,
                      height: PosTextSize.size1,
                      codeTable: "CP437")),
              PosColumn(text: "${item.quantity.toString()}x${item.unitPrice
                  .toString()}",
                  width: 2,
                  styles: PosStyles(align: PosAlign.center)),
              PosColumn(text: "${item.price.toString()} Tk",
                  width: 2,
                  styles: PosStyles(align: PosAlign.right)),
            ]));
          });
          bytes += generator.cut();
          if(order.paymentMode=="Cash" &&( order.isOnlyPrint==null || order.isOnlyPrint==false)){
            bytes += [0x1B, 0x70, 0x00, 0x19, 0xFA];
          }
        }


      }







      else if (order.orderType == "Delivery") {
        bytes += generator.image(posLogo, align: PosAlign.center);
        bytes += generator.text(order.branchAddress, styles: const PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontB));
        bytes += generator.text('Phone : ${order.branchPhoneNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.text('Bin : ${order.branchBinNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.feed(1);
        bytes += generator.text('Invoice No:${order.invoiceNumber},',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
            DateTime.parse(order.orderDate))}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Order Type: ${order.orderType}',
            styles: const PosStyles(align: PosAlign.left));

        if (order.paymentStatus == "Done") {
          bytes += generator.text('Payment Status: Paid',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.paymentMode.isNotEmpty) {
          bytes += generator.text('Payment Mode: ${order.paymentMode}',
              styles: const PosStyles(align: PosAlign.left));
        }

        if (order.customerPhoneNumber.isNotEmpty) {
          bytes += generator.text(
              'Customer Phone: ${order.customerPhoneNumber}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.deliveryAddress.isNotEmpty) {
          bytes += generator.text('Delivery Address: ${order.deliveryAddress}',
              styles: const PosStyles(align: PosAlign.left));
        }
        bytes += generator.feed(1);

        bytes.addAll(generator.row([
          PosColumn(text: 'S/N.',
              width: 1,
              styles: PosStyles(bold: true, align: PosAlign.left)),
          PosColumn(text: 'Item',
              width: 7,
              styles: PosStyles(bold: true, align: PosAlign.center)),
          PosColumn(text: 'Qty',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total',
              width: 2,
              styles: PosStyles(align: PosAlign.right, bold: true)),
        ]));
        bytes.addAll(generator.hr());
        order.cartItems.asMap().forEach((index, item) {
          bytes.addAll(generator.row([
            PosColumn(text: '${index + 1}.',
                width: 1,
                styles: PosStyles(align: PosAlign.left)),
            PosColumn(text: "${item.productName}.",
                width: 7,
                styles: PosStyles(align: PosAlign.left,
                    fontType: PosFontType.fontA,
                    height: PosTextSize.size1,
                    codeTable: "CP437")),
            PosColumn(text: "${item.quantity.toString()}x${item.unitPrice
                .toString()}",
                width: 2,
                styles: PosStyles(align: PosAlign.center)),
            PosColumn(text: "${item.price.toString()} Tk",
                width: 2,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        });

        bytes.addAll(generator.hr());
        bytes.addAll(generator.row([
          PosColumn(text: 'Subtotal', width: 8),
          PosColumn(text: "${order.subtotalAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));

        if (order.deliveryFee > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Delivery Fee', width: 8),
            PosColumn(text: "${order.deliveryFee.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }
        if (order.discountAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Discount', width: 8),
            PosColumn(text: "${order.discountAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }

        bytes.addAll(generator.row([
          PosColumn(text: 'Net Payable', width: 8),
          PosColumn(text: "${order.netPayableAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));

        bytes.addAll(generator.hr());


        if (order.paidAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Paid Amount', width: 8),
            PosColumn(text: "${order.paidAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }

        if (order.changeAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Change Amount', width: 8),
            PosColumn(text: "${order.changeAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }
        bytes += generator.feed(1);
        bytes += generator.image(posFooter, align: PosAlign.center);
        bytes.addAll(generator.text('Powered by Hundredit.',
            styles: const PosStyles(align: PosAlign.center)));
        bytes += generator.cut();
        if(order.paymentMode=="Cash" &&( order.isOnlyPrint==null || order.isOnlyPrint==false)){
          bytes += [0x1B, 0x70, 0x00, 0x19, 0xFA];
        }
      }


      else if (order.orderType == "Dine In") {
        bytes += generator.image(posLogo, align: PosAlign.center);
        bytes += generator.text(order.branchAddress, styles: const PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontB));
        bytes += generator.text('Phone : ${order.branchPhoneNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.text('Bin : ${order.branchBinNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.feed(1);
        bytes += generator.text('Invoice No:${order.invoiceNumber},',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
            DateTime.parse(order.orderDate))}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Order Type: ${order.orderType}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text(
            'Payment Status: ${order.paymentStatus == "Pending"
                ? "Due"
                : "paid"}', styles: const PosStyles(align: PosAlign.left));
        if (order.paymentMode.isNotEmpty) {
          bytes += generator.text('Payment Mode: ${order.paymentMode}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.customerPhoneNumber.isNotEmpty) {
          bytes += generator.text(
              'Customer Phone: ${order.customerPhoneNumber}',
              styles: const PosStyles(align: PosAlign.left));
        }
        bytes += generator.text('Table : ${order.tableNumber}',
            styles: const PosStyles(align: PosAlign.left));

        bytes += generator.feed(1);
        bytes.addAll(generator.row([
          PosColumn(text: 'S/N.',
              width: 1,
              styles: PosStyles(bold: true, align: PosAlign.left)),
          PosColumn(text: 'Item',
              width: 7,
              styles: PosStyles(bold: true, align: PosAlign.center)),
          PosColumn(text: 'Qty',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total',
              width: 2,
              styles: PosStyles(align: PosAlign.right, bold: true)),
        ]));
        bytes.addAll(generator.hr());
        order.cartItems.asMap().forEach((index, item) {
          bytes.addAll(generator.row([
            PosColumn(text: '${index + 1}.',
                width: 1,
                styles: PosStyles(align: PosAlign.left)),
            PosColumn(text: "${item.productName}.",
                width: 7,
                styles: PosStyles(align: PosAlign.left,
                    fontType: PosFontType.fontA,
                    height: PosTextSize.size1,
                    codeTable: "CP437")),
            PosColumn(text: "${item.quantity.toString()}x${item.unitPrice
                .toString()}",
                width: 2,
                styles: PosStyles(align: PosAlign.center)),
            PosColumn(text: "${item.price.toString()} Tk",
                width: 2,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        });
        bytes.addAll(generator.hr());

        bytes.addAll(generator.row([
          PosColumn(text: 'Subtotal', width: 8),
          PosColumn(text: "${order.subtotalAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));
        if (order.discountAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Discount', width: 8),
            PosColumn(text: "${order.discountAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }

        bytes.addAll(generator.row([
          PosColumn(text: 'Net Payable', width: 8),
          PosColumn(text: "${order.netPayableAmount.toString()} Tk",
              width: 4,
              styles: PosStyles(align: PosAlign.right)),
        ]));

        bytes.addAll(generator.hr());

        if (order.paidAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Paid Amount', width: 8),
            PosColumn(text: "${order.paidAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }

        if (order.changeAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Change Amount', width: 8),
            PosColumn(text: "${order.changeAmount.toString()} Tk",
                width: 4,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        }
        bytes += generator.feed(1);
        bytes += generator.image(posFooter, align: PosAlign.center);
        bytes.addAll(generator.text('Powered by Hundredit.',
            styles: const PosStyles(align: PosAlign.center)));
        bytes += generator.cut();

        if (order.paymentStatus == "Done" && order.paymentMode == "Cash" &&( order.isOnlyPrint==null || order.isOnlyPrint==false)) {
          bytes += [0x1B, 0x70, 0x00, 0x19, 0xFA];
        }
      }


      else if (order.orderType == "Pre Order") {
        bytes += generator.image(posLogo, align: PosAlign.center);
        bytes += generator.text(order.branchAddress, styles: const PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontB));
        bytes += generator.text('Phone : ${order.branchPhoneNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.text('Bin : ${order.branchBinNumber},',
            styles: const PosStyles(align: PosAlign.center,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                bold: true));
        bytes += generator.feed(1);
        bytes += generator.text('Invoice No:${order.invoiceNumber},',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Date: ${DateFormat('dd-MM-yyyy h:mm a').format(
            DateTime.parse(order.orderDate))}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text('Order Type: ${order.orderType}',
            styles: const PosStyles(align: PosAlign.left));
        bytes += generator.text(
            'Payment Status: ${order.paymentStatus == "Pending"
                ? "Due"
                : "paid"}', styles: const PosStyles(align: PosAlign.left));
        if (order.paymentMode.isNotEmpty) {
          bytes += generator.text('Payment Mode: ${order.paymentMode}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.customerPhoneNumber.isNotEmpty) {
          bytes += generator.text(
              'Customer Phone: ${order.customerPhoneNumber}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.customerName.isNotEmpty) {
          bytes += generator.text('Customer Name: ${order.customerName}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.deliveryAddress.isNotEmpty) {
          bytes += generator.text('Delivery Address: ${order.deliveryAddress}',
              styles: const PosStyles(align: PosAlign.left));
        }

        if (order.deliveryDateAndTime.isNotEmpty) {
          bytes += generator.text(
              'Delivery Date: ${order.deliveryDateAndTime.toString().replaceAll(
                  RegExp(r'[\u00A0\u202F]'), ' ')}',
              styles: const PosStyles(align: PosAlign.left));
        }
        if (order.note.isNotEmpty) {
          bytes += generator.text('Note: ${order.note}',
              styles: const PosStyles(align: PosAlign.left));
        }
        bytes += generator.feed(1);
        bytes.addAll(generator.row([
          PosColumn(text: 'S/N.',
              width: 1,
              styles: PosStyles(bold: true, align: PosAlign.left)),
          PosColumn(text: 'Item',
              width: 7,
              styles: PosStyles(bold: true, align: PosAlign.center)),
          PosColumn(text: 'Qty',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(text: 'Total',
              width: 2,
              styles: PosStyles(align: PosAlign.right, bold: true)),
        ]));
        bytes.addAll(generator.hr());
        order.cartItems.asMap().forEach((index, item) {
          bytes.addAll(generator.row([
            PosColumn(text: '${index + 1}.',
                width: 1,
                styles: PosStyles(align: PosAlign.left)),
            PosColumn(text: "${item.productName}.",
                width: 7,
                styles: PosStyles(align: PosAlign.left,
                    fontType: PosFontType.fontA,
                    height: PosTextSize.size1,
                    codeTable: "CP437")),
            PosColumn(text: "${item.quantity.toString()}x${item.unitPrice
                .toString()}",
                width: 2,
                styles: PosStyles(align: PosAlign.center)),
            PosColumn(text: "${item.price.toString()} Tk",
                width: 2,
                styles: PosStyles(align: PosAlign.right)),
          ]));
        });
        bytes.addAll(generator.hr());

        bytes.addAll(generator.row([
          PosColumn(text: 'Subtotal', width: 8),
          PosColumn(text: "${order.subtotalAmount.toString()} Tk",
              width: 4,
              styles: const PosStyles(align: PosAlign.right)),
        ]));
        if (order.discountAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Discount', width: 8),
            PosColumn(text: "${order.discountAmount.toString()} Tk",
                width: 4,
                styles: const PosStyles(align: PosAlign.right)),
          ]));
        }

        bytes.addAll(generator.row([
          PosColumn(text: 'Net Payable', width: 8),
          PosColumn(text: "${order.netPayableAmount.toString()} Tk",
              width: 4,
              styles: const PosStyles(align: PosAlign.right)),
        ]));

        bytes.addAll(generator.hr());

        if (order.paidAmount > 0) {
          bytes.addAll(generator.row([
            PosColumn(text: 'Paid Amount', width: 8),
            PosColumn(text: "${order.paidAmount.toString()} Tk",
                width: 4,
                styles: const PosStyles(align: PosAlign.right)),
          ]));
        }

        if (order.changeAmount > 0 && order.paymentStatus == "Done") {
          bytes.addAll(generator.row([
            PosColumn(text: 'Change Amount', width: 8),
            PosColumn(text: "${order.changeAmount.toString()} Tk",
                width: 4,
                styles: const PosStyles(align: PosAlign.right)),
          ]));
        }

        if (order.changeAmount < 0 && order.paymentStatus == "Pending") {
          bytes.addAll(generator.row([
            PosColumn(text: 'Due Amount', width: 8),
            PosColumn(text: "${order.changeAmount.abs()} Tk",
                width: 4,
                styles: const PosStyles(align: PosAlign.right)),
          ]));
        }
        bytes += generator.feed(1);
        bytes += generator.image(posFooter, align: PosAlign.center);
        bytes.addAll(generator.text('Powered by Hundredit.',
            styles: const PosStyles(align: PosAlign.center)));
        bytes += generator.cut();
        if(order.paymentMode=="Cash" &&( order.isOnlyPrint==null || order.isOnlyPrint==false)){
          bytes += [0x1B, 0x70, 0x00, 0x19, 0xFA];
        }
      }



      await usb_esc_printer_windows.sendPrintRequest(bytes, _printerName).then((
          res) {
        if (res == "success") {
          return "success";
        } else {
          return "failed";
        }
      },);
      return "failed";
    } catch (e) {
      return "failed";
    }
  }


  Future<String> printExpenseReport(
      {required List<ExpenseModel> expenses,
      required int todaysCash,
      required int previousDayCash,
        required String branchName,
      }) async {
    try {
      List<int> bytes = [];
      final profile = await _profile;
      final generator = Generator(PaperSize.mm80, profile);

      bytes += generator.text('Expense Report', styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true));

      bytes += generator.text( branchName,
          styles: const PosStyles(align: PosAlign.center,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              bold: true));
      bytes += generator.text(
          'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.feed(1);

      bytes.addAll(generator.row([
        PosColumn(text: 'S/N.', width: 1, styles: PosStyles(bold: true, align: PosAlign.left)),
        PosColumn(text: 'Description', width: 5, styles: PosStyles(bold: true, align: PosAlign.center)),
        PosColumn(text: 'Time', width: 3, styles: PosStyles(bold: true, align: PosAlign.center)),
        PosColumn(text: 'Amount', width: 3, styles: PosStyles(align: PosAlign.right, bold: true)),
      ]));
      bytes.addAll(generator.hr());
      expenses.asMap().forEach((index, expense) {
        bytes.addAll(generator.row([
          PosColumn(text: '${index + 1}.',
              width: 1,
              styles: PosStyles(align: PosAlign.left)),
          PosColumn(text: "${expense.expenseDescription}.",
              width: 5,
              styles: PosStyles(align: PosAlign.left,
                  fontType: PosFontType.fontA,
                  height: PosTextSize.size1)),


          PosColumn(text: DateFormat('h:mm a').format(DateTime.parse(expense.expenseDate)).replaceAll(
              RegExp(r'[\u00A0\u202F]'), ' '),
              width: 3,
              styles: PosStyles(align: PosAlign.center)),

          PosColumn(text: "${expense.expenseAmount.toString()} Tk",
              width: 3,
              styles: PosStyles(align: PosAlign.right)),
        ]));
      });
      bytes.addAll(generator.hr());
      int totalExpense = expenses.fold(0, (previousValue, element) => previousValue + int.tryParse(element.expenseAmount)!);
      bytes.addAll(generator.row([
        PosColumn(text: 'Total Expense', width: 9, styles: PosStyles(bold: true, align: PosAlign.left)),
        PosColumn(text: "${totalExpense.toString()} Tk", width: 3, styles: PosStyles( bold: true, align: PosAlign.right)),
      ]));
      bytes.addAll(generator.hr());
      bytes.addAll(generator.row([
        PosColumn(text: "${DateFormat.yMMMMd().format(DateTime.now())..replaceAll(
            RegExp(r'[\u00A0\u202F]'), ' ')} - Cash", width: 9, styles: PosStyles(bold: true, align: PosAlign.left)),
        PosColumn(text: "${todaysCash} Tk", width: 3, styles: PosStyles( align: PosAlign.right)),
      ]));

      bytes.addAll(generator.row([
        PosColumn(text: "${DateFormat.yMMMMd().format(DateTime.now().subtract(Duration(days: 1)))..replaceAll(
            RegExp(r'[\u00A0\u202F]'), ' ')} - Cash", width: 9, styles: PosStyles(bold: true, align: PosAlign.left)),
        PosColumn(text: "${previousDayCash} Tk", width: 3, styles: PosStyles( align: PosAlign.right)),
      ]));
      bytes.addAll(generator.hr());
      int cashDifference = todaysCash - previousDayCash;

      bytes.addAll(generator.row([
        PosColumn(text: 'Cash Difference', width: 9, styles: PosStyles( align: PosAlign.left)),
        PosColumn(text: "${cashDifference.toString()} Tk", width: 3, styles: PosStyles(bold: true, align: PosAlign.right)),
      ]));


      int netSell=totalExpense+cashDifference;

      bytes.addAll(generator.hr());
      bytes.addAll(generator.row([
        PosColumn(text: 'Net Total', width: 9, styles: PosStyles(bold: true, align: PosAlign.left)),
        PosColumn(text: "${netSell.toString()} Tk", width: 3, styles: PosStyles(bold: true, align: PosAlign.right)),
      ]));


      bytes += generator.feed(1);
      bytes.addAll(generator.text('Powered by Hundredit.',
          styles: const PosStyles(align: PosAlign.center)));
      bytes += generator.cut();

      await usb_esc_printer_windows.sendPrintRequest(bytes, _printerName).then((
          res) {
        if (res == "success") {
          return "success";
        } else {
          return "failed";
        }
      },);
      return "failed";
    } catch (e) {
      return "failed";
    }
  }
}