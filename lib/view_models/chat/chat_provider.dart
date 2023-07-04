// ignore_for_file: unused_field, prefer_final_fields, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/models/message_model.dart';
import 'package:movie_app/services/firebase_fireStore/firebase_fireStore_service.dart';

import '../../services/firebase_auth/firebase_auth_service.dart';

class ChatProvider {
  final FirebaseFireStoreService db = FirebaseFireStoreService();
  final FirebaseAuthService _auth = FirebaseAuthService();
  get chatsRef => db.myFirebase.collection('chats');

  Stream<QuerySnapshot> getNewChat(String currentUserId) async* {
    yield* db.myFirebase
        .collection('chats')
        .doc(currentUserId)
        .collection('userChats')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewMessage(
      String chatId) async* {
    yield* db.myFirebase
        .collection('messages')
        .doc(chatId)
        .collection('chatMessages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> createNewChat({
    required String currentUserId,
    required String friendName,
    required String friendId,
    required String chatId,
    required String ownerProfileImage,
  }) async {
    try {
      db.myFirebase
          .collection('chats')
          .doc(currentUserId)
          .collection('userChats')
          .doc(friendId)
          .set({
        'chatId': chatId,
        'userName': friendName,
        'ownerProfileImage': ownerProfileImage,
      });
    } catch (e) {
      log('error when create a messages collection');
    }
  }

  Future<void> sendNewMessage({
    required String chatId,
    required String message,
    required String currentUserId,
  }) async {
    Message messageToJson = Message(
      content: message,
      senderId: currentUserId,
      isRead: false,
      createdAt: Timestamp.now(),
    );
    db.myFirebase
        .collection('messages')
        .doc(chatId)
        .collection('chatMessages')
        .add(messageToJson.toJson());
  }
}
