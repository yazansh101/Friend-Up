
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';
import 'package:movie_app/features/comments/domain/repositories/comments_domain_repository.dart';

class CreateCommentUseCase {
  final CommentsDomainRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}