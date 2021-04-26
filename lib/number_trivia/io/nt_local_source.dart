import 'dart:convert' show json;

import 'package:z_/core/exceptions.dart' show CacheException;
import 'package:meta/meta.dart' show required;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'nt_io.dart' show NumberTriviaIn;

abstract class NumberTriviaLocalSource {
  /// Gets the cached [NumberTriviaIn] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaIn> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaIn triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NumberTriviaIn> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaIn.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaIn triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(triviaToCache.toJson()),
    );
  }
}