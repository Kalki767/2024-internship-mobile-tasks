import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetMeUsecase {
  final UserRepository _userRepository;

  GetMeUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<Failure, UserModel>> getme() {
    return _userRepository.getme();
  }
}
