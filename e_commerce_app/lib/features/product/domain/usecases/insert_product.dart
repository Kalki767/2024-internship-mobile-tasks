import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class InsertProductUseCase {
  final ProductRepository _productRepository;

  InsertProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  Future<Either<Failure, bool>> execute(Product product) {
    return _productRepository.insertProduct(product);
  }
}
