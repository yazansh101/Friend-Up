// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/core/helper/navigator_service.dart';
import 'package:provider/provider.dart';

import '../../../models/post_model.dart';
import '../../../view_models/time_line/time_line_view_model.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../posts/screens/post_comments_screen.dart';
import '../../posts/widgets/post_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;
  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    log('build postDetailsScreen');
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final timeLinePostsViewModel =
        Provider.of<TimeLinePostsViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(userViewModel, context, timeLinePostsViewModel),
    );
  }

  Padding _buildBody(UserViewModel userViewModel, BuildContext context,
      TimeLinePostsViewModel timeLinePostsViewModel) {
    log(post.likes.length.toString());
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: PostWidget(
          postId: post.id,
          postOwnerId: post.ownerId,
          onComment: () {
            NavigatorService.pushFadeTransition(
              context,
              CommentsScreen(postId: post.id),
            );
          },
          onLike: () {
            timeLinePostsViewModel.likePost(
                postId: post.id, userId: userViewModel.currentUser.userId);
          },
          time: post.timestamp.toIso8601String(),
          userName: post.ownerName,
          discription: post.discription,
          imageUrl: post.mediaUrl),
    );
  }
}
