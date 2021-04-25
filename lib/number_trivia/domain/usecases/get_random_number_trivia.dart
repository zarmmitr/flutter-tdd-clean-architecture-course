import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/failures.dart' show Failure;
import 'package:z_/core/use_case.dart' show NoParams, UseCase;
import 'package:z_/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;
import 'package:z_/number_trivia/domain/repositories/number_trivia_repository.dart' show NumberTriviaRepository;

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
