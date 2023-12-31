
import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  // will not going to store in DB
  final File? imageFile;

  const UserEntity({
    required this.imageFile,
    required this.uid,
    required this.username,
    required this.name,
    required this.bio,
    // required this.website,
    required this.email,
    required this.profileUrl,
    required this.followers,
    required this.following,
    required this.totalFollowers,
    required this.totalFollowing,
    // required this.password,
    // required this.otherUid,
    required this.totalPosts,
  });

  @override
  List<Object?> get props => [
    uid,
    username,
    name,
    bio,
    // website,
    email,
    profileUrl,
    followers,
    following,
    totalFollowers,
    totalFollowing,
    // password,
    // otherUid,
    totalPosts,
    imageFile
  ];


}
