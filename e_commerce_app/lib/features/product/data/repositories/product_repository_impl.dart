import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote/remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, void>> deleteProduct(String productid) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productid) async {
    try {
      final result = await remoteDataSource.getProductById(productid);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) {
    throw UnimplementedError();
  }
}