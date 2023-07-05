// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/core/widgets/custom_text_bottun.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/helper/progress_indecator.dart';
import '../../../core/utils/routes.dart';
import '../../../models/user_model.dart';
import '../../../view_models/auth/auth_view_model.dart';
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
    final followersViewModel =
        Provider.of<FollowersViewModel>(context, listen: false);
    final UserPostsViewModel userPostViewModel =UserPostsViewModel.provider(context);
       
    await followersViewModel.getUserData(userId);
    await userPostViewModel.getUserPosts(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  var boxDecoration = BoxDecoration(
      color: getColorTheme(),
      boxShadow: const [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey
        ),
      ],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ));
  var edgeInsets = EdgeInsets.only(
    top: SizeConfig.screenHeight * 0.05,
  );

  Container _buildBody(context) {
    final followersViewModel =
        Provider.of<FollowersViewModel>(context, listen: false);
    final userPostViewModel = Provider.of<UserPostsViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final User currentUser = userViewModel.currentUser;

    return Container(
      decoration: boxDecoration,
      margin: edgeInsets,
      width: double.infinity,
      child: FutureBuilder(
        future: fetchUserData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator.buildLoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: CustomText(text: 'There is an error :( ${snapshot.error} '));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                setVerticalSpace(2),
                _buildProfileImage(currentUser.imageProfileUrl, userId),
                setVerticalSpace(1),
                _buildBio(currentUser),
                setVerticalSpace(1),
                _buildButtonOptions(currentUser, snapshot, context),
                setVerticalSpace(4),
                _buildUserInfo(followersViewModel, userPostViewModel),
                setVerticalSpace(4),
                UserPosts(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildUserInfo(followersViewModel, userPostViewModel) {
    final followersCount = followersViewModel.userFollowersCount.toString();
    final followingCount = followersViewModel.userFollowingCount.toString();
    final postsCount = userPostViewModel.userPosts.length.toString();

    return ProfileInfo(
      followersCount: followersCount,
      followingCount: followingCount,
      postsCount: postsCount,
    );
  }

  Widget _buildBio(currentUser) {
    return CustomText(
      text: currentUser.bio,
      fontSize: 13,
    );
  }

  Widget _buildProfileImage(String profileImage, String ownerID) {
    return Container(
      decoration: BoxDecoration(
          color: getPrimaryColorTheme(),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1)),
      child: ProfilePictuerOnline(
        imageUrl: profileImage,
        radius1: 50,
        ownerId: ownerID,
        radius2: 18,
      ),
    );
  }

  AppBar _buildAppBar(context) {
    final authViewModel = AuthViewModel();
    return AppBar(
      title: CustomText(
        text: userName,
        fontSize: 18,
        color: Colors.white,
      ),
      actions: [
        IconButton(
            onPressed: () {
           authViewModel.signOut();
           Navigator.pushReplacementNamed(context, Routes.login);
           
            },
            icon: Icon(Icons.logout_outlined))
      ],
    );
  }

  Widget _buildButtonOptions(
      User currentUser, AsyncSnapshot snapshot, context) {
    final isMe = currentUser.userId == userId;
    if (isMe) {
      return _buildEditeOption(context);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSendMessageButtonOption(currentUser, context, snapshot),
          _buildFollowButtonOption(currentUser),
        ],
      );
    }
  }

  Widget _buildFollowButtonOption(currentUser) {
    return Consumer<FollowersViewModel>(
        builder: (context, followersProvider, child) {
      return CustomTextButton(
        color:
            followersProvider.isFollowed(userId) ? Colors.grey : kPrimaryColor,
        text: followersProvider.isFollowed(userId) ? 'Unfollow' : 'Follow',
        onPressed: () {
          followersProvider.follow(
              someOneId: userId, currentUserId: currentUser.userId);
        },
        width: setWidth(28),
        height: setHeight(5),
      );
    });
  }

  Widget _buildSendMessageButtonOption(
      currentUser, context, AsyncSnapshot snapshot) {
    return CustomTextButton(
        color: kPrimaryColor,
        width: setWidth(28),
        height: setHeight(5),
        text: 'Message',
        onPressed: () {
          final chatId = '$userId${currentUser.userId}';
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      args: {
                        'ownerId': userId,
                        'ownerProfileImage':
                            "snapshot.data!.profileImage", //TODO
                        'ownerName': userName,
                        'currentUserId': currentUser.userId,
                        'chatId': chatId,
                      },
                    )),
          );
        });
  }

  Widget _buildEditeOption(context) {
    return CustomTextButton(
      color: kPrimaryColor,
      text: 'Edite Profile',
      onPressed: () {
        Navigator.pushNamed(context, Routes.editeProfile);
      },
      width: setWidth(30),
      height: setHeight(4),
    );
  }
}
