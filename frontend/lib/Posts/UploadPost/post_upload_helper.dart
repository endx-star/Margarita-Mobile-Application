import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marginta/Controller/api_methods.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Model/user_post_model.dart';

import '../../Account/ui/account_screen.dart';

addPostToData(UserPost post, context) async {
  var postString = post.toJson();
  //
  var body = {
    "lat": post.lat,
    "lng": post.lng,
    "description": post.description,
    "imgurl": post.imgurl,
    "user": post.user!.userid,
    "cat": post.cat
  };

  // final send = json.encode(postString);
  logs("Posting data is $postString");
  final result = await Controller().postApi(endpoint: "createPost", body: body);
  if (result != null) {
    logs(result);
    navigateAndRemove(context, RootApp(cat: post.cat,));
    // return;
  }
}

pickPostImage() async {
  File imageFile = File('');

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
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

  return imageFile;
}

Future<String> uploadFile(image) async {
  dynamic uploadedURL = '';
  FirebaseStorage storage = FirebaseStorage.instance;

  Reference ref =
      storage.ref().child('PostStorage/${DateTime.now()}${image.path}}');
  UploadTask uploadTask = ref.putFile(image);
  await uploadTask.whenComplete(() async {
    await ref.getDownloadURL().then((value) {
      uploadedURL = value;
      if (kDebugMode) {
        print("my url is $uploadedURL");
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

  return uploadedURL;
}
