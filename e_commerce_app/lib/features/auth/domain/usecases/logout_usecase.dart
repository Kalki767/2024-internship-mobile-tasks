import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_repository.dart';

class LogoutUsecase {
  final UserRepository _userRepository;

  LogoutUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<Failure, bool>> logout() {
    return _userRepository.logout();
  }
}
