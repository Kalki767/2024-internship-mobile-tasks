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
    getProductRepository = GetProductUseCase(mockProductRepository);
  });

  const productDetails = Product(
    productid: '1',
    name: 'shoe',
    description: 'leather shoe',
    price: 200,
    imageUrl: '',
  );
  const productid = '1';
  test('should get product', () async {
    when(mockProductRepository.getProduct(productid))
        .thenAnswer((_) async => const Right(productDetails));

    final result = await (getProductRepository.execute(productid));
  });
}
