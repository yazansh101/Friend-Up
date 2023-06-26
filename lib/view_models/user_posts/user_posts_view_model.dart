// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/view_models/user_posts/uesr_posts_provider.dart';
import 'package:provider/provider.dart';

import '../../core/helper/shared_preferences.dart';
import '../../models/post_model.dart';

class UserPostsViewModel with ChangeNotifier {
  final PostProvider _postProvider;
  UserPostsViewModel(this._postProvider, this._postCache);

  final PostCache _postCache;
  List<Post> userPosts = [];

  static provider(context, {listen = false}) =>
      Provider.of<UserPostsViewModel>(context, listen: listen);

  Future getUserPosts(userId) async {
    List<Post> cachedPosts = await _postCache.getCachedPosts();
    if (cachedPosts.isNotEmpty) {
      mapPosts(cachedPosts);
    }
    final snapshot = await _postProvider.getUserPosts(userId);
    mapPosts(snapshot.docs);
    await _postCache.cachePosts(userPosts);
  }

  mapPosts(List listOfPosts) {
    userPosts = listOfPosts.map((post) => Post.fromJson(post)).toList();
    return userPosts;
  }

  int getPostLikesCount(postId) {
    final postIndex = userPosts.indexWhere((post) => post.id == postId);
    if (postIndex >= 0) {
      final likesCount = userPosts[postIndex].likes.length;
      return likesCount;
    }
    return 0;
  }

  Future<void> likePost({postId, userId}) async {
    final postIndex = userPosts.indexWhere((post) => post.id == postId);
    if (postIndex >= 0) {
      final isLiked = userPosts[postIndex].likes[userId] == true;
      if (isLiked) {
        try {
          userPosts[postIndex].likes.remove(userId);
          _postProvider.unlikePost(postId, userPosts[postIndex].ownerId);
          notifyListeners();
        } catch (e) {
          log('error is $e');
        }
      } else {
        userPosts[postIndex].likes[userId] = true;
        _postProvider.likePost(postId, userPosts[postIndex].ownerId);
        notifyListeners();
      }
    }
  }
}
