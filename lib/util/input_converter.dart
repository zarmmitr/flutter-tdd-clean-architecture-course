import 'package:dartz/dartz.dart' show Either, Left, Right;

class InputConverter {
  Either<Exception, int> stringToUnsignedInteger(String text) {
    try {
      final integer = int.parse(text);
      if (integer < 0)
        throw FormatException("$integer ($text) must not < 0");
      return Right(integer);
    } on FormatException catch(e) {
      return Left(e);
    }
  }
}
