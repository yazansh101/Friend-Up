import 'package:dartz/dartz.dart';
import 'package:movie_app/core/common/use_case_base.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/posts/domain/entities/post_entity.dart';
import 'package:movie_app/features/posts/domain/repositories/posts_domain_repo.dart';

class CreatePostUseCase extends UseCaseBase<Unit, PostEntity> {
  final PostsDomainRepository repository;

  CreatePostUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(PostEntity param) {
    return repository.createPost(param);
  }
}
