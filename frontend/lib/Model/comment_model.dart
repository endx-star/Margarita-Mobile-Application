import 'dart:convert';

import 'package:marginta/Model/location_model.dart';
import 'package:marginta/Model/user_info_model.dart';

class CommentModel {
  UserInfoModel? userInfoModel;
  String description = "";

  CommentModel({
    this.userInfoModel,
    required this.description,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    userInfoModel = json['userInfoModel'] != null
        ? UserInfoModel.fromJson(json['userInfoModel'])
        : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"] = this.description;
    if (this.userInfoModel != null) {
      data['userInfoModel'] = this.userInfoModel!.toJson();
    }
    return data;
  }
}
