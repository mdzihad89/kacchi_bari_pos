import 'package:isar/isar.dart';
part 'order_model_isar.g.dart';

@collection
class OrderModelIsar {
  Id id ;
  List<CartModelIsar> cartItems;
  int subtotalAmount;
  int paidAmount;
  int changeAmount;
  DateTime orderDate;
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

  OrderModelIsar({
    this.id= Isar.autoIncrement,
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
}

@embedded
class CartModelIsar {
  String? productName;
  int? unitPrice;
  String? productID;
  int? quantity;
  int? price;

  CartModelIsar({
    this.productName,
    this.unitPrice,
    this.productID,
    this.quantity,
    this.price,
  });

  @override
  String toString() {
    return 'CartModelIsar{productName: $productName, unitPrice: $unitPrice, productID: $productID, quantity: $quantity, price: $price}';
  }
}
