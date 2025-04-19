import 'dart:convert';

class CashDTO {
  final String cashDate;
  final int currentCash;
  final String branchId;


  CashDTO({
    required this.cashDate,
    required this.currentCash,
    required this.branchId,
  });


  Map<String, dynamic> toJson() {
    return {
      'cashDate': cashDate,
      'currentCash': currentCash,
      'branchId': branchId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
