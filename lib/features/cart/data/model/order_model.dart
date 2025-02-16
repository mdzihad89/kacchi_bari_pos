import 'package:uuid/uuid.dart';
import '../../../../core/local/model/order_model_isar.dart';
import 'cart_model.dart';

class OrderModel {
  List<CartItem> cartItems;
  int subtotalAmount;
  int paidAmount;
  int changeAmount;
  String orderDate;
  int discountAmount;
  String customerPhoneNumber;
  int netPayableAmount;
  String orderType;
  String branchId;
  String branchName;
  String managerId;
  String managerName;
  String branchPhoneNumber;
  String branchAddress;
  String paymentMode;
  String paymentStatus;
  String tableNumber;
  String invoiceNumber;
  String branchBinNumber;
  String serialNumber;
  String deliveryAddress;
  String customerName ;
  String deliveryDateAndTime;
  String note;
  String orderStatus;
  int deliveryFee;
  String deliveryBoyName;
  OrderModel({
    required this.cartItems,
    required this.subtotalAmount,
    required this.paidAmount,
    required this.changeAmount,
    required this.orderDate,
    required this.discountAmount,
    required this.customerPhoneNumber,
    required this.netPayableAmount,
    required this.tableNumber,
    required this.orderType,
    required this.branchId,
    required this.branchName,
    required this.managerId,
    required this.managerName,
    required this.branchPhoneNumber,
    required this.branchAddress,
    required this.paymentMode,
    required this.paymentStatus,
    required this.invoiceNumber,
    required this.branchBinNumber,
    required this.serialNumber,
    required this.deliveryAddress,
    required this.customerName ,
    required this.deliveryDateAndTime ,
    required this.note,
    required this.orderStatus ,
    required this.deliveryFee,
    required this.deliveryBoyName,
  });



  Map<String, dynamic> toMap() {
    return {
      'cartItems': cartItems.map((e) => e.toMap()).toList(),
      'subtotalAmount': subtotalAmount,
      'paidAmount': paidAmount,
      'changeAmount': changeAmount,
      'orderDate': orderDate,
      'discountAmount': discountAmount,
      'customerPhoneNumber': customerPhoneNumber,
      'netPayableAmount': netPayableAmount,
      'orderType': orderType,
      'branchId': branchId,
      'branchName': branchName,
      'managerId': managerId,
      'managerName': managerName,
      'branchPhoneNumber': branchPhoneNumber,
      'branchAddress': branchAddress,
      'paymentMode': paymentMode,
      'paymentStatus': paymentStatus,
      'tableNumber': tableNumber,
      'invoiceNumber': invoiceNumber,
      'branchBinNumber': branchBinNumber,
      'serialNumber': serialNumber,
      'deliveryAddress': deliveryAddress,
      'customerName': customerName,
      'deliveryDateAndTime': deliveryDateAndTime,
      'note': note,
      'orderStatus': orderStatus,
      'deliveryFee': deliveryFee,
      'deliveryBoyName': deliveryBoyName,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      cartItems: (json['cartItems'] as List).map((item) => CartItem.fromJson(item)).toList(),
      subtotalAmount: json['subtotalAmount'],
      paidAmount: json['paidAmount'],
      changeAmount: json['changeAmount'],
      orderDate: json['orderDate'],
      discountAmount: json['discountAmount'],
      customerPhoneNumber: json['customerPhoneNumber'],
      netPayableAmount: json['netPayableAmount'],
      tableNumber: json['tableNumber'],
      orderType: json['orderType'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      managerId: json['managerId'],
      managerName: json['managerName'],
      branchPhoneNumber: json['branchPhoneNumber'],
      branchAddress: json['branchAddress'],
      paymentMode: json['paymentMode'],
      paymentStatus: json['paymentStatus'],
      invoiceNumber: json['invoiceNumber'],
      branchBinNumber: json['branchBinNumber'],
      serialNumber: json['serialNumber'],
      deliveryAddress: json['deliveryAddress'],
      customerName: json['customerName'],
      deliveryDateAndTime: json['deliveryDateAndTime'],
      note: json['note'],
      orderStatus: json['orderStatus'],
      deliveryFee: json['deliveryFee'],
      deliveryBoyName: json['deliveryBoyName'],
    );
  }

  @override
  String toString() {
    return 'OrderModel{cartItems: $cartItems, subtotalAmount: $subtotalAmount, paidAmount: $paidAmount, changeAmount: $changeAmount, orderDate: $orderDate, discountAmount: $discountAmount, customerPhoneNumber: $customerPhoneNumber, netPayableAmount: $netPayableAmount, orderType: $orderType, branchId: $branchId, branchName: $branchName, managerId: $managerId, managerName: $managerName, branchPhoneNumber: $branchPhoneNumber, branchAddress: $branchAddress, paymentMode: $paymentMode, paymentStatus: $paymentStatus, tableNumber: $tableNumber, invoiceNumber: $invoiceNumber, branchBinNumber: $branchBinNumber, serialNumber: $serialNumber, deliveryAddress: $deliveryAddress, customerName: $customerName, deliveryDateAndTime: $deliveryDateAndTime, note: $note, orderStatus: $orderStatus, deliveryFee: $deliveryFee, deliveryBoyName: $deliveryBoyName}';
  }
}


class OfflineOrderResponse {
  final List<OrderModel> orders;
  final String? nextPageToken;

  OfflineOrderResponse({
    required this.orders,
    this.nextPageToken,
  });

  factory OfflineOrderResponse.fromJson(Map<String, dynamic> json) {
    return OfflineOrderResponse(
      orders: (json['orders'] as List).map((item) => OrderModel.fromJson(item)).toList(),
      nextPageToken: json['nextPageToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((order) => order.toMap()).toList(),
      'nextPageToken': nextPageToken,
    };
  }
}
