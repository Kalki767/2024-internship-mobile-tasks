import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('should convert string to integer', () {
    test('succesfully converted to integer', () {
      //arrange
      String productid = '123';

      //act
      final result = inputConverter.stringToInteger(productid);

      //assert

      expect(result, const Right(123));
    });

    test('should return a failure when the string cannot be converted', () {
      //arrange
      String productid = 'abc';

      //act
      final result = inputConverter.stringToInteger(productid);

      //assert
      expect(result, const Left(InvalidInputFailure('Should return error')));
    });
  });
}
