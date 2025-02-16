import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../domain/repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  final AuthBloc authBloc;

  HomeBloc({required this.homeRepository, required this.authBloc}) : super(HomeInitial()) {
    on<GetHomeEvent>((event, emit) async {
      emit(HomeLoading());
      final authState = authBloc.state;
      if (authState is Authenticated) {
        final branchId = authState.user.branchId;
        final categoryResult = await homeRepository.getCategoryData();
        final productResult = await homeRepository.getProductData();
        final branchResult = await homeRepository.getBranchData(branchId);
        categoryResult.fold(
              (failure) => emit(HomeError(failure.message, "Category API")),
              (categories) {
            productResult.fold(
                  (failure) => emit(HomeError(failure.message, "Product API")),
                  (products) {
                branchResult.fold(
                      (failure) => emit(HomeError(failure.message, "Branch API")),
                      (branch) => emit(HomeLoaded(categories, products, branch)),
                );
              },
            );
          },
        );
      } else {
        emit(const HomeError("User is not authenticated", "Authentication"));
      }
    });
  }
}