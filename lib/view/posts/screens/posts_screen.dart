// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/core/helper/navigator_service.dart';
import 'package:movie_app/view/posts/screens/post_comments_screen.dart';
import 'package:movie_app/view/posts/widgets/post_widget.dart';
import 'package:movie_app/view/profile/screens/post_details_screen.dart';
import 'package:movie_app/view_models/activity_feed/activity_feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/size_config.dart';
import '../../../models/post_model.dart';
import '../../../view_models/time_line/time_line_view_model.dart';
import '../../../view_models/user/user_view_model.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  bool isInit = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initAppData();
    _scrollController.addListener(_onScroll);
  }

  initAppData() async {
    await Provider.of<TimeLinePostsViewModel>(context, listen: false)
        .initPosts();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final timeLinePostsViewModel =
        Provider.of<TimeLinePostsViewModel>(context, listen: true);
    return Consumer<UserViewModel>(
        builder: (context, userViewModel, child) => _buildPostsScreenBody(
            context, timeLinePostsViewModel, userViewModel));
  }

  Widget _buildPostsScreenBody(
      BuildContext context,
      TimeLinePostsViewModel timeLinePostsViewModel,
      UserViewModel userViewModel) {
    return RefreshIndicator(
      onRefresh: () async {
        //    return await Provider.of<TimeLinePostsViewModel>(context, listen: false)
        //    .initPosts();
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: _buildPostsItems(timeLinePostsViewModel,
              timeLinePostsViewModel.timeLinePosts!, userViewModel)),
    );
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('fetch');
      final timeLinePostsViewModel =
          Provider.of<TimeLinePostsViewModel>(context, listen: false);
      await timeLinePostsViewModel.fetchNextTimeLinePosts();
      setState(() {});
    }
  }

  Widget _buildPostsItems(TimeLinePostsViewModel timeLinePostsViewModel,
      List<Post> posts, UserViewModel userViewModel) {
    return AnimationLimiter(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildPostItem(context, posts, index,
                    timeLinePostsViewModel, userViewModel),
              ),
            ),
          );
        },
      ),
    );
  }

  GestureDetector _buildPostItem(
      BuildContext context,
      List<Post> posts,
      int index,
      TimeLinePostsViewModel timeLinePostsViewModel,
      UserViewModel userViewModel) {
    return GestureDetector(
      onTap: () {
        NavigatorService.pushFadeTransition(
          context,
          PostDetailsScreen(
            post: posts[index],
          ),
        );
      },
      child: PostWidget(
        ownerProfileImage: posts[index].ownerProfileImage,
          postId: posts[index].id,
          postOwnerId: posts[index].ownerId,
          onComment: () {
            NavigatorService.pushFadeTransition(
              context,
              CommentsScreen(postId: posts[index].id),
            );
          },
          onLike: () {
            try {
              timeLinePostsViewModel.likePost(
                postId: posts[index].id,
                userId: userViewModel.currentUser.userId,
              );
              Provider.of<ActivityFeedViewModel>(context, listen: false)
                  .setLikeActivityFeed(
                postId: posts[index].id,
                userName: posts[index].ownerName,
                mediaUrl: posts[index].mediaUrl,
                postOwnerId: posts[index].ownerId,
                userProfileImage: userViewModel.currentUser.imageProfileUrl,
              );
              log('liked succsesfully!');
            } catch (e) {
              log(e.toString());
            }
          },
          time: posts[index].timestamp.toIso8601String(),
          userName: posts[index].ownerName,
          discription: posts[index].discription,
          imageUrl: posts[index].mediaUrl,

          ),
    );
  }
}
