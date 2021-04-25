import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/failures.dart' show Failure;
import 'package:z_/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
