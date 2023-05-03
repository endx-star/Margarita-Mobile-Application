import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marginta/Controller/api_methods.dart';
import 'package:marginta/Global/color.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Location/UI/location_screen.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/constant/story_json.dart';

import '../../Controller/shared_preferences.dart';
import '../../Posts/functions/post_functions.dart';
import '../../Widgets/post_item.dart';
import '../../Widgets/story_item.dart';
import '../drawer.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  dynamic cat;
  // ignore: use_key_in_widget_constructors
  Dashboard({this.cat});
  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isloading = false;
  List<bool> bookmarList = [];

  List<UserPost> userPost = [];
    List<UserPost> newPost = [];

  getDashboardPost() async {
    userPost=[];
    setState(() {
      isloading = true;
    });
 await getuserData();
    List<dynamic> postsList = await Controller().getApi(
            endpoint: "getarticlesbyCategory",
            id: widget.cat ?? 'YOUR COCKTAIL') ??
        [];
    setState(() {});
    // });
    for (var element in postsList) {
      userPost.add(UserPost.fromJson(element));
      bookmarList.add(false);

    }

newPost = userPost.reversed.toList();
    if (kDebugMode) {
      print("Length is dashboard${bookmarList}");
    }
    setState(() {
      isloading = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

var userdata;
getuserData()async{

 userdata =await json.decode(await  PrefManager().get('userlogin', null));

 userdata =await json.decode(await  PrefManager().get('userlogin', null));
 print("userdata is $userdata");
}
  @override
  void initState() {
    super.initState();
    getDashboardPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                'assets/logo.png',
                width: 170,
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.blueGrey,
                    size: 28,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.location_on,
                  color: Colors.blueGrey,
                  size: 28,
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      //  nav(context,const Settings());
                      //nav(context,EditProfile(data: data,));
                    },
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.grey,
                      size: 28,
                    )),
                const SizedBox(
                  width: 5,
                ),
                //                  InkWell(

                //           onTap: (){
                // nav(context,const Settings());

                //           },
                //           child:const Icon(Icons.settings,color: Colors.grey,size: 28,)),
              ],
            )
          ]),
          actions: [Container()],
        ),
      ),
      body:   EasyRefresh(
    onRefresh: () async {
   getDashboardPost();
    },
    onLoad: () async {
   
    },
    child: isloading
                  ? Center(child: spinkit)
                  : userPost.isEmpty
                      ? const Center(
                          child: Text('No Post Found'),
                        )
                      : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
   
                    Row(
                        children: List.generate(stories.length, (index) {
                      return StoryItem(
                        img: stories[index]['img'],
                        name: stories[index]['name'],
                      );
                    })),
                  ],
                ),
              ),
              Divider(
                color: white.withOpacity(0.3),
              ),
              Column(
                          children: List.generate(newPost.length, (index) {
                               dynamic images;
                        try{
           images = json.decode(newPost[index].imgurl!);
                            print("my images are $images");
                        }catch(e){}
                            return GestureDetector(
                              onTap: () {
                                // nav(
                                //     context,
                                //     ViewPost(
                                //       userPost: userPost[index],
                                //     ));
                              },
                              child: PostItem(
                                profileImg:images.runtimeType==List?"https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-22%2000%3A57%3A18.121147%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker8497766138402990208.jpg%7D?alt=media&token=dc3a430e-74a8-490c-8af1-43ad01a93292": newPost[index].user?.image == "" ||
                                        newPost[index].user?.image == null
                                    ? "https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-22%2000%3A57%3A18.121147%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker8497766138402990208.jpg%7D?alt=media&token=dc3a430e-74a8-490c-8af1-43ad01a93292"
                                    : newPost[index].user!.image!,
                                name: newPost[index].user?.username == "" ||
                                        newPost[index].user?.username == null
                                    ? userdata['email'].toString().split("@")[0]
                                    : newPost[index].user!.username!,
                                postImg: images ?? [],
                                likedBy: newPost[index].likes,
                                isLoved: newPost[index].likes!.length == 0
                                    ? false
                                    : !(newPost[index].isLoved),
                                viewCount: newPost[index].comment!,
                                dayAgo: "1",
                                caption: newPost[index].description ?? "",
                                id: newPost[index].id,
                                cat: newPost[index].cat,
                                lat: newPost[index].lat,
                                lng: newPost[index].lng,
                                userid: newPost[index].user?.userid,
                                postid: newPost[index].id,
                                isbookMark: bookmarList[index],
                                onLocationTap:(){
      
                                  nav(context, LocationScreen());
                                },
                                onTap: () async {
                                  if (bookmarList[index]) {
                                    bookmarList[index]=false;
                                     var userid =
                                        await PrefManager().get('user', '');
      
                                    PostFunctions().deleteBookmark(
                                        userid: userid,
                                        postid: newPost[index].id);
                                    // userPost.removeAt(index);
                                    setState(() {});
                                  } else {
                                    bookmarList[index]= true;
                                    setState(() {});
                                    print(newPost[index].user?.userid);
                                    print(newPost[index].id);
      
                                    var userid =
                                        await PrefManager().get('user', '');
      
                                    PostFunctions().addbookmark(
                                        userid: userid,
                                        postid: newPost[index].id);
                                  }
      
                                  print("my bookmarlist is $bookmarList");
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
                        )
            ],
          ),
        ),
      ),
    );
  }
}
