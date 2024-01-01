// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/core/widgets/custom_text_bottun.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/helper/progress_indecator.dart';
import '../../../core/utils/routes.dart';
import '../../../models/user_model.dart';
import '../../../view_models/followers/followers_view_model.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../../view_models/user_posts/user_posts_view_model.dart';
import '../../chat/screens/chat_screen.dart';
import '../../home/widgets/profile_picture_online.dart';
import '../widgets/profile_info.dart';
import '../widgets/user_posts.dart';

class ProfileScreen extends StatelessWidget {
  String userId;
  String userName;
  ProfileScreen({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  fetchUserData(BuildContext context) async {
    final followersViewModel = FollowersViewModel.provider(context);
    final userPostViewModel = UserPostsViewModel.provider(context);
    final userViewModel = UserViewModel.provider(context);

    await followersViewModel.getUserData(userId);
    await userPostViewModel.getUserPosts(userId);
    await userViewModel.getUserData(userId);
  }

  @override
  Widget build(BuildContext context) {
    final followersViewModel = FollowersViewModel.provider(context);
    final userPostViewModel =
        UserPostsViewModel.provider(context, listen: true);
    final userViewModel = UserViewModel.provider(context);
    final followersCount = followersViewModel.userFollowersCount.toString();
    final followingCount = followersViewModel.userFollowingCount.toString();
    final postsCount = userPostViewModel.userPosts.length.toString();

    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: userName,
            fontSize: 18,
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //  await authViewModel.signOut();
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Container(
          decoration: boxDecoration,
          margin: edgeInsets,
          width: double.infinity,
          child: FutureBuilder(
            future: fetchUserData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingIndicator.buildLoadingIndicator();
              } else if (snapshot.hasError) {
                return Center(
                    child: CustomText(
                        text: 'There is an error :( ${snapshot.error} '));
              } else {
                return Column(
                  key: ValueKey(userId),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setVerticalSpace(2),
                    Container(
                      decoration: BoxDecoration(
                          color: getPrimaryColorTheme(),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1)),
                      child: ProfilePictuerOnline(
                        imageUrl: userViewModel.user.imageProfileUrl,
                        radius1: 50,
                        ownerId: userId, // ownerID
                        radius2: 18,
                      ),
                    ),
                    setVerticalSpace(2),
                    CustomText(
                      text: userViewModel.user.bio,
                      fontSize: 13,
                    ),
                    setVerticalSpace(2),
                    _buildButtonOptions(userViewModel.currentUser,
                        userViewModel.user, snapshot, context),
                    setVerticalSpace(3),
                    ProfileInfo(
                      followersCount: followersCount,
                      followingCount: followingCount,
                      postsCount: postsCount,
                    ),
                    setVerticalSpace(4),
                    UserPosts(),
                  ],
                );
              }
            },
          ),
        ));
  }

  var boxDecoration = BoxDecoration(
      color: getColorTheme(),
      boxShadow: const [
        BoxShadow(blurRadius: 5, color: Colors.grey),
      ],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ));
  var edgeInsets = EdgeInsets.only(
    top: SizeConfig.screenHeight * 0.05,
  );

  Widget _buildButtonOptions(
      User currentUser, User user, AsyncSnapshot snapshot, context) {
    final isMe = currentUser.userId == userId;
    if (isMe) {
      return CustomTextButton(
        color: kPrimaryColor,
        text: 'Edite Profile',
        onPressed: () {
          Navigator.pushNamed(context, Routes.editeProfile);
        },
        width: setWidth(30),
        height: setHeight(4),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomTextButton(
              color: kPrimaryColor,
              width: setWidth(28),
              height: setHeight(5),
              text: 'Message',
              onPressed: () {
                log(user.imageProfileUrl);
                final chatId = '$userId${currentUser.userId}';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            args: {
                              'ownerId': userId,
                              'ownerProfileImage': user.imageProfileUrl,
                              'ownerName': userName,
                              'currentUserId': currentUser.userId,
                              'chatId': chatId,
                            },
                          )),
                );
              }),
          Consumer<FollowersViewModel>(
              builder: (context, followersProvider, child) {
            return CustomTextButton(
              color: followersProvider.isFollowed(userId)
                  ? Colors.grey
                  : kPrimaryColor,
              text:
                  followersProvider.isFollowed(userId) ? 'Unfollow' : 'Follow',
              onPressed: () {
                followersProvider.follow(
                    someOneId: userId, currentUserId: currentUser.userId);
              },
              width: setWidth(28),
              height: setHeight(5),
            );
          }),
        ],
      );
    }
  }
}
