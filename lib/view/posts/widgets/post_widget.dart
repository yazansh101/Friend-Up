// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/core/constants/hero_tags.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/helper/navigator_service.dart';
import 'package:movie_app/view/posts/widgets/user_header.dart';
import 'package:movie_app/view_models/time_line/time_line_view_model.dart';
import 'package:movie_app/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/helper/time_helper.dart';
import '../../profile/screens/profile_screen.dart';
import 'media_item.dart';

class PostWidget extends StatelessWidget {
  final String discription;
  final String postId;
  final String postOwnerId;
  final String? imageUrl;
  final String? ownerProfileImage;
  final String? time;
  final String? userName;
  final void Function() onLike;
  final void Function() onComment;

  const PostWidget({
    Key? key,
    required this.discription,
    required this.imageUrl,
    required this.ownerProfileImage,
    required this.onLike,
    required this.onComment,
    this.time,
    this.userName,
    required this.postOwnerId,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getColorTheme(),
      );
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         _buildUserHeader(context,ownerProfileImage),
          setVerticalSpace(2),
         _buildMediaItem(),
          setVerticalSpace(2),
          _buildActivityIcons(context),
          setVerticalSpace(2),
          _likesCommentsInfo(),
          setVerticalSpace(2),
          Text(discription),
        ],
      ),
    );
  }

  Hero _buildMediaItem() {
    return Hero(
        tag: HeroTag.image(imageUrl!),
        child: Material(
            type: MaterialType.transparency,
            child: MediaItem(mediaUrl: imageUrl)));
  }

  GestureDetector _buildUserHeader(BuildContext context,imageUrl) {
    return GestureDetector(
        onTap: () {
          NavigatorService.pushFadeTransition(context, ProfileScreen(userId: postOwnerId,userName:userName! ,key: ValueKey(postOwnerId)),
              arguments: {
                'ownerId': postOwnerId,
                'ownerName': userName,
              });
        },
        child: Hero(
          tag: HeroTag.postHeader(postId),
          child: Material(
            type: MaterialType.transparency,
            child: 
            UserHeader(
              imageUrl:imageUrl,
              postOwnerId: postOwnerId,
              postTime: TimeHelper.getLastSeen(
                  Timestamp.fromDate(DateTime.parse(time!))),
              userName: userName!,
            ),
          ),
        ));
  }

  Row _likesCommentsInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<TimeLinePostsViewModel>(
          builder: (context, timeLinePostsViewModel, child) =>
              Text.rich(TextSpan(
                  text: timeLinePostsViewModel.getPostLikes(postId).toString(),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  children: [
                TextSpan(
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.4)),
                  text: ' Likes ',
                ),
              ])),
        ),
        setHorizentalSpace(2),
      ],
    );
  }

  Widget _buildActivityIcons(context) {


    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Row(
      children: [
        Consumer<TimeLinePostsViewModel>(
          builder: (context, timeLinePostsViewModel, child) => InkWell(
              onTap: () {
                onLike();
              },
              child: timeLinePostsViewModel.isPostLiked(
                          postId, userViewModel.currentUser.userId) ==
                      true
                  ? Icon(
                    FontAwesomeIcons.solidHeart,
                    color: kPrimaryColor,
                    size: 18,
                  )
                  : Icon(
                      opticalSize: 15,
                      FontAwesomeIcons.heart,
                      color: kPrimaryColor,
                      size: 18,
                    )),
        ),
        setHorizentalSpace(4),
        InkWell(
          onTap: onComment,
          child: const Icon(
            FontAwesomeIcons.comment,
            size: 18.0,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
