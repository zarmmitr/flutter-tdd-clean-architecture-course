import 'package:data_connection_checker/data_connection_checker.dart' show DataConnectionChecker;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'package:z_/util/network.dart' show Network, NetworkImpl;
import 'package:z_/util/input_converter.dart' show InputConverter;
import 'package:z_/number_trivia/data/datasources/number_trivia_local_data_source.dart' show NumberTriviaLocalDataSource, NumberTriviaLocalDataSourceImpl;
import 'package:z_/number_trivia/data/datasources/number_trivia_remote_data_source.dart' show NumberTriviaRemoteDataSource, NumberTriviaRemoteDataSourceImpl;
import 'package:z_/number_trivia/data/repositories/number_trivia_repository_impl.dart' show NumberTriviaRepositoryImpl;
import 'package:z_/number_trivia/domain/repositories/number_trivia_repository.dart' show NumberTriviaRepository;
import 'package:z_/number_trivia/domain/usecases/get_concrete_number_trivia.dart' show GetConcreteNumberTrivia;
import 'package:z_/number_trivia/domain/usecases/get_random_number_trivia.dart' show GetRandomNumberTrivia;
import 'package:z_/number_trivia/presentation/bloc/number_trivia_bloc.dart' show NumberTriviaBloc;

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
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      network: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
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
