class OrderStatusUpdateModel {
  String orderStatus;
  String id;

  OrderStatusUpdateModel({
    required this.orderStatus,

    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderStatus": orderStatus,
      "id": id,
    };
  }
}

class OrderStatusUpdateModelOffline{
  String orderStatus;
  String invoiceNumber;

  OrderStatusUpdateModelOffline({
    required this.orderStatus,

    required this.invoiceNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderStatus": orderStatus,
      "invoiceNumber": invoiceNumber,
    };
  }
}