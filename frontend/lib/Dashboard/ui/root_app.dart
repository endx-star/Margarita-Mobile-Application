import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marginta/Account/ui/account_screen.dart';

import 'package:marginta/Dashboard/ui/search_page.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Location/UI/location_screen.dart';
import 'package:marginta/Posts/UploadPost/add_post.dart';

import '../../Global/color.dart';
import 'dashboard.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RootApp extends StatefulWidget {
  dynamic cat;
  RootApp({this.cat});
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    AwesomeDialog(
        dialogBackgroundColor: pc,
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.rightSlide,
        title: 'Exit',
        desc: 'Do  you want to Exit this App?',
        // btnOkColor: ColorSelect().bluegrey,
        // btnCancelColor: ColorSelect().darkblue,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        descTextStyle: TextStyle(color: Colors.white),
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          exit(0);
        },
        btnOkText: 'Yes',
        btnCancelText: 'No')
      ..show();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nav(context, AddPost());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Color.fromARGB(255, 75, 223, 80),
          tooltip: 'Capture Picture',
          elevation: 0,
          splashColor: Colors.grey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //appBar: getAppBar(),
        backgroundColor: black,
        body: getBody(),
        bottomNavigationBar: getFooter(),
      ),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Dashboard(
        cat: widget.cat,
      ),
      SearchPage(),
      Container(),
      LocationScreen(),
      // const Scaffold(
      //   body: Center(
      //     child: Text(
      //       "Will Available in Next Update",
      //       style: TextStyle(
      //           fontSize: 20, fontWeight: FontWeight.bold, color: white),
      //     ),
      //   ),
      // ),

      const AccountScreen()
      // Center(
      //     child: Text("Activity Page",style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: white
      //     ),),

      //
      // ),
      // Center(
      //     child: Text("Account Page",style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: white
      //     ),),
      // )
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget? getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        backgroundColor: appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/camera_icon.svg",
              width: 30,
            ),
            const Text(
              "Instagram",
              style: TextStyle(fontFamily: 'Billabong', fontSize: 35),
            ),
            SvgPicture.asset(
              "assets/images/message_icon.svg",
              width: 30,
            ),
          ],
        ),
      );
    } else if (pageIndex == 1) {
      return null;
    } else if (pageIndex == 2) {
      return AppBar(
        backgroundColor: appBarColor,
        title: const Text("Upload"),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        backgroundColor: appBarColor,
        title: Text("Activity"),
      );
    } else {
      return AppBar(
        backgroundColor: appBarColor,
        title: Text("Account"),
      );
    }
  }

  List bottom = [
    "assets/icons/home_icon.png",
    "assets/icons/search_icon.png",
    "assets/icons/like_icon.png",
    "assets/icons/loc_icon.png",
    "assets/icons/profile_icon.png",
  ];
  Widget getFooter() {
    List bottomItems = [
      "assets/icons/home_icon.png",
      "assets/icons/search_icon.png",
      "assets/icons/like_icon.png",
      "assets/icons/loc_icon.png",
      "assets/icons/profile_icon.png",

      //   pageIndex == 0
      // ? "assets/images/home_active_icon.svg"
      // : "assets/images/home_icon.svg",
      //pageIndex == 1
      //     ? "assets/images/search_active_icon.svg"
      //     : "assets/images/search_icon.svg",
      // pageIndex == 2
      //     ? "assets/images/upload_active_icon.svg"
      //     : "assets/images/upload_icon.svg",
      // pageIndex == 3
      //     ? "assets/images/love_active_icon.svg"
      //     : "assets/images/love_icon.svg",
      // pageIndex == 4
      //     ? "assets/images/account_active_icon.svg"
      //     : "assets/images/account_icon.svg",
      // pageIndex == 0
      //     ? "assets/images/home_active_icon.svg"
      //     : "assets/images/home_icon.svg",
      // pageIndex == 1
      //     ? "assets/images/search_active_icon.svg"
      //     : "assets/images/search_icon.svg",
      // pageIndex == 2
      //     ? "assets/images/upload_active_icon.svg"
      //     : "assets/images/upload_icon.svg",
      // pageIndex == 3
      //     ? "assets/images/love_active_icon.svg"
      //     : "assets/images/love_icon.svg",
      // pageIndex == 4
      //     ? "assets/images/account_active_icon.svg"
      //     : "assets/images/account_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Image.asset(
                  bottomItems[index],
                  color: bottom[pageIndex] == bottomItems[index]
                      ? pc
                      : index == 2
                          ? Colors.transparent
                          : Colors.grey,
                  width: 25,
                  fit: BoxFit.cover,
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
