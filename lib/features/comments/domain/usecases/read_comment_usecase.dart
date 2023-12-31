import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';
import 'package:movie_app/features/comments/domain/repositories/comments_domain_repository.dart';

class ReadCommentsUseCase {
  final CommentsDomainRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<Either<Failure, List<CommentEntity>>> call(String postId) {
    return repository.readComments(postId);
  }
}
