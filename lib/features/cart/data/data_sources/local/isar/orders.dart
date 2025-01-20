import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'orders.g.dart';

@collection
class Orders {
  Id id = Isar.autoIncrement;
  String orderId ;
  List<Cart> cartItems;
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
  bool syncStatus = false;

  Orders({
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
    required this.syncStatus,
    required this.invoiceNumber,
    required this.branchBinNumber,
  }):orderId= const Uuid().v4();
}

@embedded
class Cart {
  String? productName;
  int? unitPrice;
  String? productID;
  int? quantity;
  int? price;

  Cart({
 this.productName,
  this.unitPrice,
     this.productID,
     this.quantity,
    this.price,
  });

}
