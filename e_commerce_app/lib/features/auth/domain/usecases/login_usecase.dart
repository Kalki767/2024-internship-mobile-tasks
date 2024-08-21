import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_repository.dart';

class LoginUsecase {
  final UserRepository _loginRepository;

  LoginUsecase({required UserRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<Either<Failure, String>> login(String email, String password) {
    return _loginRepository.login(email, password);
  }
}
