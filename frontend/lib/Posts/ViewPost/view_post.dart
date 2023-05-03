import 'package:flutter/material.dart';

import 'package:marginta/Global/nav.dart';
import 'package:marginta/Model/user_info_model.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/Widgets/post_item.dart';

class ViewPost extends StatefulWidget {
  final UserPost userPost;
  const ViewPost({super.key, required UserPost this.userPost});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  UserInfoModel userInfo = UserInfoModel(
      username: "",
      image:
          "https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-19%2009%3A02%3A37.364065%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker7781655107223186801.jpg%7D?alt=media&token=fa0f4527-e38c-4e13-a12e-9b6cf59653f4");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
            child: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Post",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: PostItem(
          postid: widget.userPost.id,
          userid: widget.userPost.user?.userid,
          profileImg: userInfo.image ?? widget.userPost.imgurl!,
          name: userInfo.name ?? "Name",
          postImg: widget.userPost.imgurl!,
          isLoved: widget.userPost.isLoved,
          likedBy: widget.userPost.likes,
          viewCount: widget.userPost.comment!,
          dayAgo: "",
          caption: widget.userPost.description!,
          id: widget.userPost.id,
          cat: widget.userPost.cat,
          lat: widget.userPost.lat,
          lng: widget.userPost.lng,
          isbookMark: false,
        ),
      ),
    );
  }
}
