import 'package:uuid/uuid.dart';
import 'cart_model.dart';

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final int subtotalAmount;
  final int paidAmount;
  final int changeAmount;
  final String orderDate;
  final int discountAmount;
  final int netPayableAmount;
  final String customerPhoneNumber;
  final String orderType;
  final String branchId;
  final String branchName;
  final String managerId;
  final String managerName;
  final String branchPhoneNumber;
  final String branchAddress;
  final String paymentMode;
  final String paymentStatus;
  final String tableNumber;
  bool syncStatus ;

  OrderModel({
    required this.items,
    required this.subtotalAmount,
    required this.paidAmount,
    required this.changeAmount,
    required this.orderDate,
    required this.discountAmount,
    required this.netPayableAmount,
    required this.customerPhoneNumber,
    required this.orderType,
    required this.branchId,
    required this.branchName,
    required this.managerId,
    required this.managerName,
    required this.branchPhoneNumber,
    required this.branchAddress,
    required this.paymentMode,
    required this.paymentStatus,
    required this.tableNumber,
    this.syncStatus = false,
  }):orderId= const Uuid().v4();
}