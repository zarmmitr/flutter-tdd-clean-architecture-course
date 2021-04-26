import 'package:data_connection_checker/data_connection_checker.dart' show DataConnectionChecker;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:z_/util/network.dart' show Network, NetworkImpl;
import 'package:z_/util/input_converter.dart' show InputConverter;
import 'package:z_/number_trivia/io/nt_local_source.dart' show NumberTriviaLocalSource, NumberTriviaLocalDataSourceImpl;
import 'package:z_/number_trivia/io/nt_remote_source.dart' show NumberTriviaRemoteDataSource, NumberTriviaRemoteDataSourceImpl;
import 'package:z_/number_trivia/io/nt_stores_impl.dart' show NumberTriviaStoreImpl;
import 'package:z_/number_trivia/api/nt.dart' show NumberTriviaStore;
import 'package:z_/number_trivia/use_case/get_concrete_number_trivia.dart' show GetConcreteNumberTrivia;
import 'package:z_/number_trivia/use_case/get_random_number_trivia.dart' show GetRandomNumberTrivia;
import 'package:z_/number_trivia/ploc/nt_ploc.dart' show NumberTriviaBloc;

final sl = GetIt.instance; // TODO sl -> serviceLocator

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaStore>(
    () => NumberTriviaStoreImpl(
      localDataSource: sl(),
      network: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
