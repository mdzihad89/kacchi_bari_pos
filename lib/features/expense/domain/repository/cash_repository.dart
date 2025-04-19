import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_dto.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_model.dart';
import 'package:kachi_bari_pos/features/expense/data/model/cash_response_model.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/cash_filter.dart';



abstract class CashRepository {
  Future<Either<Failure, CashResponseModel>> getCashRecord( CashFilter cashFilter);
  Future<Either<Failure, CashModel>> addCashRecord(CashDTO  cashDto);
}