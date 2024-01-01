import 'package:dartz/dartz.dart';
import 'package:movie_app/core/common/use_case_base.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';
import 'package:movie_app/features/comments/domain/repositories/comments_domain_repository.dart';

class UpdateCommentUseCase extends UseCaseBase<void, CommentEntity> {
  final CommentsDomainRepository repository;

  UpdateCommentUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}
