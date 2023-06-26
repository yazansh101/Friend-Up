import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/view_models/followers/followers_view_model.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/user_card.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});
  @override
  Widget build(BuildContext context) {

    final followersViewModel = Provider.of<FollowersViewModel>(context,listen: false);
    final List followers = followersViewModel.myFollowers!;
    log(followers[0].email);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Followers'),
        ),
        body: _buildFollowersList(followers));
  }

  AnimationLimiter _buildFollowersList(List followers) {
    return AnimationLimiter(
        child: ListView.builder(
          itemCount: followers.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: UserCard(
                  name: followers[index].userName,
                  userId: followers[index].userId,
                  userImageUrl: followers[index].imageProfileUrl,
                )),
              ),
            );
          },
        ),
      );
  }
}
