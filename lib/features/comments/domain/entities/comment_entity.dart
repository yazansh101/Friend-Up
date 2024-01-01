import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String? postId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalReplays;

  const CommentEntity({
    required this.commentId,
    required this.postId,
    required this.creatorUid,
    required this.description,
    required this.username,
    required this.userProfileUrl,
    required this.createAt,
    required this.likes,
    required this.totalReplays,
  });

  @override
  List<Object?> get props => [
    commentId,
    postId,
    creatorUid,
    description,
    username,
    userProfileUrl,
    createAt,
    likes,
    totalReplays,
  ];
}
