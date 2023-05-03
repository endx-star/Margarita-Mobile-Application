
import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marginta/Global/color.dart';

import 'package:marginta/Global/nav.dart';
import 'package:marginta/Posts/functions/post_functions.dart';

import '../../Controller/shared_preferences.dart';
import '../../Posts/Comment/comment_card.dart';
import '../../Posts/EditPost/edit_post.dart';



// ignore: must_be_immutable
class LocationPost extends StatefulWidget {
  final String profileImg;
  final String name;
  final dynamic postImg;
  final String caption;
  // ignore: prefer_typing_uninitialized_variables
  bool isLoved = false;
  dynamic likedBy;
  List<dynamic> viewCount;
  final String dayAgo;
  final bool? isSingle;

  final dynamic id;
  final dynamic cat;
  final dynamic lat;
  final dynamic lng;

  final dynamic? postid;
  final dynamic? userid;
  final dynamic isbookMark;
  void Function()? onTap;
    void Function()? onLocationTap;

  // ignore: use_key_in_widget_constructors
  LocationPost(
      {required this.profileImg,
      required this.name,
      required this.postImg,
      required this.isLoved,
      required this.likedBy,
      required this.viewCount,
      required this.dayAgo,
      required this.caption,
      required this.id,
      required this.cat,
      required this.lat,
      required this.lng,
      this.isSingle = false,
      required this.postid,
      required this.isbookMark,
      required this.userid,
      this.onTap,this.onLocationTap});

  @override
  State<LocationPost> createState() => _LocationPostState();
}

class _LocationPostState extends State<LocationPost> {
  //bool isLoved = false;

  List likes = [];
  @override
  void initState() {
    super.initState();
     getimage();
    // getLiked();
    print("is loved status is in init state of LocationPost${widget.isLoved}");
  }

  getLiked() {
    likes = [];
    for (int i = 0; i < widget.likedBy!.length; i++) {
      if (widget.likedBy![i]['_id'] == widget.userid) {
        //  isLoved = true;
        // likes.add(widget.userid);
      } else {
        //isLoved = false;
        // likes.add('');
      }
      //print('my lieks are $isLoved');
    }

 

    setState(() {
      //   isLoved = widget.isLoved!;
      //  print("IsLoved is $isLoved");
    });
  }

