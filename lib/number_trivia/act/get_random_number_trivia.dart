import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/act.dart' show Act;
import '../api/nt.dart' show NumberTrivia, NumberTriviaStore;

class GetRandomNumberTrivia implements Act<NumberTrivia, void> {
  final NumberTriviaStore repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Exception, NumberTrivia>> call(void _) async {
    return await repository.getRandomNumberTrivia();
  }
}
