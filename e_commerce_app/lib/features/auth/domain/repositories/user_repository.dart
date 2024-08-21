import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, bool>> signup(
      String name, String email, String password);

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, UserModel>> getme();
}
