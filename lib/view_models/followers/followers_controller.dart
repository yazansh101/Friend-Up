// ignore_for_file: unused_field, body_might_complete_normally_nullable

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firebase_fireStore/firebase_fireStore_service.dart';

class FollowersProvider {
  final FirebaseFireStoreService _myDatabase = FirebaseFireStoreService();

  CollectionReference get _followersRef => _myDatabase.myFirebase.collection('followers');
  CollectionReference get _followingRef => _myDatabase.myFirebase.collection('following');


  int? _userFollowingCount;
  int? get userFollowingCount => _userFollowingCount;

  int? _userFollowersCount;
  int? get userFollowersCount => _userFollowersCount;

  List<Map<String, dynamic>>? _myFollowers;
  List? get myFollowers => _myFollowers;

  List<Map<String, dynamic>>? _myFollowing;
  List? get myFollowing => _myFollowing;

  Future<void> getUserFollowers(userId) async {
    try {
      QuerySnapshot snapshot = await _followersRef
          .doc(userId)
          .collection('userFollowers')
          .get();
      _myFollowers = snapshot.docs.map((user) {
        return {'userId': user.id,};
      }).toList();
      
     _userFollowersCount = snapshot.docs.length;

    } catch (e) {
      log(e.toString());
    }
  }


  Future<void> getUserFollowing(userId) async {
    try {
      QuerySnapshot snapshot = await _followingRef
          .doc(userId)
          .collection('userFollowing')
          .get();
      _myFollowing = snapshot.docs.map((user) {
        log(user.id.toString());
        return {
          'userId': user.id,
        };
      }).toList();
      _userFollowingCount = snapshot.docs.length;
      log('My following list initialize Succesfully!! with list lenth  ${_myFollowing!.length} ');
    } catch (e) {
      log('there is an error with iniialize my following${e.toString()}');
    }
  }
  
  // Future getUserFollowingCount(userId) async {
  //   try {
  //     QuerySnapshot snapshot = await _followingRef
  //         .doc(userId)
  //         .collection('userFollowing')
  //         .get();
  //    _userFollowingCount = snapshot.docs.length;
  //   } catch (e) {
      
  //     log(e.toString());
  //   }
  // }
  //   Future getUserFollowersCount(userId) async {
  //   try {
  //     QuerySnapshot snapshot = await _followersRef
  //         .doc(userId)
  //         .collection('userFollowers')
  //         .get();
  //    _userFollowersCount = snapshot.docs.length;
  //  return userFollowersCount;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> followSomeOne(
      {required String someOneId, required String currentUserId}) async {
    try {
    await  _followingRef
          .doc(currentUserId)
          .collection('userFollowing')
          .doc(someOneId)
          .set({
        someOneId: true,
      });
   await   _followersRef
          .doc(someOneId)
          .collection('userFollowers')
          .doc(currentUserId)
          .set({
        currentUserId: true,
      });
      log('your are following some one Succesfully!!}');
    } catch (e) {
      log('there is an error with following some one ${e.toString()}');
    }
  }

  Future<void> unFollowSomeOne(
      {required String someOneId, required String currentUserId}) async {
    try {
      await _followingRef
          .doc(currentUserId)
          .collection('userFollowing')
          .doc(someOneId)
          .delete();
     _followersRef
          .doc(someOneId)
          .collection('userFollowers')
          .doc(currentUserId)
          .delete();
      print('unFollow successfully.');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
