import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

import '../../domain/repositories/user_repository.dart';
import '../data_sources/local_datasource.dart';
import '../data_sources/remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(
      {required UserRemoteDataSource remoteDataSource,
      required UserLocalDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final result = await _remoteDataSource.login(email, password);
      await _localDataSource.storeAcesstoken(result);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('a server failure occurs'));
    } on SocketException {
      return const Left(ConnectionFailure('a connection failure occurs'));
    }
  }

  @override
  Future<Either<Failure, bool>> signup(
      String name, String email, String password) async {
    try {
      final result = await _remoteDataSource.signup(name, email, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('a server failure occurs'));
    } on SocketException {
      return const Left(ConnectionFailure('a connection failure occurs'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _localDataSource.logout();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('a server failure occurs'));
    } on SocketException {
      return const Left(ConnectionFailure('a connection failure occurs'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getme() async {
    try {
      final result = await _remoteDataSource.getme();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('a server failure occurs'));
    } on SocketException {
      return const Left(ConnectionFailure('a connection failure occurs'));
    }
  }
}
