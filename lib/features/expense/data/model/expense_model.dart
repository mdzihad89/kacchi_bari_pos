class ExpenseModel {
  final String id;
  final String expenseAmount;
  final String expenseDescription;
  final String branchId;
  final String expenseDate;

  ExpenseModel({
    required this.id,
    required this.expenseAmount,
    required this.expenseDescription,
    required this.branchId,
    required this.expenseDate,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['_id'] as String,
      expenseAmount: json['expenseAmount'].toString(),
      expenseDescription: json['expenseDescription'] as String,
      branchId: json['branchId'] as String,
      expenseDate: json['expenseDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'expenseAmount': expenseAmount,
      'expenseDescription': expenseDescription,
      'branchId': branchId,
      'expenseDate': expenseDate,
    };
  }
}