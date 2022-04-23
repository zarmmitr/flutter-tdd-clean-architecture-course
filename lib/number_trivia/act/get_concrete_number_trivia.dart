import 'package:dartz/dartz.dart' show Either;

import 'package:z_/core/act.dart' show Act;
import '../api/nt.dart' show NumberTrivia, NumberTriviaStore;

class GetConcreteNumberTrivia implements Act<NumberTrivia, int> {
  final NumberTriviaStore store;

  GetConcreteNumberTrivia(this.store);

  @override
  Future<Either<Exception, NumberTrivia>> call(int? number) async {
    return await store.getConcreteNumberTrivia(number);
  }
}
