import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<String> login(String email, String password) {
    throw UnimplementedError();
  }

  Future<bool> signup(String name, String email, String password) {
    throw UnimplementedError();
  }

  Future<UserModel> getme() {
    throw UnimplementedError();
  }
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client _client;

  UserRemoteDataSourceImpl({required http.Client client}) : _client = client;
  @override
  Future<String> login(String email, String password) async {
    Map<String, dynamic> mapper = {'email': email, 'password': password};

    final response = await _client.post(Uri.parse(Urls.login()), body: mapper);

    if (response.statusCode == 201) {
      // Read the response as a string

      // Decode the response to get the JSON object
      final data = json.decode(response.body);
      print(response.body);
      String accessToken = data['data']['access_token'];
      print(accessToken);
      return accessToken;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> signup(String name, String email, String password) async {
    if (name.isEmpty || name.length < 3) {
      throw Exception("Name must be at least 3 characters long");
    }
    if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(email)) {
      throw Exception("Email is not valid");
    }
    if (password.isEmpty || password.length < 6) {
      throw Exception("Password must be at least 6 characters long");
    }

    Map<String, dynamic> mapper = {
      'name': name,
      'email': email,
      'password': password
    };

    final encoded = json.encode(mapper);
    final response = await _client.post(
      Uri.parse(Urls.register()),
      headers: {
        'Content-Type': 'application/json',
      },
      body: encoded,
    );

    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.reasonPhrase);
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getme() async {
    final response = await _client.get(Uri.parse(Urls.getme));

    if (response.statusCode == 200) {
      print(await response.body);
      final data = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(data['data']);
      return userModel;
    } else {
      throw ServerException();
    }
  }
}
