import 'package:movie_app/core/service_locator/service_locator.dart';
import 'package:movie_app/features/posts/data/datasources/remote/posts_remote_data_source.dart';
import 'package:movie_app/features/posts/domain/repositories/posts_domain_repo.dart';

void initServiceLocator() {
  ///Data Source
  getIt.registerSingleton<PostsRemoteDataSource>(PostsRemoteDataSourceImpl(
    firebaseAuth: getIt(),
    firebaseFirestore: getIt(),
    firebaseStorage: getIt(),
  ));

  ///Repository
  getIt.registerSingleton<PostsDomainRepository>(
    getIt(),
  );

  ///UseCases

  ///Blocs
}
