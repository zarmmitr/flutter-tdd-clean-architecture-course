import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:z_/core/exception.dart' show CacheException, ServerException;
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
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Exception, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Exception, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await network.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException catch (e) {
        return Left(e);
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException catch (e) {
        return Left(e);
      }
    }
  }
}
