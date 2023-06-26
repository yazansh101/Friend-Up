import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firebase_auth/firebase_auth_service.dart';
import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class ActivityFeedService {
  final FirebaseFireStoreService _fireStoreService = FirebaseFireStoreService();
  final FirebaseAuthService _auth = FirebaseAuthService();

  CollectionReference get activityFeedsRef =>
      _fireStoreService.myFirebase.collection('activityFeeds');
  String get userId => _auth.currentUser!.uid;

  Stream<QuerySnapshot> getMyactivityFeeds() async* {
    yield* _fireStoreService.fetchDataFromCollection(
        path: 'activityFeeds/$userId/userActivityFeeds');
  }

  Future<void> sendNotficationInfo(
      {required postId,
      required postOwnerId,
      required mediaUrl,
      required userProfileImage,
      required userName,
      required activityType}) {
    return activityFeedsRef.doc(userId).collection('userActivityFeeds').add({
      'postId': postId,
      'timesmap': DateTime.now(),
      'mediaUrl': mediaUrl,
      'userId': userId,
      'userProfileImage': userProfileImage,
      'userName': userName,
      'activityType': activityType,
    });
  }
}
