import '../../domain/entities/product.dart';

class ProductModel extends Product {
  final String productid;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  const ProductModel(
      {required this.productid,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl})
      : super(
            productid: productid,
            name: name,
            description: description,
            price: price,
            imageUrl: imageUrl);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productid: json['productid'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'productid': productid,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };
}
