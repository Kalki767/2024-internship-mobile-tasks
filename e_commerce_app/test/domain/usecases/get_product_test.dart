import 'package:e_commerce_app/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    GetProductUseCase(mockProductRepository);
  });
}
