import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/product/domain/entities/product.dart';
import 'package:e_commerce_app/features/product/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late GetProductUseCase getProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductRepository =
        GetProductUseCase(productRepository: mockProductRepository);
  });

  const productDetails = Product(
    productid: '6672776eb905525c145fe0bb',
    name: 'Shoe',
    description: 'Leather Shoe',
    price: 200,
    imageUrl: '',
  );
  const productid = '6672776eb905525c145fe0bb';
  test('should get product', () async {
    when(mockProductRepository.getProduct(productid))
        .thenAnswer((_) async => const Right(productDetails));

    await (getProductRepository.execute(productid));
  });
}
