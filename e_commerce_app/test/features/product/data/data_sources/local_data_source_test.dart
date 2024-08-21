import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/product/data/data_sources/local/local_data_source.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('get last product', () {
    test('should return product model if there is one in shared preference',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(readJson('helpers/fixtures/product_model.json'));

      //act
      final result = await localDataSourceImpl.getProduct();

      //assert
      expect(result, isA<ProductModel>());
    });

    test('should return exception if the cache is empty', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = localDataSourceImpl.getProduct;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
