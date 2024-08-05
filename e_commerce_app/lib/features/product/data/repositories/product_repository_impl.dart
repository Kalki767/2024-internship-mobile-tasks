import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<Failure, void>> deleteProduct(String productid) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productid) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
