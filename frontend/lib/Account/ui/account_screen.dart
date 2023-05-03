// ignore_for_file: file_names

import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';
import 'package:marginta/Account/functions/account_functions.dart';
import 'package:marginta/Account/ui/edit_profile.dart';
import 'package:marginta/Auth/UI/login_screen.dart';
import 'package:marginta/Auth/UI/welcome_screen.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Settings/ui/general_setting.dart';
import 'package:marginta/Settings/ui/settings.dart';
import 'package:marginta/Posts/UploadPost/add_post.dart';
import 'package:marginta/Posts/ViewPost/view_all_user_post.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../Controller/shared_preferences.dart';
import '../../Global/color.dart';
import '../../Global/utils.dart';
import '../utils/stories.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var data;

  bool isloading = false;

  getUserdetails() async {
    isloading = true;
    setState(() {});

    var userid = await PrefManager().get('user', '');

    data = await AccountFunctions().getuser(userid);

    await PrefManager().set('userdetaills', json.encode(data));
    // logs("my data is $data");
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdetails();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Scaffold(
            body: Center(child: spinkit),
          )
        : data == null
            ? Scaffold(
                body: Center(child: Text('Internet Issue')),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 120,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Row(
                          children: [
                            // const Icon(
                            //   Icons.lock,
                            //   color: Colors.black,
                            //   size: 18,
                            // ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${data['name'] == '' ? 'Name' : data['name']}',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () async {
//                   await showPullDownMenu(
//     context: context,
//     items: [ PullDownMenuItem(
//       enabled: true,
//       onTap: ()async {
//  await PrefManager().set('login', 'false');

//         // ignore: use_build_context_synchronously
//    navigateAndRemove(context, WelcomeScreen(data: data,),);

                                  // navigateAndRemove(context, LoginScreen2(),);
                                  //     },
                                  //     title: 'Logout',
                                  //     icon: Icons.logout,
                                  //   ),],
                                  // position: RelativeRect.fromLTRB(0, 40, 0, 0),

//  );
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black,
                                  size: 28,
                                )),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.blueGrey,
                              size: 28,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  nav(context, const Settings());
//nav(context,EditProfile(data: data,));
                                },
                                child: const Icon(
                                  Icons.menu,
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
                ),
                body: DefaultTabController(
                  length: 3,
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            ProfileHeader(data: data),
                            SizedBox(
                              height: 20,
                            ),
                            //tabheader(),
                            tabbody(data: data),
                          ],
                        ),
                      )),
                ),
              );
  }
}

class tabheader extends StatelessWidget {
  const tabheader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(indicatorColor: white, tabs: [
      Tab(icon: Icon(LineIcons.table)),
      Tab(icon: Icon(LineIcons.table)),
      Tab(icon: Icon(LineIcons.userCircle)),
    ]);
  }
}

class tabbody extends StatelessWidget {
  dynamic data;
  tabbody({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          ViewAllPost(),

          // first tab bar view widget
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  nav(context, AddPost());
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.8), width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LineIcons.plus,
                    color: white.withOpacity(0.8),
                    size: 35,
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Profile',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: white.withOpacity(0.9),
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: Text(
                  "When you share photos and vedios, they'll appear on your profile.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: white.withOpacity(0.4),
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Share your first photo or video',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 12, 97, 207),
                    fontSize: 16),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: white.withOpacity(0.8), width: 2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LineIcons.userTag,
                  color: white.withOpacity(0.8),
                  size: 35,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Profile',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: white.withOpacity(0.9),
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Text(
                  "When somone montion you in his photos or vedios, they'll appear on your profile.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: white.withOpacity(0.4),
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

bool isloading = false;

class ProfileHeader extends StatelessWidget {
  dynamic data;
  ProfileHeader({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        data['image'] == '' ? profile : data['image']),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${data['name'] == '' ? 'Name' : data['name']}',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          ExpandableText(
            '@${data['username'] == '' ? data['email'].toString().split("@")[0]: data['username']}',
            expandText: 'more',
            style:
                TextStyle(color: pc, fontWeight: FontWeight.bold, fontSize: 17),
            collapseText: 'less',
            expandOnTextTap: true,
            collapseOnTextTap: true,
            maxLines: 2,
            linkColor: white.withOpacity(0.5),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${data['content'].length}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: white,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Content',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    '${data['follower'].length}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: white,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Follower',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontSize: 17),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.black,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    '${data['following'].length}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: white,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Following',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontSize: 17),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ExpandableText(
            '${data['bio'] == '' ? '' : data['bio']}',
            expandText: 'more',
            style:
                TextStyle(color: pc, fontWeight: FontWeight.bold, fontSize: 17),
            collapseText: 'less',
            expandOnTextTap: true,
            collapseOnTextTap: true,
            maxLines: 2,
            linkColor: white.withOpacity(0.5),
          ),
          // Padding(
          //                         padding: const EdgeInsets.symmetric(horizontal:48.0),
          //                         child: BouncingWidget(
          //                           duration: const Duration(milliseconds: 100),
          //                           scaleFactor: 1.5,
          //                           onPressed: () async {
          //                           //  isloading = true;
          //                           nav(context,  EditProfile(data:data));
          //                           },
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                                 color: const Color(0xffFF2F68),
          //                                 borderRadius: BorderRadius.circular(5)),
          //                             height: 45,
          //                             width: 200,
          //                             child: Center(
          //                               child: isloading
          //                                   ?     spinkit
          //                                   : const Text(
          //                                       'Edit Profile',
          //                                       style: TextStyle(
          //                                           color: Colors.white, fontSize: 20),
          //                                     ),
          //                             ),
          //                           ),
          //                         ),
          //                       ),

          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              nav(context, AddPost());
            },
            child: Row(
              children: [
                Column(
                  children: [
                    DottedBorder(
                      color: Colors.green,
                      borderType: BorderType.Circle,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: Container(
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                              border: Border.all(color: black, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(data['image'] == ''
                                      ? profile
                                      : data['image']),
                                  fit: BoxFit.cover)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromARGB(255, 77, 241, 82)),
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      'Add Story',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: white,
                          fontSize: 16),
                    ),
                  ],
                ),

                // Column(
                //   children: [
                //     Container(
                //       height: 64,
                //       width: 64,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: white.withOpacity(0.3),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(2.0),
                //         child: Container(
                //           height: 63,
                //           width: 63,
                //           decoration: BoxDecoration(
                //               border: Border.all(color: black, width: 2),
                //               shape: BoxShape.circle,
                //               image: DecorationImage(
                //                   image: NetworkImage(profile),
                //                   fit: BoxFit.cover)),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 7,
                //     ),
                //     Text(
                //       'Oujda',
                //       style: TextStyle(
                //           overflow: TextOverflow.ellipsis,
                //           color: white,
                //           fontSize: 14),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   width: 20,
                // ),
                // Column(
                //   children: [
                //     Container(
                //       height: 63,
                //       width: 63,
                //       decoration: BoxDecoration(
                //         border:
                //             Border.all(color: white.withOpacity(0.4), width: 1),
                //         shape: BoxShape.circle,
                //       ),
                //       child: Icon(
                //         LineIcons.plus,
                //         color: white.withOpacity(0.8),
                //         size: 22,
                //       ),
                //     ),
                //     SizedBox(
                //       height: 7,
                //     ),
                //     Text(
                //       'New',
                //       style: TextStyle(
                //           overflow: TextOverflow.ellipsis,
                //           color: white,
                //           fontSize: 14),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
