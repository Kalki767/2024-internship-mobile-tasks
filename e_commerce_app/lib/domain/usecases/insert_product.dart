import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class InsertProduct {
  final ProductRepository productRepository;

  InsertProduct(this.productRepository);

  Future<Either<Failure, void>> call(Product product) {
    return productRepository.insertProduct(product);
  }
}
