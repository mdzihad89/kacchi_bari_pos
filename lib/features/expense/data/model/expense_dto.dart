class ExpenseDto{

  final String expenseAmount;
  final String expenseDescription;
  final String branchId;
  final String expenseDate;

  ExpenseDto({
    required this.expenseAmount,
    required this.expenseDescription,
    required this.branchId,
    required this.expenseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'expenseAmount': expenseAmount,
      'expenseDescription': expenseDescription,
      'branchId': branchId,
      'expenseDate': expenseDate,
    };
  }

}