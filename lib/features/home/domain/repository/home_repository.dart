import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/features/home/data/model/branch_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/category_model.dart';
import '../../../../core/network/failure.dart';
import '../../../cart/data/model/order_model.dart';
import '../../data/model/product_model.dart';

abstract class HomeRepository{
  Future<Either<Failure, List<CategoryModel>>> getCategoryData();
  Future<Either<Failure, List<ProductModel>>> getProductData();
  Future<Either<Failure, BranchModel>> getBranchData(String branchId);


}