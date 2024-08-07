import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../domain/entities/product.dart';
import '../../models/product_model.dart';

abstract class RemoteDataSource {
  Future<void> deleteProduct(String productid) {
    throw UnimplementedError();
  }

  Future<ProductModel> getProductById(String productid) {
    throw UnimplementedError();
  }

  Future<void> insertProduct(Product product) {
    throw UnimplementedError();
  }

  Future<void> updateProduct(Product product) {
    throw UnimplementedError();
  }
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getProductById(String productid) async {
    final response =
        await client.get(Uri.parse(Urls.getProductbyId(productid)));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
