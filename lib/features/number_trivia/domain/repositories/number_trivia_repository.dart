import 'package:dartz/dartz.dart' show Either;

import 'package:clean_architecture_tdd_course/core/error/failures.dart' show Failure;
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
