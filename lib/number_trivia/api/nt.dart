import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:meta/meta.dart' show required;
import 'package:z_/core/failures.dart' show Failure;

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    @required this.text,
    @required this.number,
  });

  @override
  List<Object> get props => [text, number];
}

abstract class NumberTriviaStore {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}