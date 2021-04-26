import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/uc.dart' show UseCase;
import '../api/nt.dart' show NumberTrivia, NumberTriviaStore;

class GetRandomNumberTrivia implements UseCase<NumberTrivia, void> {
  final NumberTriviaStore repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Exception, NumberTrivia>> call(void _) async {
    return await repository.getRandomNumberTrivia();
  }
}
