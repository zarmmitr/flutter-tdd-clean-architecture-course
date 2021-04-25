import 'package:dartz/dartz.dart' show Either;

import 'package:clean_architecture_tdd_course/core/error/failures.dart' show Failure;
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart' show NoParams, UseCase;
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/repositories/number_trivia_repository.dart' show NumberTriviaRepository;

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
