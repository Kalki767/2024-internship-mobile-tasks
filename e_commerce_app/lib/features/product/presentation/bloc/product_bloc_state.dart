// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState();
}

final class InitialState extends ProductBlocState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends ProductBlocState {
  @override
  List<Object> get props => [];
}

final class LoadedAllProductState extends ProductBlocState {
  List<Product> allProducts;
  LoadedAllProductState({required this.allProducts});

  @override
  List<Object> get props => [allProducts];
}

final class LoadedSingleProductState extends ProductBlocState {
  Product product;
  LoadedSingleProductState({required this.product});

  @override
  List<Object?> get props => [product];
}

final class SuccessfulDelete extends ProductBlocState {
  SuccessfulDelete();
  @override
  List<Object> get props => [];
}

final class SuccesfulUpdate extends ProductBlocState {
  SuccesfulUpdate();
  @override
  List<Object> get props => [];
}

final class SuccesfulCreate extends ProductBlocState {
  SuccesfulCreate();
  @override
  List<Object> get props => [];
}

final class ErrorState extends ProductBlocState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
