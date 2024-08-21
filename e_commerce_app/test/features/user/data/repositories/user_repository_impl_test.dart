import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockUserLocalDataSource();
    mockRemoteDataSource = MockUserRemoteDataSource();
    userRepositoryImpl = UserRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });
  const String email = 'abc@example.com';
  const String password = 'password';
  const String accesstokens = 'access_token';
  const String name = 'name';
  const String id = 'id';

  UserModel userModel = UserModel(
      email: email,
      password: password,
      id: id,
      accestoken: accesstokens,
      name: name);

  group('should test the user repository implementation', () {
    test('should check if the login is working successfully', () async {
      //arrange
      when(mockRemoteDataSource.login(email, password))
          .thenAnswer((_) async => accesstokens);

      //act
      final result = await userRepositoryImpl.login(email, password);

      //assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), equals(accesstokens));
    });

    test('should check if the signup is working successfully', () async {
      //arrange
      when(mockRemoteDataSource.signup(name, email, password))
          .thenAnswer((_) async => true);

      //act
      final result = await userRepositoryImpl.signup(name, email, password);

      //assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => true), equals(true));
    });

    test('should check if the logout is working successfully', () async {
      //arrange
      when(mockLocalDataSource.logout()).thenAnswer((_) async => true);

      //act
      final result = await userRepositoryImpl.logout();

      //assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => true), equals(true));
    });

    test('should check if the getme is working properly', () async {
      //arrange
      when(mockRemoteDataSource.getme()).thenAnswer((_) async => userModel);

      //act
      final result = await userRepositoryImpl.getme();

      //assert
      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), equals(userModel));
    });
  });
}
