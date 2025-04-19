import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/features/expense/data/model/expense_report_model.dart';
import '../../../../core/network/failure.dart';
import '../../data/model/expense_dto.dart';
import '../../data/model/expense_filter.dart';
import '../../data/model/expense_model.dart';
import '../../data/model/expense_report_dto.dart';
import '../../data/model/expense_response_model.dart';


abstract class ExpenseRepository {
  Future<Either<Failure, ExpenseResponseModel>> getExpenses( ExpenseFilter expenseFilter);
  Future<Either<Failure, ExpenseModel>> addExpenses(ExpenseDto expenseDto);
  Future<Either<Failure,ExpenseReportModel>> getExpenseReport(ExpenseReportDTO expenseReportDTO);

}