import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/utils/error_handler.dart';
import 'package:movie_app/models/comment_model.dart';

import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class CommentViewModel extends ChangeNotifier {
  final FirebaseFireStoreService _db = FirebaseFireStoreService();


  Stream<QuerySnapshot> getPostComments(postId) async* {
    yield* _db.fetchDataFromCollectionwithOrdering(path: 'comments/$postId/postComments', orderBy: 'timestamp',descending: true);
  }

  Future setComment({postId,text,userId,userName,userProfileImage})async{
    Comment comment=Comment(
      userProfileImage: userProfileImage,
      userName:userName ,
      text: text, userId: userId, timestamp: DateTime.now());
    _db.myFirebase.collection('comments').doc(postId).collection('postComments').add(comment.toJson());
  }

    Future sendCommentToActivityFeed({ownerId,postId,mediaUrl,userProfileImage,userName,userId})async{
   ErrorHandler.handle(() {
        _db.myFirebase.collection('activityFeeds').doc(ownerId).collection('userActivityFeeds').add({
      'userId':userId,
      'postId':postId,
      'timesmap' :DateTime.now(),
      'mediaUrl' :mediaUrl,
      'userProfileImage' :userProfileImage,
      'userName' :userName,
    });
   });

  }
}