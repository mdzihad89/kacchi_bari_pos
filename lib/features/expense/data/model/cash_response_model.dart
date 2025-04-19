
import 'package:kachi_bari_pos/features/expense/data/model/cash_model.dart';

class CashResponseModel {
  final List<CashModel> cashRecords;
  final String? nextPageToken;

  CashResponseModel({
    required this.cashRecords,
    this.nextPageToken,
  });

  factory CashResponseModel.fromJson(Map<String, dynamic> json) {
    return CashResponseModel(
      cashRecords: (json['cashRecords'] as List<dynamic>)
          .map((e) => CashModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageToken: json['nextPageToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cashRecords': cashRecords.map((e) => e.toJson()).toList(),
      'nextPageToken': nextPageToken,
    };
  }
}