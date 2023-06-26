import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firebase_auth/firebase_auth_service.dart';
import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class MessageController{
  final FirebaseFireStoreService db = FirebaseFireStoreService();
  final FirebaseAuthService _auth = FirebaseAuthService();


  Stream<QuerySnapshot> getNewMessage() async* {
    yield* db.fetchDataFromCollectionwithOrdering(
      path:
          'users/${_auth.currentUser!.uid}/chats/YW6K7M5rA93FacGYviIB/messages/',
      orderBy: 'createdAt',
    );

  }

  Future<DocumentReference>? sendMessage(String message) {
    try {
      return db.addDataToCollection(
        path:
            '/users/fOw3mBFmgBS82tK15tyOCPxCtwY2/chats/YW6K7M5rA93FacGYviIB/messages/',
        data: {
          'content': message,
          'createdAt': Timestamp.now(),
          'userId': _auth.currentUser!.uid
        },
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<DocumentReference> storeMessageData(String message) {
    return db.addDataToCollection(
      path: 'users/kvu2HiBpqceT22tnAIV1/messages',
      data: {
        'content': message,
        'createdAt': Timestamp.now(),
        'userId': _auth.currentUser!.uid
      },
    );
  }

}