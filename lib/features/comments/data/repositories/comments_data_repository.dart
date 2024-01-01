// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/extensions/exception_extention.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/comments/data/datasources/remote/comments_remote_data_source.dart';
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';
import 'package:movie_app/features/comments/domain/repositories/comments_domain_repository.dart';

class CommentsDataRepository extends CommentsDomainRepository {
  final CommentsRemoteDataSource repostory;
  CommentsDataRepository({
    required this.repostory,
  });

  @override
  Future<Either<Failure, Unit>> createComment(CommentEntity comment) async {
    try {
      await repostory.createComment(comment);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment(CommentEntity comment) async {
    try {
      await repostory.deleteComment(comment);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> likeComment(CommentEntity comment) async {
    try {
      await repostory.likeComment(comment);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure);
    }
  }

  @override
  Stream<Either<Failure, List<CommentEntity>>> readComments(
      String postId) async* {
    try {
      List<CommentEntity> comments = [];
      repostory.readComments(postId).listen((event) {
        comments.addAll(event);
      });
      yield Right(comments);
    } on Exception catch (e) {
      yield Left(e.toFailure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateComment(CommentEntity comment) async {
    try {
      await repostory.updateComment(comment);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.toFailure);
    }
  }
}
