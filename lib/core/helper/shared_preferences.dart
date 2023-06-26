import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/post_model.dart';

class PostCache {
  // SharedPreferences instance
  SharedPreferences? _prefs;
  PostCache(){
    _getInstance();
  }

  // Method to get an instance of SharedPreferences
  Future<void> _getInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Method to cache posts
  Future<void> cachePosts(List<Post> posts) async {
    try{
          String postJson = jsonEncode(posts);
    await _prefs!.setString("cachedPosts", postJson);
    }
    catch(e){
      log('error cashe $e');
    }

  }
  

  Future<List<Post>> getCachedPosts() async {
    String? cachedPostsJson = _prefs!.getString("cachedPosts");
    if (cachedPostsJson != null) {
      List<Post> cachedPosts = List<Post>.from(jsonDecode(cachedPostsJson));
      return cachedPosts;
    }
    return [];
  }

  Future<void> updateCache(List<Post> newPosts) async {
    String newPostsJson = jsonEncode(newPosts);
    await _prefs!.setString("cachedPosts", newPostsJson);
  }

}