import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

class InputConverter {
  InputConverter();
  Either<Failure, int> stringToInteger(String productid) {
    try {
      return Right(int.parse(productid));
    } on FormatException {
      return const Left(InvalidInputFailure('Should return error'));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
