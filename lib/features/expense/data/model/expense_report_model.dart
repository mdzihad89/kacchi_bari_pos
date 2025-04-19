import 'dart:convert';

import 'expense_model.dart';

class ExpenseReportModel{
  final List<ExpenseModel> expenses;
  final int todaysCash;
  final int previousDayCash;
  ExpenseReportModel({
    required this.expenses,
    required this.todaysCash,
    required this.previousDayCash,
  });


  factory ExpenseReportModel.fromJson(Map<String, dynamic> json) {
    return ExpenseReportModel(
      expenses: (json['expenses'] as List).map((e) => ExpenseModel.fromJson(e)).toList(),
      todaysCash: (json['todaysCash'] as num).toInt(),
      previousDayCash: (json['previousDayCash'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'todaysCash': todaysCash,
      'previousDayCash': previousDayCash,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}