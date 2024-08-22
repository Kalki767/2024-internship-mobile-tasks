import '../../features/product/domain/entities/product.dart';

class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/products';

  static String getProductbyId(String id) => '$baseUrl/$id';
  static List<Product> allProducts = [];
  static const String base =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/auth';
  static String login() => '$base/login';
  static String register() => '$base/register';
  static const String getme =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me';
}
