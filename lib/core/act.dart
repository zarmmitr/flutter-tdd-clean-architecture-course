import 'package:dartz/dartz.dart' show Either;

/// Part of the play
abstract class Act<Return, Param> {
  Future<Either<Exception, Return>> call(Param _);
}
