
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';
import 'package:movie_app/features/comments/domain/repositories/comments_domain_repository.dart';

class LikeCommentUseCase {
  final CommentsDomainRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}