import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Posts/ViewPost/view_user_bookmark_posts.dart';
import 'package:marginta/Settings/ui/about.dart';
import 'package:marginta/Settings/ui/general_setting.dart';
import 'package:marginta/Settings/ui/notification.dart';
import 'package:marginta/Settings/ui/profile_page.dart';
import 'package:marginta/Settings/ui/security_setting.dart';

import '../../Account/functions/account_functions.dart';
import '../../Account/ui/edit_profile.dart';
import '../../Auth/UI/login_screen.dart';
import '../../Auth/UI/new_password.dart';
import '../../Auth/UI/welcome_screen.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/utils.dart';
import 'help_and_feedback.dart';
import 'location_setting.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var data;

  bool isloading2 = false;
  var user_id = "";
  getUserdetails() async {
    isloading2 = true;
    setState(() {});

    var userid = await PrefManager().get('user', '');
    setState(() {
      user_id = userid;
    });

    data = await AccountFunctions().getuser(userid);

    await PrefManager().set('userdetaills', json.encode(data));
    logs("my data is $data");

    isloading2 = false;
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              navandThenNav(context, RootApp(), AccountScreen());

              //  pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: isloading2
          ? Center(
              child: spinkit,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 5.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          //  color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 0.5, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Edit Profile',
                                  ontap: () {
                                    nav(
                                        context,
                                        EditProfile(
                                          data: data,
                                        ));
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(),
                              ),
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Bookmark Posts',
                                  ontap: () {
                                    nav(
                                      context,
                                      BookMarkPosts(
                                        userid: user_id,
                                      ),
                                    );
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(),
                              ),
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'General',
                                  ontap: () {
                                    nav(context, const ProfilePage());
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(),
                              ),
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Location',
                                  ontap: () {
                                    nav(context, LocationSetting());
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(
                                  height: 1,
                                ),
                              ),
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Security',
                                  ontap: () {
                                    nav(context, SecurityScreen());
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(
                                  height: 1,
                                ),
                              ),
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Notifications',
                                  ontap: () {
                                    nav(context, notificationPage());
                                  }),
                              //SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      'Privacy',
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(15.0),
                      elevation: 5.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          //  color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 0.5, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'About',
                                  ontap: () {
                                    nav(context, AboutUs());
                                  }),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(
                                  height: 1,
                                ),
                              ),

                              listtile2(
                                  icon1: Icons.lock_open_rounded,
                                  text: 'Help & Feedback',
                                  ontap: () {
                                    nav(context, HelpAndFeedback());
                                  }),

                              //SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // tile('Account Security'),
                  //    tile('Easy Mode'),
                  // tile3('General', 'Location', "Security","Notifications"),
                  //  Spacer(),
// const Text('Privacy',style: TextStyle(fontSize: 20,color: Colors.grey),),

//   tile2('Friend\'s Permissions','My Information & Authorizations'),
//   tile2('About','Help & Feedback'),   SizedBox(height: 10,),

                  Spacer(),

                  //  Padding(
                  //                                     padding: const EdgeInsets.symmetric(
                  //                                         horizontal: 40.0),
                  //                                     child: BouncingWidget(
                  //                                       duration:
                  //                                           const Duration(milliseconds: 100),
                  //                                       scaleFactor: 1.5,
                  //                                       onPressed: () async {

                  //                                         await PrefManager().set('login', 'false');

                  //       // ignore: use_build_context_synchronously
                  // // navigateAndRemove(context, WelcomeScreen(data: data,),);

                  //   navigateAndRemove(context, LoginScreen2(),);
                  //                                       },
                  //                                       child: Container(
                  //                                         decoration: BoxDecoration(
                  //                                             color: Color.fromARGB(255, 212, 203, 203),
                  //                                             borderRadius:
                  //                                                 BorderRadius.circular(5)),
                  //                                         height: 63,
                  //                                         width: 390,
                  //                                         child:const Center(
                  //                                           child:  Text(
                  //                                                   'Switch Account',
                  //                                                   style: TextStyle(
                  //                                                       color: Colors.white,
                  //                                                       fontSize: 20),
                  //                                                 ),
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: BouncingWidget(
                      duration: const Duration(milliseconds: 100),
                      scaleFactor: 1.5,
                      onPressed: () async {
                        await PrefManager().set('login', 'false');

                        navigateAndRemove(
                          context,
                          LoginScreen2(),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFF2F68),
                            borderRadius: BorderRadius.circular(5)),
                        height: 63,
                        width: 390,
                        child: Center(
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  )
                ]),
    );
  }

  Widget tile(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        elevation: 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                listtile2(
                    icon1: Icons.lock_open_rounded, text: '$txt', ontap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tile2(txt1, txt2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        elevation: 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt1',
                    ontap: () {}),
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt2',
                    ontap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tile3(txt1, txt2, txt3, txt4) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Material(
        elevation: 1.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt1',
                    ontap: () {}),
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt2',
                    ontap: () {}),
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt3',
                    ontap: () {}),
                listtile2(
                    icon1: Icons.lock_open_rounded,
                    text: '$txt4',
                    ontap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listtile2({dynamic text, IconData? icon1, IconData? icon2, ontap}) {
    return BouncingWidget(
      duration: Duration(milliseconds: 100),
      scaleFactor: 1.5,
      onPressed: ontap,
      child: ListTile(
        // leading: Icon(
        //   icon1,
        //   size: 25,
        //   color: Colors.black,
        // ),
        title: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
