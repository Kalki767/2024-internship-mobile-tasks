import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(String productid);
  Future<Either<Failure, bool>> insertProduct(Product product);
  Future<Either<Failure, bool>> updateProduct(
      String productid, Product product);
  Future<Either<Failure, bool>> deleteProduct(String productid);
  Future<Either<Failure, List<Product>>> getAllProduct();
}
