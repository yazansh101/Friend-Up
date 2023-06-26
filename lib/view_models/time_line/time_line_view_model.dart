import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../models/post_model.dart';
import '../user_posts/uesr_posts_provider.dart';

class TimeLinePostsViewModel with ChangeNotifier {
  final PostProvider _postProvider;
  TimeLinePostsViewModel(this._postProvider);

  List<Post>? _timeLinePosts = [];
  List<Post>? get timeLinePosts => _timeLinePosts;
  bool isWaittingPosts = false;

  Future<void> createPost({
    required String ownerName,
    required String postDescription,
    required File? imageFile,
  }) async {
    _postProvider.createPost(
        ownerName: ownerName,
        postDescription: postDescription,
        imageFile: imageFile);
        notifyListeners();
  }


  initPosts() async {
    isWaittingPosts = true;
    final snapshot = await _postProvider.getTimeLinePosts();
    mappingPosts(snapshot.docs);
    isWaittingPosts = false;
    notifyListeners();
  }

  fetchNextTimeLinePosts() async {
    final snapshot = await _postProvider.getNextTimeLinePosts();
    List<dynamic> jsonList = snapshot.docs;
    final List<Post> nextPosts =
        jsonList.map((doc) => Post.fromJson(doc)).toList();
    _timeLinePosts!.addAll(nextPosts);
  }

  mappingPosts(List docs) {
    _timeLinePosts = docs.map((doc) => Post.fromJson(doc)).toList();
  }

  int getPostLikes(postId) {
    if (_timeLinePosts != null) {
      final postIndex = _timeLinePosts!.indexWhere((post) => post.id == postId);
      if (postIndex >= 0) {
        final likesCount = _timeLinePosts![postIndex].likes.length;
        return likesCount;
      }
    }
    return 0;
  }

  isPostLiked(postId, userId) {
    if (_timeLinePosts != null) {
      final postIndex = _timeLinePosts!.indexWhere((post) => post.id == postId);
      if (postIndex >= 0) {
        return _timeLinePosts![postIndex].likes[userId];
      }
    }
    return false;
  }

  Future<void> likePost({postId, userId}) async {
    final postIndex = _timeLinePosts!.indexWhere((post) => post.id == postId);

    if (postIndex >= 0) {
      final isLiked = _timeLinePosts![postIndex].likes[userId] == true;
      if (isLiked) {
        try {
          _timeLinePosts![postIndex].likes.remove(userId);
          _postProvider.unlikePost(postId, _timeLinePosts![postIndex].ownerId);
          notifyListeners();
        } catch (e) {
          log('error is $e');
        }
      } else {
        _timeLinePosts![postIndex].likes[userId] = true;
        _postProvider.likePost(postId, _timeLinePosts![postIndex].ownerId);
        notifyListeners();
      }
    }
  }
}
