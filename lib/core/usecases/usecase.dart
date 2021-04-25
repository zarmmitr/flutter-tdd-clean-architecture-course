// TODO usecase -> use_case, usecases -> /
import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart' show Equatable;

import 'package:clean_architecture_tdd_course/core/error/failures.dart' show Failure;

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
