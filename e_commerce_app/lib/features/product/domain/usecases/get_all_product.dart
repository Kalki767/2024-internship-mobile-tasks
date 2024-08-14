import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductUseCase {
  final ProductRepository _productRepository;

  GetAllProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;
  Future<Either<Failure, List<Product>>> execute() {
    return _productRepository.getAllProduct();
  }
}
