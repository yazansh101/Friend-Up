import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsDomainRepository {
  Future<Either<Failure, Unit>> createPost(PostEntity post);
  Stream<Either<Failure, List<PostEntity>>> readPosts(PostEntity post);
  Stream<Either<Failure, List<PostEntity>>> readSinglePost(String postId);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(PostEntity post);
  Future<Either<Failure, Unit>> likePost(PostEntity post);
}
