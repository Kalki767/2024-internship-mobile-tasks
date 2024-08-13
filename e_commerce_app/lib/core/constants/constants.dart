class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  static String getProductbyId(String id) => '$baseUrl/$id';

  static String getAllProducts() => '$baseUrl';
}
