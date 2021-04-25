import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:meta/meta.dart' show required;

import 'package:z_/core/failures.dart' show Failure;
import 'package:z_/core/use_case.dart' show UseCase;
import 'package:z_/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;
import 'package:z_/number_trivia/domain/repositories/number_trivia_repository.dart' show NumberTriviaRepository;

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
