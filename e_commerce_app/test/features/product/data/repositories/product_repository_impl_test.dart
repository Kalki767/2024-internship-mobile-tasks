import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../user/helpers/test_helper.mocks.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl productRepositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockUserLocalDataSource mockUserLocalDataSource;

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo,
        userLocalDataSource: mockUserLocalDataSource);
  });

  const productmodel = ProductModel(
      productid: '6672776eb905525c145fe0bb',
      name: 'Shoe',
      description: 'Leather Shoe',
      price: 200,
      imageUrl: '');

  const productEntity = Product(
      productid: '6672776eb905525c145fe0bb',
      name: 'Shoe',
      description: 'Leather Shoe',
      price: 200,
      imageUrl: '');
  const productid = '6672776eb905525c145fe0bb';
  const token = 'mock_token'; // Example token

  group('should get all products', () {
    test('Should return product entity', () async {
      // arrange
      when(mockUserLocalDataSource.getAcessToken())
          .thenAnswer((_) async => token);
      when(mockRemoteDataSource.getAllProducts(token))
          .thenAnswer((_) async => [productmodel]);

      //act
      final call = await productRepositoryImpl.getAllProduct();
      final result = call.getOrElse(() => []);

      //assert
      expect(
        Right(ilist(result)),
        equals(
          Right(ilist([productEntity])),
        ),
      );
    });
  });

  group('should get current product', () {
    test('should return product entity', () async {
      //arrange
      when(mockUserLocalDataSource.getAcessToken())
          .thenAnswer((_) async => token);
      when(mockRemoteDataSource.getProductById(productid, token))
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
        when(mockUserLocalDataSource.getAcessToken())
            .thenAnswer((_) async => token);
        when(mockRemoteDataSource.getProductById(productid, token))
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
        when(mockUserLocalDataSource.getAcessToken())
            .thenAnswer((_) async => token);
        when(mockRemoteDataSource.getProductById(productid, token))
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
