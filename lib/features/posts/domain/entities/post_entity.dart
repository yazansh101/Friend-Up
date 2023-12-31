import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? postImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createdAt;
  final String? userProfileUrl;

  const PostEntity({
    required this.postId,
    required this.creatorUid,
    required this.username,
    required this.description,
    required this.postImageUrl,
    required this.likes,
    required this.totalLikes,
    required this.totalComments,
    required this.createdAt,
    required this.userProfileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    postId,
    creatorUid,
    username,
    description,
    postImageUrl,
    likes,
    totalLikes,
    totalComments,
    createdAt,
    userProfileUrl,
  ];
}
