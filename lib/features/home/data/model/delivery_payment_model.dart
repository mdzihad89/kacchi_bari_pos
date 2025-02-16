class DeliveryPaymentModelOnline {
  String paymentStatus;
  String paymentMode;
  int paidAmount;
  int changeAmount;
  String id;

  DeliveryPaymentModelOnline({
    required this.paymentStatus,
    required this.paymentMode,
    required this.paidAmount,
    required this.changeAmount,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "paymentStatus": paymentStatus,
      "paymentMode": paymentMode,
      "paidAmount": paidAmount,
      "changeAmount": changeAmount,
      "id": id,
    };
  }

}