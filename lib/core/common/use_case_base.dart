import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';

abstract class UseCaseBase<T, Params> {
  Future<Either<Failure, T>> call(Params param);
}

abstract class UseCaseBaseNoParam<T> {
  Future<Either<Failure, T>> call();
}
