import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../domain/entities/product.dart';
import '../../models/product_model.dart';

abstract class RemoteDataSource {
  Future<bool> deleteProduct(String productid) {
    throw UnimplementedError();
  }

  Future<ProductModel> getProductById(String productid) {
    throw UnimplementedError();
  }

  Future<bool> insertProduct(Product product) {
    throw UnimplementedError();
  }

  Future<bool> updateProduct(String productid, Product product) {
    throw UnimplementedError();
  }

  Future<List<ProductModel>> getAllProducts() {
    throw UnimplementedError();
  }
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client _client;

  RemoteDataSourceImpl({required client}) : _client = client;

  @override
  Future<ProductModel> getProductById(String productid) async {
    final response =
        await _client.get(Uri.parse(Urls.getProductbyId(productid)));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> allProducts = [];
    final response = await _client.get(Uri.parse(Urls.baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['data']
          .forEach((el) async => {allProducts.add(ProductModel.fromJson(el))});
      return allProducts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> insertProduct(Product product) async {
    final Map<String, String> mapper = {
      'image': product.imageUrl,
      'name': product.name,
      'description': product.description,
      'price': '${product.price}'
    };

    final response =
        await _client.post(Uri.parse(Urls.baseUrl), headers: mapper);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateProduct(String productid, Product product) async {
    final Map<String, String> mapper = {
      'image': product.imageUrl,
      'name': product.name,
      'description': product.description,
      'price': '${product.price}'
    };
    final response = await _client
        .put(Uri.parse(Urls.getProductbyId(productid)), headers: mapper);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteProduct(String productid) async {
    final response = await _client.delete(
      Uri.parse(Urls.getProductbyId(productid)),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }
}
