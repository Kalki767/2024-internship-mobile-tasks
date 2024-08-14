import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/insert_product.dart';
import '../../domain/usecases/update_product.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  final GetProductUseCase _getProductUseCase;
  final GetAllProductUseCase _getAllProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final InsertProductUseCase _insertProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  ProductBloc({
    required GetAllProductUseCase getAllProductsUsecase,
    required GetProductUseCase getProductUsecase,
    required UpdateProductUseCase updateProductUsecase,
    required InsertProductUseCase insertProductUsecase,
    required DeleteProductUseCase deleteProductUsecase,
  })  : _getAllProductUseCase = getAllProductsUsecase,
        _getProductUseCase = getProductUsecase,
        _updateProductUseCase = updateProductUsecase,
        _insertProductUseCase = insertProductUsecase,
        _deleteProductUseCase = deleteProductUsecase,
        super(InitialState()) {
    on<GetSingleProductEvent>(
      (event, emit) async {
        emit(LoadingState());

        final result = await _getProductUseCase.execute(event.productid);

        result.fold((failure) {
          emit(const ErrorState(message: 'an error happens'));
        }, (product) {
          emit(LoadedSingleProductState(product: product));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<LoadAllProductEvent>(
      (event, emit) async {
        emit(LoadingState());

        final result = await _getAllProductUseCase.execute();

        result.fold((failure) {
          emit(const ErrorState(message: 'an error happens'));
        }, (allProducts) {
          emit(LoadedAllProductState(allProducts: allProducts));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<DeleteProductEvent>(
      (event, emit) async {
        emit(LoadingState());

        final result = await _deleteProductUseCase.execute(event.productid);

        result.fold((failure) {
          emit(const ErrorState(message: 'an error occured'));
        }, (value) {
          emit(SuccessfulDelete(value));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<UpdateProductEvent>(
      (event, emit) async {
        emit(LoadingState());

        final result =
            await _updateProductUseCase.execute(event.productid, event.product);

        result.fold((failure) {
          emit(const ErrorState(message: 'an error occured'));
        }, (value) {
          emit(SuccesfulUpdate(value));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<CreateProductEvent>(
      (event, emit) async {
        emit(LoadingState());

        final result = await _insertProductUseCase.execute(event.product);

        result.fold((failure) {
          emit(const ErrorState(message: 'an error occured'));
        }, (value) {
          emit(SuccesfulCreate(value));
        });
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
