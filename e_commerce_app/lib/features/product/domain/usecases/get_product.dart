import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository _productRepository;

  GetProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;
  Future<Either<Failure, Product>> execute(String productid) {
    return _productRepository.getProduct(productid);
  }
}
