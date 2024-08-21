part of 'product_bloc.dart';

sealed class ProductBlocEvent extends Equatable {
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ProductBlocEvent {}

class GetSingleProductEvent extends ProductBlocEvent {
  final String productid;

  const GetSingleProductEvent(this.productid);
}

class UpdateProductEvent extends ProductBlocEvent {
  final String productid;
  final Product product;

  const UpdateProductEvent(this.productid, this.product);
}

class DeleteProductEvent extends ProductBlocEvent {
  final String productid;

  const DeleteProductEvent(this.productid);
}

class CreateProductEvent extends ProductBlocEvent {
  final Product product;

  const CreateProductEvent(this.product);
}

class FilterProductEvent extends ProductBlocEvent {
  final String text;

  const FilterProductEvent({required this.text});
}
