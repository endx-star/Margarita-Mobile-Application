import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  File imageFile = File('');
  final imageSelected = false;
  dynamic ownerprofileURL = '';

  final picker = ImagePicker();

        final ImagePicker imagePicker = ImagePicker();
      List<XFile>? imageFileList = [];

      void selectImages() async {
         final List<XFile>? selectedImages = await 
                imagePicker.pickMultiImage();
           if (selectedImages!.isNotEmpty) {
              imageFileList!.addAll(selectedImages);
           }
          print("Image List Length:" + imageFileList!.length.toString());
         // setState((){});
      }

  pickImage(dynamic source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100,
         maxHeight: 480, maxWidth: 640
         );

    if (pickedFile == null) {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    } else {
      imageFile = File(pickedFile.path);
      // cropImage();
    }

    print('No image $imageFile.');

    //await uploadFile(imageFile);
    return imageFile;
  }
 pickVideo(dynamic source) async {
    final pickedFile = await picker.pickVideo(
        source: source, );

    if (pickedFile == null) {
      if (kDebugMode) {
        print('No image selected.');
      }
      return null;
    } else {
      imageFile = File(pickedFile.path);
      // cropImage();
    }

    print('No image $imageFile.');

    //await uploadFile(imageFile);
    return imageFile;
  }
  uploadFile(image) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref =
        storage.ref().child('profilepics/${DateTime.now()}${image.path}}');
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        ownerprofileURL = value;
        if (kDebugMode) {
          print("my url is $ownerprofileURL");
        }
      });
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
    });

    if (kDebugMode) {
      print("success");
    }

    return ownerprofileURL;
  }
}
