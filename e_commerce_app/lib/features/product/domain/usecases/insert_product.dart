import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class InsertProductUseCase {
  final ProductRepository productRepository;

  InsertProductUseCase(this.productRepository);

  Future<Either<Failure, bool>> execute(Product product) {
    return productRepository.insertProduct(product);
  }
}
