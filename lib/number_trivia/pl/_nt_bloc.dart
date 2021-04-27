import 'dart:async' show Stream;

import 'package:bloc/bloc.dart' show Bloc;
import 'package:z_/core/exception.dart' show CacheException, ServerException;
import '../api/nt.dart' show NumberTrivia;
import 'package:dartz/dartz.dart' show Either;
import 'package:meta/meta.dart' show required;

import 'nt_pl.dart';
import 'package:z_/util/input_converter.dart';
import 'package:z_/number_trivia/act/get_concrete_number_trivia.dart';
import 'package:z_/number_trivia/act/get_random_number_trivia.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia = await getConcreteNumberTrivia(integer);
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(null);
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Exception, NumberTrivia> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (exception) => Error(message: _mapExceptionToMessage(exception)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapExceptionToMessage(Exception exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return SERVER_FAILURE_MESSAGE;
      case CacheException:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
