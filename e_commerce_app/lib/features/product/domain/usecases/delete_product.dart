import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, bool>> execute(String productid) {
    return productRepository.deleteProduct(productid);
  }
}
