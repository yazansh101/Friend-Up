import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../models/post_model.dart';
import '../../services/fireBase_storage/firebase_storage.dart';
import '../../services/firebase_auth/firebase_auth_service.dart';
import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class ImageUploader {
  final FirebaseStorageServices _storage = FirebaseStorageServices();
  Future<String> uploadImage(File imageFile, String postId) async {
    String postImageUrl =
        await _storage.uploadFile(imageFile, 'post_$postId.jpg');
    return postImageUrl;
  }
}

class PostSaver {
  final FirebaseFireStoreService _db = FirebaseFireStoreService();

  CollectionReference get postsRef => _db.myFirebase.collection('posts');

  Future<void> uploadPost(Post post) async {
    try {
      await postsRef.doc(post.id).set(post.toJson());
      log('Successfully saved post!');
    } catch (e) {
      log('Error saving post: $e');
    }
  }

  Future<void> editPost(String postId, String userId) async {
    await _db.myFirebase.doc('posts/$userId/userPosts/$postId').get();
  }

  Future<void> deletePost(String postId) async {
    try {
      await postsRef.doc(postId).delete();
      print('Successfully deleted post!');
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}

class PostRetriever {
  final FirebaseFireStoreService _db = FirebaseFireStoreService();
  late DocumentSnapshot lastDocument;

  Future<QuerySnapshot?> getTimeLinePosts() async {
    try {
      final querySnapshot = await _db.myFirebase
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .limit(2)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
        return querySnapshot;
      } else {
        return null;
      }
    } catch (e) {
      log('Error getting timeline posts: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot> fetchNextTimeLinePosts() async {
    final nextQuerySnapshot = await _db.myFirebase
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .startAfterDocument(lastDocument)
        .limit(2)
        .get();
    if (nextQuerySnapshot.docs.isNotEmpty) {
      lastDocument = nextQuerySnapshot.docs[nextQuerySnapshot.docs.length - 1];
    }
    return nextQuerySnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts(
      String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db.myFirebase
          .collection('posts')
          .where('ownerId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      log('Successfully retrieved user posts!');
      return snapshot;
    } catch (e) {
      log('Error getting user posts: $e');
      rethrow;
    }
  }
}

class PostProvider {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final ImageUploader _imageUploader = ImageUploader();
  final PostSaver _postSaver = PostSaver();
  final PostRetriever _postRetriever = PostRetriever();
  final FirebaseFireStoreService _db = FirebaseFireStoreService();

  CollectionReference get postsRef => _db.myFirebase.collection('posts');
  String get userId => _auth.currentUser!.uid;

  Future<void> createPost({
    required String ownerName,
    required String postDescription,
    required File? imageFile,
    required String? ownerProfileImage,
  }) async {
    final postId = const Uuid().v4();
    String postImageUrl = '';
    try {
      if (imageFile != null) {
        postImageUrl = await _imageUploader.uploadImage(imageFile, postId);
      
      }

      final Post post = Post(
        ownerName: ownerName,
        timestamp: DateTime.now(),
        discription: postDescription,
        id: postId,
        likes: {},
        ownerId: userId,
        mediaUrl: postImageUrl,
        ownerProfileImage: ownerProfileImage ?? ''
      );
      _postSaver.uploadPost(post);
    } catch (e) {
      log('The error when create post is :$e');
    }
  }

  getTimeLinePosts() async {
    return await _postRetriever.getTimeLinePosts();
  }

  getNextTimeLinePosts() async {
    return await _postRetriever.fetchNextTimeLinePosts();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts(userId) async {
    return await _postRetriever.getUserPosts(userId);
  }

  Future<void>? likePost(postId, ownerId) {
    try {
      postsRef
          // .doc(ownerId)
          // .collection('userPosts')
          .doc(postId)
          .update({'likes.$userId': true});
    } catch (e) {
      log('error likePost $e');
    }
    return null;
  }

  unlikePost(postId, ownerId) {
    try {
      postsRef
          //.doc(ownerId).collection('userPosts')
          .doc(postId)
          .set({
        'likes': {userId: FieldValue.delete()}
      }, SetOptions(merge: true));
    } catch (e) {
      log('error likePost $e');
    }
  }
}
  

// class PostProvider {
//   final FirebaseFireStoreService _db = FirebaseFireStoreService();
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   final FirebaseStorageServices _storage = FirebaseStorageServices();

//   CollectionReference get postsRef => _db.db.collection('posts');
//   String get userId => _auth.currentUser!.uid;

//   List<Post>? timeLinePosts;
//   List<Post>? _userPosts;
//   List<Post>? get userPosts => _userPosts;

//   Future<void> createPost({
//     required String ownerName,
//     required String postDescription,
//     required File? imageFile,
//   }) async {
//     final postId = const Uuid().v4();
//     String postImageUrl = '';
//     if (imageFile != null) {
//       postImageUrl = await _storage.uploadFile(imageFile, 'post_$postId.jpg');
//     }

//     final Post post = Post(
//       ownerName: ownerName,
//       timestamp: DateTime.now(),
//       discription: postDescription,
//       id: postId,
//       likes: {},
//       ownerId: userId,
//       mediaUrl: postImageUrl,
//     );
//     _setPostData(post: post);
//   }

//   Future<void> _setPostData({
//     required Post post,
//   }) async {
//     try {
//       await postsRef
//           //    .doc(userId)
//           //  .collection('userPosts')
//           .doc(post.id)
//           .set(post.toJson());
//       print('set data succesfully!');
//     } catch (e) {
//       print('this error is $e ');
//     }
//   }

//   editePost(postId) async {
//     await _db.db.doc('posts/$userId/userPosts/$postId').get();
//   }

//   deletePost(postId) {}

//   Stream<QuerySnapshot<Map<String, dynamic>>> getTimeLinePosts() async* {
//     try {
//       log('getMyPosts');

//       yield* _db.db
//           .collection('posts')
//           .orderBy('timestamp', descending: true)
//           .snapshots();
//     } catch (e) {
//       log('getMyPosts error is $e');
//       rethrow;
//     }
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts(
//       String userId) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await _db.db
//           .collection('posts')
//           .where('ownerId', isEqualTo: userId)
//           .orderBy('timestamp', descending: true)
//           .get();

      
//       log('get user posts succsfully');
//       return snapshot;
//     } catch (e) {
//       print('getMyPosts error is $e');
//       rethrow;
//     }
//   }

//   Future<void>? likePost(postId, ownerId) {
//     try {
//       postsRef
//           // .doc(ownerId)
//           // .collection('userPosts')
//           .doc(postId)
//           .update({'likes.$userId': true});
//     } catch (e) {
//       print('error likePost $e');
//     }
//     return null;
//   }

//   unlikePost(postId, ownerId) {
//     try {
//       postsRef
//           //.doc(ownerId).collection('userPosts')
//           .doc(postId)
//           .set({
//         'likes': {userId: FieldValue.delete()}
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print('error likePost $e');
//     }
//   }
// }
