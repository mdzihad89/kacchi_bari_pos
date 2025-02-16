class DineInPaymentModel {
  String paymentStatus;
  String paymentMode;
  String customerPhoneNumber;
  int discountAmount;
  int paidAmount;
  int netPayableAmount;
  int changeAmount;
  String invoiceNumber;

  DineInPaymentModel({
    required this.paymentStatus,
    required this.paymentMode,
    required this.customerPhoneNumber,
    required this.discountAmount,
    required this.paidAmount,
    required this.netPayableAmount,
    required this.changeAmount,
    required this.invoiceNumber,
  });
}

class DineInPaymentModelOnline {
  String paymentStatus;
  String paymentMode;
  String customerPhoneNumber;
  int discountAmount;
  int paidAmount;
  int netPayableAmount;
  int changeAmount;
  String id;

  DineInPaymentModelOnline({
    required this.paymentStatus,
    required this.paymentMode,
    required this.customerPhoneNumber,
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
      "customerPhoneNumber": customerPhoneNumber,
      "discountAmount": discountAmount,
      "paidAmount": paidAmount,
      "netPayableAmount": netPayableAmount,
      "changeAmount": changeAmount,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'DineInPaymentModelOnline{paymentStatus: $paymentStatus, paymentMode: $paymentMode, customerPhoneNumber: $customerPhoneNumber, discountAmount: $discountAmount, paidAmount: $paidAmount, netPayableAmount: $netPayableAmount, changeAmount: $changeAmount, id: $id}';
  }
}
