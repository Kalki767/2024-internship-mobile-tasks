import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;

  GetProductUseCase(this.productRepository);
  Future<Either<Failure, Product>> execute(String productid) {
    return productRepository.getProduct(productid);
  }
}
