import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../domain/entities/product.dart';
import '../../models/product_model.dart';

abstract class RemoteDataSource {
  Future<bool> deleteProduct(String productid, String token) {
    throw UnimplementedError();
  }

  Future<ProductModel> getProductById(String productid, String token) {
    throw UnimplementedError();
  }

  Future<bool> insertProduct(Product product, String token) {
    throw UnimplementedError();
  }

  Future<bool> updateProduct(String productid, Product product, String token) {
    throw UnimplementedError();
  }

  Future<List<ProductModel>> getAllProducts(String token) {
    throw UnimplementedError();
  }
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client _client;

  RemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<ProductModel> getProductById(String productid, String token) async {
    final response =
        await _client.get(Uri.parse(Urls.getProductbyId(productid)), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts(String token) async {
    List<ProductModel> allProducts = [];
    final response = await _client.get(Uri.parse(Urls.baseUrl),
        headers: {'Authorization': 'Bearer $token'});

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
  Future<bool> insertProduct(Product product, String token) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.baseUrl));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields.addAll({
      'name': product.name,
      'description': product.description,
      'price': '${product.price}',
    });
    request.files.add(await http.MultipartFile.fromPath(
      contentType: MediaType('image', 'png'),
      'image',
      product.imageUrl,
    ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateProduct(
      String productid, Product product, String token) async {
    final Map<String, dynamic> mapper = {
      'name': product.name,
      'description': product.description,
      'price': int.tryParse(product.price),
    };

    final encoded = json.encode(mapper);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request =
        http.Request('PUT', Uri.parse(Urls.getProductbyId(productid)));
    request.body = encoded;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteProduct(String productid, String token) async {
    final response = await _client.delete(
        Uri.parse(Urls.getProductbyId(productid)),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print(await response.body);
      return true;
    } else {
      print(response.reasonPhrase);
      throw ServerException();
    }
  }
}
