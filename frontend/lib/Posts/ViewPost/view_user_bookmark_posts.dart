import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:marginta/Controller/api_methods.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Model/bookmark_model.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/Posts/functions/post_functions.dart';
import 'package:marginta/Widgets/post_item.dart';

class BookMarkPosts extends StatefulWidget {
  final String userid;
  const BookMarkPosts({super.key, required this.userid});

  @override
  State<BookMarkPosts> createState() => _BookMarkPostsState();
}

class _BookMarkPostsState extends State<BookMarkPosts> {
  bool isloading = false;
  List<BookMarkPost> userPost = [];
  List bookmarList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookMarkPost();
  }

  getBookMarkPost() async {
    setState(() {
      isloading = true;
    });
    List<dynamic> postsList =
        await PostFunctions().getAllBookMarks(userid: widget.userid);
    print("In bookmark view $postsList");

    for (var element in postsList) {
      userPost.add(BookMarkPost.fromJson(element));
      bookmarList.add(true);
    }

    setState(() {
      isloading = false;
    });
  }

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
              " BookMark Post",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: isloading
              ? spinkit
              : userPost.isEmpty
                  ? const Center(
                      child: Text('No Post Found'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(userPost.length, (index) {

                                 var images = json.decode(userPost[index].post!.imgurl!);
                            print("my images are $images");
                          return InkWell(
                            onTap: () {
                
                            },
                            child: PostItem(
                              profileImg: userPost[index].user!.image == ""
                                  ? "https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-22%2000%3A57%3A18.121147%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker8497766138402990208.jpg%7D?alt=media&token=dc3a430e-74a8-490c-8af1-43ad01a93292"
                                  : userPost[index].user!.image!,
                              name: userPost[index].user!.username == ""
                                  ? "Margarita User"
                                  : userPost[index].user!.username!,
                              postImg: images ??[],
                              likedBy: userPost[index].post!.likes,
                              isLoved: userPost[index].post!.likes!.length == 0
                                  ? false
                                  : !(userPost[index].post!.isLoved),
                              viewCount: userPost[index].post!.comment!,
                              dayAgo: "1",
                              caption: userPost[index].post!.description ?? "",
                              id: userPost[index].id,
                              cat: userPost[index].post!.cat,
                              lat: userPost[index].post!.lat,
                              lng: userPost[index].post!.lng,
                              userid: userPost[index].user!.userid,
                              postid: userPost[index].post!.id,
                              isbookMark: bookmarList[index],
                              onTap: () async {
                                if (bookmarList[index]) {
                                  bookmarList.insert(index, false);

                                  PostFunctions().deleteBookmark(
                                      userid: widget.userid,
                                      postid: userPost[index].post!.id);
                                  userPost.removeAt(index);
                                  setState(() {});
                                } else {
                                  bookmarList.insert(index, true);
                                  setState(() {});
                                  await PostFunctions().addbookmark(
                                      userid: widget.userid,
                                      postid: userPost[index].post!.id);
                                }
                              },
                            ),
                          );
                          /* PostItem(
                          callback: callbackFunction,
                          userid: fromAPi[index]['user']['_id'],
                          postid: fromAPi[index]['_id'],
                          postImg: fromAPi[index]['imgurl'],
                          profileImg: fromAPi[index]['imgurl'],
                          name: fromAPi[index]['user']['username'],
                          caption: fromAPi[index]['description'],
                          isLoved: true,
                          viewCount: [],
                          // posts[index]['commentCount'],
                          likedBy: "",
                          // fromAPi[index]['likes'][0] ?? "",
                          dayAgo: fromAPi[index]['timeAgo'] ?? "",
                          id: fromAPi[index]['_id'],
                          cat: fromAPi[index]['cat'],
                          lat: fromAPi[index]['lat'],
                          lng: fromAPi[index]['lng'],
                        );*/
                        }),
                      ),
                    )),
    );
  }
}
