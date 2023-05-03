import 'package:marginta/Model/user_info_model.dart';
import 'package:marginta/Model/user_post_model.dart';

class BookMarkPost {
  dynamic id;
  UserInfoModel? user;
  UserPost? post;

  BookMarkPost({
    this.id,
    this.user,
    this.post,
  });

  BookMarkPost.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'] != null ? UserInfoModel.fromJson(json['user']) : null;
    post = json['post'] != null ? UserPost.fromJson(json['post']) : null;
  }
}
