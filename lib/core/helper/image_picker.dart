// ignore_for_file: empty_catches

import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


class ImagePickerHelper {
  File? storedMedia;
  bool? isFromCamera;

  static Future<File> pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 10);
    return File(pickedImage!.path);
  }

  static Future<File?>? pickImageFromGallery() async {
    try{
       final pickedImage =
        await ImagePicker(). pickImage(source: ImageSource.gallery);
    return File(pickedImage!.path);
    }
    catch(e){log('this error where pick image $e');}
    return null;
   
  }
  static Future<File?>? pickVideoFromGallery() async {
    try{
       final pickedImage =
        await ImagePicker(). pickVideo(source: ImageSource.gallery);
    return File(pickedImage!.path);
    }
    catch(e){print('this error where pick image $e');}
    return null;
   
  }
    static Future<File?>? pickVideoFromCamera() async {
    try{
       final pickedImage =
        await ImagePicker(). pickVideo(source: ImageSource.camera);
    return File(pickedImage!.path);
    }
    catch(e){log('this error where pick image $e');}
    return null;
   
  }
}

