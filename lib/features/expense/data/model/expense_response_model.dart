import 'expense_model.dart';

class ExpenseResponseModel {
  final List<ExpenseModel> expenses;
  final String? nextPageToken;

  ExpenseResponseModel({
    required this.expenses,
    this.nextPageToken,
  });

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseResponseModel(
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageToken: json['nextPageToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'nextPageToken': nextPageToken,
    };
  }
}