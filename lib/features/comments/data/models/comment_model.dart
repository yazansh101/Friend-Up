import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/features/comments/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.commentId,
      required super.postId,
      required super.creatorUid,
      required super.description,
      required super.username,
      required super.userProfileUrl,
      required super.createAt,
      required super.likes,
      required super.totalReplays});
  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      createAt: snapshot['createAt'],
      totalReplays: snapshot['totalReplays'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "commentId": commentId,
        "createAt": createAt,
        "totalReplays": totalReplays,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
