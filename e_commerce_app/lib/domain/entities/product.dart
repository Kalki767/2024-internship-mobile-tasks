import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? productid;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  const Product(
      {this.productid, this.name, this.description, this.price, this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [productid, name, description, price, imageUrl];
  }
}
