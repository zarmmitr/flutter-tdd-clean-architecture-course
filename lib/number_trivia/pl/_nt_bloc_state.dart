import 'package:z_/core/part.dart' show NoProps;

import '../api/nt.dart' show NumberTrivia;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:meta/meta.dart' show immutable, required;

@immutable
abstract class NumberTriviaState extends Equatable with NoProps {}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
