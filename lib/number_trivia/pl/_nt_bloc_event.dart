import 'package:meta/meta.dart' show immutable;
import 'package:z_/core/part.dart' show NoProps;

@immutable
abstract class NumberTriviaEvent extends NoProps {}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
