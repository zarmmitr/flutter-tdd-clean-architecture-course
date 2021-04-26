import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/failures.dart' show Failure;
import 'package:z_/core/use_case.dart' show NoParams, UseCase;
import '../api/nt.dart' show NumberTrivia, NumberTriviaStore;

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaStore repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
