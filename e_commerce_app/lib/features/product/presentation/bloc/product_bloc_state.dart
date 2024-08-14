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
  final bool deleted;
  SuccessfulDelete(this.deleted);
  @override
  List<Object> get props => [deleted];
}

final class SuccesfulUpdate extends ProductBlocState {
  final bool updated;
  SuccesfulUpdate(this.updated);
  @override
  List<Object> get props => [updated];
}

final class SuccesfulCreate extends ProductBlocState {
  final bool created;
  SuccesfulCreate(this.created);
  @override
  List<Object> get props => [created];
}

final class ErrorState extends ProductBlocState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
