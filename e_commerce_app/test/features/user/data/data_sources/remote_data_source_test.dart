import 'dart:convert';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../product/helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('should test the remote data source', () {
    const email = 'test@example.com';
    const password = 'password';
    const name = 'name';

    final Map<String, dynamic> mapper = {
      'data': {'access_token': 'test_token'}
    };
    final encoded = jsonEncode(mapper);
    test('should test when the login function works properly', () async {
      //arrange
      when(mockHttpClient.post(Uri.parse(Urls.login()), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(encoded, 201));

      //act
      final result = await remoteDataSourceImpl.login(email, password);

      //assert

      expect(result, equals('test_token'));
    });

    test('should return true when the user registered successfully', () async {
      // Arrange
      when(mockHttpClient.post(
        Uri.parse(Urls.register()),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      )).thenAnswer((_) async => http.Response('true', 201));

      // Act
      final result = await remoteDataSourceImpl.signup(name, email, password);

      // Assert
      expect(result, equals(true));
    });
  });
}
