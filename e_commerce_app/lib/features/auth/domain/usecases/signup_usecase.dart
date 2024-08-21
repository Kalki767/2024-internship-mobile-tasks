import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_repository.dart';

class SignupUsecase {
  final UserRepository _signupRepository;

  SignupUsecase({required UserRepository signupRepository})
      : _signupRepository = signupRepository;

  Future<Either<Failure, bool>> signup(
      String name, String email, String password) {
    return _signupRepository.signup(name, email, password);
  }
}
