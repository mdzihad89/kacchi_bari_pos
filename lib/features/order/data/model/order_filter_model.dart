class OrderFilter{
  final String branchId;
  final String pageLimit;
  final String? paymentStatus;
  final String? paymentMode;
  final String? orderDate;
  final String? orderDateFrom;
  final String? orderDateTo;
  final String? invoiceNumber;
  final String? customerPhoneNumber;
  final String? pageToken;
  final String? serialNumber;
  final String? orderType;

  OrderFilter({
    required this.branchId,
    required this.pageLimit,
    this.paymentMode,
    this.paymentStatus,
    this.orderDate,
    this.orderDateFrom,
    this.orderDateTo,
    this.invoiceNumber,
    this.customerPhoneNumber,
    this.pageToken,
    this.serialNumber,
    this.orderType,
  });

  Map<String,dynamic> toQueryParams(){
    return {
      'branchId': branchId,
      'limit': pageLimit,
      if(paymentMode != null) 'paymentMode': paymentMode,
      if(paymentStatus != null) 'paymentStatus': paymentStatus,
      if(orderDate != null) 'orderDate': orderDate,
      if(orderDateFrom != null) 'orderDateFrom': orderDateFrom,
      if(orderDateTo != null) 'orderDateTo': orderDateTo,
      if(invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      if(customerPhoneNumber != null) 'customerPhoneNumber': customerPhoneNumber,
      if(pageToken != null) 'pageToken': pageToken,
      if(serialNumber != null) 'serialNumber': serialNumber,
      if(orderType != null) 'orderType': orderType,
    };
  }

  @override
  String toString() {
    return 'OrderFilter{branchId: $branchId, pageLimit: $pageLimit, paymentStatus: $paymentStatus, paymentMode: $paymentMode, orderDate: $orderDate, orderDateFrom: $orderDateFrom, orderDateTo: $orderDateTo, invoiceNumber: $invoiceNumber, customerPhoneNumber: $customerPhoneNumber, pageToken: $pageToken}';
  }
}