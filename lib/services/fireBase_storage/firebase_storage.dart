import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? downloadLink;
  String? filePath;

  Future<String> uploadFile(
    File file,
    String folderName,
  ) async {
    try {
      Reference storageReference = _firebaseStorage.ref().child(folderName);
      TaskSnapshot snapshot =
          await storageReference.putFile(file).whenComplete(() => null);
      downloadLink = await snapshot.ref.getDownloadURL();
      log('File Uploaded Successfully!');
    } catch (e) {
      log('this error where upload ');
      log(e.toString());
    }
    return downloadLink!;
  }

  Future<String> downloadFile(
      String fileURL, String folderName, String fileName) async {
    try {
      Reference firebaseStorageRef = _firebaseStorage.refFromURL(fileURL);
      File downloadToFile = File('$folderName/$fileName');
      await firebaseStorageRef.writeToFile(downloadToFile);
      filePath = downloadToFile.path;
      log('File Downloaded Successfully!');
    } catch (e) {
      log('this error where download file$e');
    }
    return filePath!;
  }
}
