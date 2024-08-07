import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl productRepositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    productRepositoryImpl =
        ProductRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const productmodel = ProductModel(
      productid: '1',
      name: 'shoe',
      description: 'Leather shoe',
      price: 200,
      imageUrl: '');

  const productEntity = Product(
      productid: '1',
      name: 'shoe',
      description: 'Leather shoe',
      price: 200,
      imageUrl: '');
  const productid = '1';
  group('should get current product', () {
    test('should return product entity', () async {
      //arrange

      when(mockRemoteDataSource.getProductById(productid))
          .thenAnswer((realInvocation) async => productmodel);

      //act

      final result = await productRepositoryImpl.getProduct(productid);

      //assert

      expect(result, equals(const Right(productEntity)));
    });

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById(productid))
            .thenThrow(ServerException());

        // act
        final result = await productRepositoryImpl.getProduct(productid);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById(productid))
            .thenThrow(SocketException());

        // act
        final result = await productRepositoryImpl.getProduct(productid);

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
