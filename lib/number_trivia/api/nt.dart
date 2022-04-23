import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:meta/meta.dart' show required;

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    required this.text,
    required this.number,
  });

  @override
  List<Object> get props => [text, number];
}

abstract class NumberTriviaStore {
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(int? number);
  Future<Either<Exception, NumberTrivia>> getRandomNumberTrivia();
}