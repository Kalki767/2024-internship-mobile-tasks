import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/data/data_sources/local_datasource.dart';
import 'features/auth/data/data_sources/remote_datasource.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/get_me_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/bloc/user_bloc.dart';
import 'features/product/data/data_sources/local/local_data_source.dart';
import 'features/product/data/data_sources/remote/remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_product.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features

  //bloc
  sl.registerFactory(() => ProductBloc(
      getAllProductsUsecase: sl(),
      getProductUsecase: sl(),
      updateProductUsecase: sl(),
      insertProductUsecase: sl(),
      deleteProductUsecase: sl()));

  sl.registerFactory(() => UserBloc(
      loginUsecase: sl(),
      logoutUsecase: sl(),
      signupUsecase: sl(),
      getMeUsecase: sl()));

  //usecase
  sl.registerFactory(() => GetAllProductUseCase(productRepository: sl()));
  sl.registerFactory(() => GetProductUseCase(productRepository: sl()));
  sl.registerFactory(() => DeleteProductUseCase(productRepository: sl()));
  sl.registerFactory(() => InsertProductUseCase(productRepository: sl()));
  sl.registerFactory(() => UpdateProductUseCase(productRepository: sl()));

  sl.registerFactory(() => LoginUsecase(loginRepository: sl()));
  sl.registerFactory(() => LogoutUsecase(userRepository: sl()));
  sl.registerFactory(() => SignupUsecase(signupRepository: sl()));
  sl.registerFactory(() => GetMeUsecase(userRepository: sl()));
  //repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl(), userLocalDataSource: sl()));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  //Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  //External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
