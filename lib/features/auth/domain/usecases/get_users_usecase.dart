import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';
import 'package:movie_app/features/auth/domain/repositories/users_domain_repo.dart';

class GetUsersUseCase {
  final UsersDomainRepsitory repository;

  GetUsersUseCase({required this.repository});

  Stream<Either<Failure, List<UserEntity>>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}
