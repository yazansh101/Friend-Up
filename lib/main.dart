import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app.dart';
import 'package:movie_app/features/comments/data/datasources/remote/comments_remote_data_source.dart';
import 'package:movie_app/features/comments/data/repositories/comments_data_repository.dart';

import 'core/helper/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  final repo = CommentsDataRepository(
      repostory: CommentsRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firebaseFirestore: FirebaseFirestore.instance,
          firebaseStorage: FirebaseStorage.instance));

  repo.readComments('postId').listen((event) {
    event.fold((l) => print(l), (r) => print(r.length.toString()));
  });
}
