import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../models/product_model.dart';

abstract class LocalDataSource {
  Future<ProductModel> getProduct();
  Future<void> cacheProduct();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct() {
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProduct() {
    final jsonString = sharedPreferences.getString('cachedProduct');

    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(json.decode(jsonString)));
    }

    throw CacheException();
  }
}
