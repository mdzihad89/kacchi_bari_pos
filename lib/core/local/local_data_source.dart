import 'package:dartz/dartz.dart';
import 'package:kachi_bari_pos/features/home/data/model/category_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/dine_in_payment_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/product_model.dart';

import '../../features/auth/data/model/user_model.dart';
import '../../features/cart/data/model/order_model.dart';
import '../../features/home/data/model/branch_model.dart';
import '../../features/order/data/model/order_filter_model.dart';
import 'model/order_model_isar.dart';

abstract class LocalDataSource{
  Future<bool> initDb();
  Future<Unit> saveUserModel(User user);
  Future<User?> getUserModel();
  Future<Unit> deleteUserModel();
  Future<Unit> saveAllCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getAllCategories();
  Future<Unit> saveAllProducts(List<ProductModel> products);
  Future<List<ProductModel>> getAllProducts();
  Future<Unit> saveBranch(BranchModel branches);
  Future<BranchModel?> getBranch();
  Future<Unit> addOfflineOrder(OrderModel orderModel);
  Future<OfflineOrderResponse> getOfflineAllOrder(OrderFilter orderFilter);
  Future<Unit> deleteOfflineOrder();
  Future<List<OrderModel>> getAllUnsyncOrder();
  Future<OrderModel> updateOrderPayment(dynamic paymentModel,String orderType);



}