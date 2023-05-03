import 'dart:convert';

import 'package:marginta/Model/location_model.dart';

class UserInfoModel {
  String? userid;
  String? username;
  String? bio;
  String? name;
  String? email;
  String? usertype;
  String? image;

  UserInfoModel(
      {this.userid,
      this.username,
      this.bio,
      this.name,
      this.email,
      this.usertype,
      this.image});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userid = json['_id'];
    username = json['username'] ?? "";
    bio = json['bio'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    usertype = json['usertype'] ?? "";
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        //  final Map<String, dynamic> data = new Map<String, dynamic>();

        '_id': this.userid,
        //  return data;
      };
}
