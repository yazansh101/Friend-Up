import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.imageFile,
      required super.uid,
      required super.username,
      required super.name,
      required super.bio,
      required super.email,
      required super.profileUrl,
      required super.followers,
      required super.following,
      required super.totalFollowers,
      required super.totalFollowing,
      required super.totalPosts});

  factory UserModel.fromSnapshot(DocumentSnapshot snap,[img]) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      imageFile: img ?? '',
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      username: snapshot['username'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      // website: snapshot['website'],
      profileUrl: snapshot['profileUrl'],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "username": username,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "totalPosts": totalPosts,
        //  "website": website,
        "bio": bio,
        "profileUrl": profileUrl,
        "followers": followers,
        "following": following,
      };
}
