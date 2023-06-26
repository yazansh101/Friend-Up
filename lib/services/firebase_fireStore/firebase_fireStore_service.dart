import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  FirebaseFirestore get myFirebase => FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchDataFromCollectionwithOrdering({
    required String path,
    required String orderBy,
    bool descending = true,
  }) async* {
    yield* myFirebase
        .collection(path)
        .orderBy(orderBy, descending: descending)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchDataFromCollection({
    required String path,
  }) async* {
    yield* myFirebase.collection(path).snapshots();
  }

  Future<DocumentReference> addDataToCollection(
      {required String path, required Map<String, dynamic> data}) async {
    return await myFirebase.collection(path).add(data);
  }

  Future<void> addDataToDocument(
      {required String collectionPath,
      required String documentPath,
      required Map<String, dynamic> data}) async {
    await myFirebase.collection(collectionPath).doc(documentPath).set(data);
  }
}
