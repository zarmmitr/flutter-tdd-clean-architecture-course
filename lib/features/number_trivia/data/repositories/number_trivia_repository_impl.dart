import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:clean_architecture_tdd_course/core/error/failures.dart' show CacheFailure, Failure, ServerFailure;
import 'package:clean_architecture_tdd_course/core/error/exceptions.dart' show CacheException, ServerException;
import 'package:clean_architecture_tdd_course/core/network/network_info.dart' show NetworkInfo;
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart' show NumberTrivia;
import '../../domain/repositories/number_trivia_repository.dart' show NumberTriviaRepository;
import '../datasources/number_trivia_local_data_source.dart' show NumberTriviaLocalDataSource;
import '../datasources/number_trivia_remote_data_source.dart' show NumberTriviaRemoteDataSource;

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
