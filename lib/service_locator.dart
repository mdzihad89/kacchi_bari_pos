import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kachi_bari_pos/core/local/isar_local_data_source.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
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
import 'features/cart/data/data_sources/local/isar/order_local_data_sources_isar.dart';
import 'features/cart/data/data_sources/local/order_local_data_sources.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repository/cart_repository.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferencesWithCache sharedPreferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String> {AppConstant.TOKEN_KEY},
      ),
  );


  // Register DataSources
  instance.registerLazySingleton<LocalDataSource>(() => IsarLocalDataSource());
  instance.registerLazySingleton<OrdersLocalDataSource>(() => OrdersLocalDataSourceIsar());
  //init db




  instance.registerLazySingleton<SharedPreferencesWithCache>(() => sharedPreferencesWithCache);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnection()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton(() => ApiService(dio,instance(), instance()));
  instance.registerFactory<AuthRepository>(() => AuthRepositoryImpl(instance(), instance(), instance()));
  instance.registerFactory<HomeRepository>(() => HomeRepositoryImpl(instance()));
  instance.registerFactory<CartRepository>(() => CartRepositoryImpl(instance()));








  // Register Blocs
  instance.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepository: instance()));
  instance.registerLazySingleton<HomeBloc>(() => HomeBloc( homeRepository: instance(), authBloc: instance()));
  instance.registerLazySingleton<CartBloc>(() => CartBloc(cartRepository: instance()));


  await instance<LocalDataSource>().initDb();
  await instance<OrdersLocalDataSource>().initDb();





}