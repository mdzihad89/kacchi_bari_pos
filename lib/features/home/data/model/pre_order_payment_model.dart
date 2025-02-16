class PreOrderPaymentModelOnline {
  String paymentStatus;
  String paymentMode;

  int discountAmount;
  int paidAmount;
  int netPayableAmount;
  int changeAmount;
  String id;

  PreOrderPaymentModelOnline({
    required this.paymentStatus,
    required this.paymentMode,
    required this.discountAmount,
    required this.paidAmount,
    required this.netPayableAmount,
    required this.changeAmount,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "paymentStatus": paymentStatus,
      "paymentMode": paymentMode,
      "discountAmount": discountAmount,
      "paidAmount": paidAmount,
      "netPayableAmount": netPayableAmount,
      "changeAmount": changeAmount,
      "id": id,
    };
  }


}
