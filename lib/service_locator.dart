import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kachi_bari_pos/core/local/isar_local_data_source.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import 'package:kachi_bari_pos/core/printer/printer_service.dart';
import 'package:kachi_bari_pos/features/expense/data/repositories/cash_repo_impl.dart';
import 'package:kachi_bari_pos/features/expense/domain/repository/cash_repository.dart';
import 'package:kachi_bari_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:kachi_bari_pos/features/home/domain/repository/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app/app_prefs.dart';
import 'core/constants/app_constant.dart';
import 'core/network/api_service.dart';
import 'core/network/dio_factory.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repository/cart_repository.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/contact/data/contact_repo_impl.dart';
import 'features/contact/domain/contact_repository.dart';
import 'features/contact/presentation/bloc/contact_bloc/contact_bloc.dart';
import 'features/expense/data/repositories/expense_repo_impl.dart';
import 'features/expense/domain/repository/expense_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/order/data/repositories/oreder_repository_impl.dart';
import 'features/order/domain/repository/order_repository.dart';
import 'features/order/presentation/bloc/order_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferencesWithCache sharedPreferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String> {AppConstant.TOKEN_KEY,AppPreferences.keyLastUpdatedDate,AppPreferences.keyCurrentSerialNumber},
      ),
  );



  instance.registerLazySingleton<LocalDataSource>(() => IsarLocalDataSource());
  instance.registerLazySingleton<PrintingService>(()=> PrintingService());

  instance.registerLazySingleton<SharedPreferencesWithCache>(() => sharedPreferencesWithCache);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnection()));


  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiService>(() => ApiService(dio,instance(), instance()));
  instance.registerFactory<AuthRepository>(() => AuthRepositoryImpl(instance(), instance(), instance()));
  instance.registerFactory<AuthRepositoryImpl>(() => AuthRepositoryImpl(instance(), instance(), instance()));
  instance.registerFactory<HomeRepository>(() => HomeRepositoryImpl(instance(),instance()));
  instance.registerFactory<CartRepository>(() => CartRepositoryImpl(instance(),instance()));
  instance.registerFactory<OrderRepository>(() => OrderRepositoryImpl(instance(),instance()));
  instance.registerFactory<OrderRepositoryImpl>(() => OrderRepositoryImpl(instance(), instance()));
  instance.registerFactory<ContactRepository>(() => ContactRepoImpl(instance()));
  instance.registerFactory<ContactRepoImpl>(() => ContactRepoImpl(instance()));
  instance.registerFactory<ExpenseRepository>(() => ExpenseRepoImpl(instance()));
  instance.registerFactory<ExpenseRepoImpl>(() => ExpenseRepoImpl(instance()));

  instance.registerFactory<CashRepository>(() => CashReposImpl(instance()));
  instance.registerFactory<CashReposImpl>(() => CashReposImpl(instance()));

  // Register Blocs
  instance.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepository: instance()));
  instance.registerLazySingleton<HomeBloc>(() => HomeBloc( homeRepository: instance(), authBloc: instance()));
  instance.registerLazySingleton<CartBloc>(() => CartBloc(cartRepository: instance(),printingService: instance()));
  instance.registerLazySingleton<OrderBloc>(() => OrderBloc(orderRepository: instance()));
  instance.registerLazySingleton<ContactBloc>(() => ContactBloc(contactRepository: instance(), authBloc: instance()));


  await instance<LocalDataSource>().initDb();





}