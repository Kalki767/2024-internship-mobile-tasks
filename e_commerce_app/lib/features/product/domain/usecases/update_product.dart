import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _productRepository;

  UpdateProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  Future<Either<Failure, bool>> execute(
      String productid, Product product) {
    return _productRepository.updateProduct(productid, product);
  }
}
