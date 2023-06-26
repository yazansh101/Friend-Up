import 'package:flutter/material.dart';

import 'activity_feed_service.dart';

class ActivityFeedViewModel extends ChangeNotifier {
  final ActivityFeedService _activityFeedService = ActivityFeedService();

  String getActivityStatement(String activityType) {
    switch (activityType) {
      case 'like':
        return 'liked your post';
      case 'comment':
        return 'commented on your post';
      case 'follow':
        return 'followed you';
      default:
        return '';
    }
  }

  Stream getMyActivityFeeds() async* {
    yield* _activityFeedService.getMyactivityFeeds();
  }

  Future<void> setLikeActivityFeed(
      {required postId,
      required postOwnerId,
      required mediaUrl,
      required userProfileImage,
      required userName}) {
    return _activityFeedService.sendNotficationInfo(
        postId: postId,
        postOwnerId: postOwnerId,
        mediaUrl: mediaUrl,
        userProfileImage: userProfileImage,
        userName: userName,
        activityType: 'like');
  }

  Future setCommentActivityFeed(
      {required postOwnerId,
      required postId,
      required mediaUrl,
      required userProfileImage,
      required userName}) async {
    return _activityFeedService.sendNotficationInfo(
        postId: postId,
        postOwnerId: postOwnerId,
        mediaUrl: mediaUrl,
        userProfileImage: userProfileImage,
        userName: userName,
        activityType: 'comment');
  }

  Future setFollowActivityFeed(
      {required postOwnerId,
      required postId,
      required mediaUrl,
      required userProfileImage,
      required userName}) async {
    return _activityFeedService.sendNotficationInfo(
        postId: postId,
        postOwnerId: postOwnerId,
        mediaUrl: mediaUrl,
        userProfileImage: userProfileImage,
        userName: userName,
        activityType: 'follow');
  }
}
