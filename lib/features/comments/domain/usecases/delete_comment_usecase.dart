

import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';

import '../repositories/comments_domain_repository.dart';

class DeleteCommentUseCase {
  final CommentsDomainRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}