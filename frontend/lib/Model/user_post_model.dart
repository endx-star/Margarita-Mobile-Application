import 'dart:convert';

import 'package:marginta/Model/user_info_model.dart';

class UserPost {
  dynamic id;
  List<dynamic>? likes;
  List<dynamic>? comment;

  String? lat;
  String? lng;
  String? imgurl;
  String? description;
  String? cat;
  bool isLoved = false;

  UserInfoModel? user;

  UserPost(
      {this.id,
      this.likes,
      this.comment,
      this.lat,
      this.lng,
      this.imgurl,
      this.description,
      this.cat,
      this.user,
      this.isLoved = false});

  UserPost.fromJson(Map<String, dynamic> json) {
    bool likeStatus = false;
    id = json['_id'];

    // if (json['likes'] != null) {
    //   json['likes'].forEach((element) {
    //     if (element['_id'].toString() ==
    //         (UserInfoModel.fromJson(json['user']).userid).toString()) {
    //       isLoved = true;
    //       print("Last isloved staus is ${isLoved}");
    //     } else {
    //       isLoved = false;
    //     }
    //   });
    // }

    //contains((json['user'] != null
    // ? new UserInfoModel.fromJson(json['user']).userid
    //  : ""));
    cat = json['cat'];
    likes = json['likes'];
    comment = json['comment'];
    lat = json['lat'];
    lng = json['lng'];
    imgurl = json['imgurl'];
    description = json['description'];
    // user =
    //     json['user'] != null ? new UserInfoModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['likes'] = this.likes;
    // data['comment'] = this.comment;
    data['cat'] = this.cat;
    data['_id'] = this.id;
    data['lat'] = this.lat;
    data['lng'] = this.lat;
    data['imgurl'] = this.imgurl;
    data['description'] = this.description;
    if (this.user != null) {
      data['user'] = (this.user!.toJson());
    }
    return data;
  }

  static List<UserPost> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<UserPost>((item) => UserPost.fromJson(item))
          .toList();
}
