import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'product/data/data_sources/local/local_data_source.dart';
import 'product/data/data_sources/remote/remote_data_source.dart';
import 'product/data/repositories/product_repository_impl.dart';
import 'product/domain/repositories/product_repository.dart';
import 'product/domain/usecases/delete_product.dart';
import 'product/domain/usecases/get_all_product.dart';
import 'product/domain/usecases/get_product.dart';
import 'product/domain/usecases/insert_product.dart';
import 'product/domain/usecases/update_product.dart';
import 'product/presentation/bloc/product_bloc.dart';

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

  //usecase
  sl.registerSingleton(() => GetAllProductUseCase(productRepository: sl()));
  sl.registerSingleton(() => GetProductUseCase(productRepository: sl()));
  sl.registerSingleton(() => DeleteProductUseCase(productRepository: sl()));
  sl.registerSingleton(() => InsertProductUseCase(productRepository: sl()));
  sl.registerSingleton(() => UpdateProductUseCase(productRepository: sl()));

  //repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  //External
  final sharedpreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedpreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
