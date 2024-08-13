import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductUseCase {
  final ProductRepository productRepository;

  GetAllProductUseCase(this.productRepository);
  Future<Either<Failure, List<Product>>> execute() {
    return productRepository.getAllProduct();
  }
}
