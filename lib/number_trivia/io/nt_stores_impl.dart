import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:z_/core/failures.dart' show CacheFailure, Failure, ServerFailure;
import 'package:z_/core/exceptions.dart' show CacheException, ServerException;
import 'package:z_/util/network.dart' show Network;
import '../api/nt.dart' show NumberTrivia;
import '../api/nt.dart' show NumberTriviaStore;
import 'nt_local_source.dart' show NumberTriviaLocalSource;
import 'nt_remote_source.dart' show NumberTriviaRemoteDataSource;

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaStoreImpl implements NumberTriviaStore {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalSource localDataSource;
  final Network network;

  NumberTriviaStoreImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.network,
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
    if (await network.isConnected) {
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