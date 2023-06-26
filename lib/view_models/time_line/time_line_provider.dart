import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firebase_auth/firebase_auth_service.dart';
import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class TimeLineProvider{
  final FirebaseFireStoreService _db = FirebaseFireStoreService();
  final FirebaseAuthService _auth = FirebaseAuthService();
  get postsRef => _db.myFirebase.collection('posts');

  Future<List<DocumentSnapshot>> getPosts() async {
    QuerySnapshot querySnapshot =
        await postsRef.orderBy('timestamp').get();
    return querySnapshot.docs;
  }
  
  Future<void> deletePost(String postId) async {
    await postsRef.doc(postId).delete();
  }
  
}

