class ExpenseFilter {
  String branchId;
  String? expenseDateFrom;
  String? expenseDateTo;
  String? expenseDate;
  String pageLimit;
  String? pageToken;

  ExpenseFilter({
    required this.branchId,
    required this.expenseDateFrom,
    required this.expenseDateTo,
    required this.expenseDate,
    required this.pageLimit,
     this.pageToken,
  });

  Map<String,dynamic> toQueryParams(){
    return {
      'branchId': branchId,
      'limit': pageLimit,
      if(expenseDate != null) 'expenseDate': expenseDate,
      if(expenseDateFrom != null) 'expenseDateFrom': expenseDateFrom,
      if(expenseDateTo != null) 'expenseDateTo': expenseDateTo,
      if(pageToken != null) 'pageToken': pageToken,
    };
  }

  @override
  String toString() {
    return 'ExpenseFilter{branchId: $branchId, expenseDateFrom: $expenseDateFrom, expenseDateTo: $expenseDateTo, expenseDate: $expenseDate, pageLimit: $pageLimit, pageToken: $pageToken}';
  }
}
