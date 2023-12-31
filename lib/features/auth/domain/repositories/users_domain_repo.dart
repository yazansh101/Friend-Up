import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';

abstract class UsersDomainRepsitory {
  Stream<Either<Failure, List<UserEntity>>> getUsers(UserEntity user);
  Stream<Either<Failure, List<UserEntity>>> getUserData(
      String userId);
  Future<Either<Failure, void>> followUnFollowUser(UserEntity user);
  Future<Either<Failure, void>> updateUserData(UserEntity user);
}
