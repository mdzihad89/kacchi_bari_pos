class ExpenseReportDTO{

  final String expenseDate;
  final String branchId;

  ExpenseReportDTO({
    required this.expenseDate,
    required this.branchId,
  });



  Map<String, dynamic> toJson() {
    return {
      'expenseDate': expenseDate,
      'branchId': branchId,
    };
  }
}