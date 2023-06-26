import 'package:cloud_firestore/cloud_firestore.dart';

class UserSuggestion {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<List<DocumentSnapshot>> getSuggestedUsers(String currentUserId) async {
  //   QuerySnapshot querySnapshotFollowers =
  //       await firestore.collection('followers').doc(currentUserId).collection('userFollowers').get();
    
  //   List<String> followers = [];
    
  //   querySnapshotFollowers.docs.forEach((document) {
  //     followers.add(document.id);
  //   });
    
  //   QuerySnapshot querySnapshotUsers = await firestore.collection('users').get();
    
  //   List<DocumentSnapshot> suggestedUsers = [];

  //   querySnapshotUsers.docs.forEach((document) {
  //     if(!followers.contains(document.id) && document.data()['userId'] != currentUserId) {
  //       if (document.data()['interest'] == interest || document.data()['country'] == country) {
  //         suggestedUsers.add(document);
  //       }
  //     }
  //   });
    
  //   return suggestedUsers;
  // }

  Future<void> followUser(String userId, String currentUserId) async {
    await firestore.collection('followers').doc(userId).collection('userFollowers').doc(currentUserId).set({'userId': currentUserId});
  }

  Future<void> unfollowUser(String userId, String currentUserId) async {
    await firestore.collection('followers').doc(userId).collection('userFollowers').doc(currentUserId).delete();
  }
}