  bool isPostBookmarked = false;
int imageheight = 100 ;
  getimage()async{

       var  imageData = (await NetworkAssetBundle(Uri.parse(widget.postImg))
            .load(widget.postImg))
            .buffer
            .asUint8List();

             List<int> bytes = Uint8List.view(imageData.buffer);
   var  decodedImage = await decodeImageFromList(Uint8List.fromList(bytes));
print(decodedImage.width);
print("my height is ${decodedImage.height}");

imageheight = decodedImage.height;

setState(() {
  
});

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        elevation: 0.0,backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.profileImg),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Istanbul, indiah',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  popupMenu()
                  // const Icon(
                  //   LineIcons.verticalEllipsis,
                  //   color: white,
                  //   size: 30,
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),

             SizedBox(
     height: 350,
             width: width(context),
  child:widget.postImg.length==1?  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Container(
              height: imageheight.toDouble(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.postImg[0]), fit: BoxFit.fitHeight)),
            ),
          ):Swiper(
    outer:false,
    itemBuilder: (c, i) {
      return 
     Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Container(
              height:300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.postImg[i]), fit: BoxFit.fitHeight)),
            ),
          );
    },
    pagination: SwiperPagination(
      margin: EdgeInsets.all(5.0)
    ),
    itemCount: widget.postImg.length,
  ),
   // constraints:BoxConstraints.loose(width(context))
),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
            //   child: Container(
            //     height: 400,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         image: DecorationImage(
            //             image: NetworkImage(widget.postImg), fit: BoxFit.cover)),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 30, top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.isLoved = !(widget.isLoved);
                          });
                          setState(() {
                            if (widget.isLoved) {
                              widget.likedBy.add({'_id': "${widget.userid}"});
                            } else {
                              widget.likedBy.removeLast();
                            }
                          });
                          PostFunctions()
                              .likeDislike(context, widget.postid, widget.userid)
                              .then((value) async {
                            if (value['message'] ==
                                "the article has been liked") {
                              setState(() {
                                widget.isLoved = true;
                                // print("isloved is $isLoved");
                              });
                            } else {
                              setState(() {
                                widget.isLoved = false;
    
                                //   isLoved = false;
                                //  print("isloved is $isLoved");
                              });
                            }
    
                            await getArticlesbyarticleID();
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/like_icon.png",
                              width: 27,
                              color: widget.isLoved ? pc : Colors.grey[600],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.likedBy.length.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      // : InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         isLoved = !isLoved;
                      //         print("isloved is $isLoved");
                      //       });
                      //       PostFunctions()
                      //           .likeDislike(
                      //               context, widget.postid, widget.userid)
                      //           .then((value) => {
                      //                 if (value['message'] ==
                      //                     "the article has been liked")
                      //                   {
                      //                     setState(() {
                      //                       //  isLoved = true;
                      //                       //   print("isloved is $isLoved");
                      //                     }),
                      //                     if (widget.callback != null)
                      //                       {
                      //                         widget.callback!.call(),
                      //                       }
                      //                   }
                      //                 else
                      //                   {
                      //                     // setState(() {
                      //                     //   isLoved = false;
                      //                     //   print("isloved is $isLoved");
                      //                     // }),
                      //                     if (widget.callback != null)
                      //                       {
                      //                         widget.callback!.call(),
                      //                       }
                      //                   }
                      //               });
                      //     },
                      //     child: Image.asset(
                      //       "assets/icons/like_icon.png",
                      //       width: 27,
                      //       color: Colors.black,
                      //     ),
                      //   ),
    
                      // SvgPicture.asset("assets/images/love_icon.svg",width: 27,color: Colors.black,),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => CommentCard(
                                            snap: widget.viewCount,
                                            postid: widget.id,
                                          ))).then(
                                (value) async {
                                  await getArticlesbyarticleID();
                                },
                              );
                              // navandThen(
                              //     context,
                              //     CommentCard(
                              //       snap: widget.viewCount,
                              //       postid: widget.id,
                              //     ),
                              //     getArticlesbyarticleID());
                            },
                            child: Image.asset(
                              "assets/icons/comment_icon.png",
                              width: 27,
                              color: Colors.black,
                            ),
                          ),
    
                          //  SvgPicture.asset("assets/images/comment_icon.svg",width: 27,
    
                          //   color: Colors.black,),
                          const SizedBox(
                            width: 10,
                          ),
    
                          Text('${widget.viewCount.length}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        widget.lat == null || widget.lat == ""
                            ? SizedBox()
                            : InkWell(
                              onTap: widget.onLocationTap,
                              child: Image.asset(
                                  "assets/icons/loc_icon.png",
                                  width: 27,
                                  color: Colors.black,
                                ),
                            ),
    
                        //  SvgPicture.asset("assets/images/message_icon.svg",width: 27,color: Colors.black,),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: widget.onTap,
                          // onTap: () {
                          //   //  if (isPostBookmarked) {
                          //   //   setState(() {
                          //   //     isPostBookmarked = false;
                          //   //   });
                          //   //  PostFunctions()
                          //   //     .deleteBookmark(postid: widget.postid);
                          //   //} else {
                          //   ////   setState(() {
                          //   isPostBookmarked = true;
                          //   // });
                          //   PostFunctions().addbookmark(
                          //       userid: widget.userid, postid: widget.postid);
                          //   // }
                          // },
                          child: widget.isbookMark
                              ? Image.asset(
                                  "assets/icons/saved_icon.png",
                                  width: 27,
                                  color: Colors.black,
                                )
                              : Image.asset(
                                  "assets/icons/save_icon.png",
                                  width: 27,
                                  color: Colors.black,
                                ),
                        ),
    
                        // SvgPicture.asset("assets/images/save_icon.svg",width: 27,color: Colors.black,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left:25,right: 15,top: 0),
            //   child: RichText(text: TextSpan(
            //     children: [
            // const TextSpan(
            //   text: "Liked by ",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.black
            //   )
            // ),
            // TextSpan(
            //   text: "$likedBy ",
            //   style: const TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w700,
            //     color: Colors.black
            //   )
            // ),
            // const TextSpan(
            //   text: "and ",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //     color: Colors.black
            //   )
            // ),
            // const TextSpan(
            //   text: "Other",
            //   style: TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w700,
    
            //     color: Colors.black
            //   )
            // ),
    
            //     ]
            //   )),
            // ),
            const SizedBox(
              height: 12,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 35, right: 25, top: 0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${widget.name} ",
                      style: const TextStyle(
                          fontSize: 19,
                          //fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  TextSpan(
                      text: widget.caption,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5))),
                ]))),
            const SizedBox(
              height: 12,
            ),
            // Padding(padding: EdgeInsets.only(left: 15,right: 15),
            // child: Text("View $viewCount comments",style: TextStyle(
            //   color: white.withOpacity(0.5),
            //   fontSize: 15,
            //   fontWeight: FontWeight.w500
            // ),),
            // ),
            // SizedBox(height: 12,),
            // Padding(
    
            //   padding: EdgeInsets.only(left: 15,right: 15),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Row(
            //   children: <Widget>[
            //     Container(
            //       width: 30,
            //       height: 30,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         image: DecorationImage(image: NetworkImage(profileImg),fit: BoxFit.cover)
            //       ),
            //     ),
            //     const SizedBox(width: 15,),
            //     Text("Add a comment...",style: TextStyle(
            //   color: white.withOpacity(0.5),
            //   fontSize: 15,
            //   fontWeight: FontWeight.w500
            // ),),
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Text("😂",style: TextStyle(
            //       fontSize:
            //       20
            //     ),),
            //     SizedBox(width: 10,),
            //     Text("😍",style: TextStyle(
            //       fontSize:
            //       20
            //     ),),
            //      SizedBox(width: 10,),
            //      Icon(Icons.add_circle,color: white.withOpacity(0.5),size: 18,)
            //   ],
            // )
            //   ],
            // )
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 15),
              child: Text(
                '',
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  getArticlesbyarticleID() async {
    //isloading = true;

    var response = await PostFunctions().getArticlesbyarticleID(widget.id);

    print("my response is $response");

    widget.viewCount = response['comment'];
    widget.likedBy = response['likes'];

    print("My Like Status is  ${widget.isLoved}");
    print("my likes are ${widget.likedBy}");

    // isloading = false;
    setState(() {});
  }

  Widget popupMenu() {
    return PopupMenuButton(
      padding: const EdgeInsets.all(10),
      elevation: 10,
      color: Colors.grey.shade100,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 45,
        // margin: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //     boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black45)],
        //     color: Colors.white,
        //     shape: BoxShape.circle),
        child: const Icon(
          Icons.more_vert,
          color: Colors.grey,
        ),
      ),
      onSelected: (value) {
        if (value == 'Edit Post') {
          nav(
              context,
              EditPost(
                profileImg: widget.profileImg,
                name: widget.name,
                postImg: widget.postImg,
                isLoved: widget.isLoved,
                likedBy: widget.likedBy,
                viewCount: widget.viewCount,
                dayAgo: widget.dayAgo,
                caption: widget.caption,
                id: widget.id,
                cat: widget.cat,
                lat: widget.lat,
                lng: widget.lng,
              ));
        }
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('$value item pressed')));
      },
      itemBuilder: (context) {
        return [
          widget.dayAgo == "1"
              ? PopupMenuItem(child: Container())
              : PopupMenuItem(
                  onTap: () {
                    // print('kasdjf');

                    //nav(context, const EditPost());
                  },
                  value: 'Edit Post',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Post',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  )),
          widget.dayAgo == "1"
              ? PopupMenuItem(child: Container())
              : PopupMenuItem(
                  onTap: () async {
                    await PostFunctions().deletePost(context, widget.id);
                    // ignore: use_build_context_synchronously
                    //pop(context);
                  },
                  value: 'Delete Post',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Delete Post',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      //  Divider()
                    ],
                  )),
        ];
      },
    );
  }

  //   void getPosts() async {
  //   PrefManager().get('user', null).then((value) async {
  //     List<dynamic> getlist = await Controller()
  //             .getApi(id: value, endpoint: "getarticlesbyUserID") ??
  //         [];
  //     getlist.forEach((element) {
  //       posts.add(UserPost.fromJson(element));
  //     });
  //     setState(() {});
  //     print("Length is${posts.length}");
  //   });
  // }
}
