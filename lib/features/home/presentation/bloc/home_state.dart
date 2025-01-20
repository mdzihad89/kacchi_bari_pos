
import 'package:equatable/equatable.dart';
import 'package:kachi_bari_pos/features/home/data/model/branch_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final BranchModel branchModel;

  const HomeLoaded(this.categories, this.products, this.branchModel);

  @override
  List<Object> get props => [categories, products];
}

class HomeError extends HomeState {
  final String message;
  final String errorSource;

  const HomeError(this.message, this.errorSource);

  @override
  List<Object> get props => [message,errorSource];
}






















