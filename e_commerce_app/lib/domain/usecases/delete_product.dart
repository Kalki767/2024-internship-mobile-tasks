import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(int productid) {
    return productRepository.deleteProduct(productid);
  }
}
