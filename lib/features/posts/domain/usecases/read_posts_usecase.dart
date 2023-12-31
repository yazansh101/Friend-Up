import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/features/posts/domain/entities/post_entity.dart';
import 'package:movie_app/features/posts/domain/repositories/posts_domain_repo.dart';

class ReadPostsUseCase {
  final PostsDomainRepository repository;

  ReadPostsUseCase({required this.repository});

   Stream<Either<Failure, List<PostEntity>>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}