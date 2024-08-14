import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/product/domain/entities/product.dart';
import 'package:e_commerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetProductUseCase mockGetProductUseCase;
  late MockGetAllProductUseCase mockGetAllProductUseCase;
  late MockDeleteProductUseCase mockDeleteProductUseCase;
  late MockInsertProductUseCase mockInsertProductUseCase;
  late MockUpdateProductUseCase mockUpdateProductUseCase;
  late ProductBloc productBloc;

  setUp(() {
    mockGetAllProductUseCase = MockGetAllProductUseCase();
    mockGetProductUseCase = MockGetProductUseCase();
    mockUpdateProductUseCase = MockUpdateProductUseCase();
    mockInsertProductUseCase = MockInsertProductUseCase();
    mockDeleteProductUseCase = MockDeleteProductUseCase();
    productBloc = ProductBloc(
        mockGetProductUseCase,
        mockGetAllProductUseCase,
        mockDeleteProductUseCase,
        mockInsertProductUseCase,
        mockUpdateProductUseCase);
  });

  const productEntity = Product(
      productid: '6672776eb905525c145fe0bb',
      name: 'Shoe',
      description: 'Leather Shoe',
      price: 200,
      imageUrl: '');
  const productid = '6672776eb905525c145fe0bb';

  test('initial state should be empty', () {
    expect(productBloc.state, InitialState());
  });
  blocTest<ProductBloc, ProductBlocState>(
      'should emit [Loading, ProductLoaded] when data is gotten successfully',
      build: () {
        when(mockGetProductUseCase.execute(productid))
            .thenAnswer((_) async => const Right(productEntity));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productid)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), LoadedSingleProductState(product: productEntity)]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit error when data is not gotten successfully',
      build: () {
        when(mockGetProductUseCase.execute(productid))
            .thenAnswer((_) async => const Left(ServerFailure('Error occurs')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productid)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Error occurs')]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit [Loading state, LoadedAllProducts] when all products are fetched successfully',
      build: () {
        when(mockGetAllProductUseCase.execute())
            .thenAnswer((_) async => const Right([productEntity]));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            LoadingState(),
            LoadedAllProductState(allProducts: const [productEntity])
          ]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit error when all product are not fetched',
      build: () {
        when(mockGetAllProductUseCase.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Error occured')));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Error occured')]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit true when a product is succesfully inserted',
      build: () {
        when(mockInsertProductUseCase.execute(productEntity))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(productEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccesfulCreate(true)]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit an error when a product is not inserted',
      build: () {
        when(mockInsertProductUseCase.execute(productEntity)).thenAnswer(
            (_) async => const Left(ServerFailure('an error occured')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(productEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'an error occured')]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit true when a product is succesfully deleted',
      build: () {
        when(mockDeleteProductUseCase.execute(productid))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productid)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccessfulDelete(true)]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit an error when a product is not deleted',
      build: () {
        when(mockDeleteProductUseCase.execute(productid)).thenAnswer(
            (_) async => const Left(ServerFailure('an error occured')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productid)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'an error occured')]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit true when a product is succesfully updated',
      build: () {
        when(mockUpdateProductUseCase.execute(productid, productEntity))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) =>
          bloc.add(const UpdateProductEvent(productid, productEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [LoadingState(), SuccesfulUpdate(true)]);

  blocTest<ProductBloc, ProductBlocState>(
      'should emit an error when a product is not updated',
      build: () {
        when(mockUpdateProductUseCase.execute(productid, productEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure('an error occured')));
        return productBloc;
      },
      act: (bloc) =>
          bloc.add(const UpdateProductEvent(productid, productEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'an error occured')]);
}
