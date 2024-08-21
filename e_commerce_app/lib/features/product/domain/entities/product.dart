import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productid;
  final String name;
  final String description;
  final dynamic price;
  final String imageUrl;
  const Product(
      {required this.productid,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [productid, name, description, price, imageUrl];
  }
}
