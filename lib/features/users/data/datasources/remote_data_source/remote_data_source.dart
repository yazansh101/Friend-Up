import 'package:movie_app/features/auth/domain/entities/user_entity.dart';

abstract class UsersRemoteDataSource {
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getUserData(String uid);
  Future<void> updateUserData(UserEntity user);
  Future<void> followUnFollowUser(UserEntity user);
}
