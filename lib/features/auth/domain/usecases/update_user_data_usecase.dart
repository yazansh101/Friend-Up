
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/common/use_case_base.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';
import 'package:movie_app/features/auth/domain/repositories/users_domain_repo.dart';

class UpdateUserDataUseCase implements UseCaseBase<void, UserEntity> {
  final UsersDomainRepsitory repository;

  UpdateUserDataUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UserEntity user) {
    return repository.updateUserData(user);
  }
}