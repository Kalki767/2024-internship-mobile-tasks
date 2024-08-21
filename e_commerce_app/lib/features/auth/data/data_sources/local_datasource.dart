import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> storeAcesstoken(String token) {
    throw UnimplementedError();
  }

  Future<String?> getAcessToken() {
    throw UnimplementedError();
  }

  Future<bool> logout() {
    throw UnimplementedError();
  }
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  static const String _accessTokenKey = 'ACCESS_TOKEN';
  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_accessTokenKey);
  }

  @override
  Future<void> storeAcesstoken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  @override
  Future<String?> getAcessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<bool> isLogged() async {
    final token = await getAcessToken();
    return token != null;
  }
}
