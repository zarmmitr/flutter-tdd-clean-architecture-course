import 'package:dartz/dartz.dart' show Either;

abstract class UseCase<Return, Param> {
  Future<Either<Exception, Return>> call(Param _);
}
