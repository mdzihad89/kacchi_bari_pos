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