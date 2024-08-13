import 'dart:convert';

import 'package:e_commerce_app/features/product/data/models/product_model.dart';
import 'package:e_commerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const productModel = ProductModel(
      productid: '6672776eb905525c145fe0bb',
      name: 'Shoe',
      description: 'Leather Shoe',
      price: 200,
      imageUrl: '');

  test('should be an instance of product entity', () async {
    expect(productModel, isA<Product>());
  });

  test('should map correctly', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/fixtures/product_model.json'));
    final result = ProductModel.fromJson(jsonMap);
    expect(result, equals(productModel));
  });

  test('should map tojson correctly', () async {
    final result = productModel.toJson();
    final expectedMap = {
      'productid': '6672776eb905525c145fe0bb',
      'name': 'Shoe',
      'description': 'Leather Shoe',
      'price': 200,
      'imageUrl': ''
    };

    expect(result, equals(expectedMap));
  });
}
