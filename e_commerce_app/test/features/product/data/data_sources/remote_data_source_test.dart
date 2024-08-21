import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/product/data/data_sources/remote/remote_data_source.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = RemoteDataSourceImpl(client: mockHttpClient);
  });

  const productid = '6672776eb905525c145fe0bb';

  group('get product data', () {
    test('should return 200 as status ok', () async {
      //arrange

      when(mockHttpClient.get(Uri.parse(Urls.getProductbyId(productid))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/fixtures/product_model.json'), 200));

      //act

      final result = await remoteDataSourceImpl.getProductById(productid);

      //assert
      expect(result, isA<ProductModel>());
    });

    test('should return 404 as status wrong', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProductbyId(productid))))
          .thenAnswer((_) async => http.Response('Not found', 404));

      //act
      final result = remoteDataSourceImpl.getProductById(productid);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
