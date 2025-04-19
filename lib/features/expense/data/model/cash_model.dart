import 'dart:convert';

class CashModel {
  final String id;
  final DateTime cashDate;
  final String branchId;
  final int currentCash;


  CashModel({
    required this.id,
    required this.cashDate,
    required this.branchId,
    required this.currentCash,
  });

  factory CashModel.fromJson(Map<String, dynamic> json) {
    return CashModel(
      id: json['_id'] as String,
      cashDate: DateTime.parse(json['cashDate']),
      branchId: json['branchId'] as String,
      currentCash: (json['currentCash'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'cashDate': cashDate.toIso8601String(),
      'currentCash': currentCash,
      'branchId': branchId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
