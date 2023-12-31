import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';

abstract class CommentsDomainRepository {
  Future<Either<Failure, Unit>> createComment(CommentEntity comment);
  Stream<Either<Failure, List<CommentEntity>>> readComments(String postId);
  Future<Either<Failure, Unit>> updateComment(CommentEntity comment);
  Future<Either<Failure, Unit>> deleteComment(CommentEntity comment);
  Future<Either<Failure, Unit>> likeComment(CommentEntity comment);
}
