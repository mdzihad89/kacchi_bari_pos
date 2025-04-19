class CashFilter {
  String branchId;
  String? cashDate;
  String pageLimit;
  String? pageToken;

  CashFilter({
    required this.branchId,
    this.cashDate,
    required this.pageLimit,
    this.pageToken,
  });

  Map<String,dynamic> toQueryParams(){
    return {
      'branchId': branchId,
      'limit': pageLimit,
      if(cashDate != null) 'cashDate': cashDate,
      if(pageToken != null) 'pageToken': pageToken,
    };
  }

  @override
  String toString() {
    return 'CashFilter{branchId: $branchId, cashDate: $cashDate, pageLimit: $pageLimit, pageToken: $pageToken}';
  }
}
