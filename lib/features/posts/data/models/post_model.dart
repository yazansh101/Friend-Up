import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel(
      {required super.postId,
      required super.creatorUid,
      required super.username,
      required super.description,
      required super.postImageUrl,
      required super.likes,
      required super.totalLikes,
      required super.totalComments,
      required super.createdAt,
      required super.userProfileUrl});

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      createdAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      postImageUrl: snapshot['postImageUrl'],
      postId: snapshot['postId'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "createAt": createdAt,
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "postImageUrl": postImageUrl,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
