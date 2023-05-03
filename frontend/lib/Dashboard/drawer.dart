import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/nav.dart';

import '../Location/UI/location_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var data;
  bool isloading = false;
  getUserDetails() async {
    isloading = true;
    setState(() {});
    //  var response = await Functions().getuserDetails();
    //if (response == null) {
    //} else {
    // data = await json.decode(await Functions().getuserDetails());
    // }
    if (kDebugMode) {
      print("userDetails is $data");
    }
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var a = Jiffy().yMMMMd;
    //  print("the $a");
    String formattedTime = DateFormat('kk:mm:a').format(DateTime.now());
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(0), topRight: Radius.circular(0)),
      child: SizedBox(
        width: 350,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, bottom: 0),
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(
                        //  color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          scale: 3,
                        )),
                    height: 120,
                    width: 120,
                    // child: Image.asset('assets/images/Group 272.png',fit: BoxFit.fill,

                    //scale: 3,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  // Text(
                  //   data == null ? 'Guest' : data['displayname'],
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //       fontSize: 22),
                  // ),
                  // data == null
                  //     ? Container()
                  //     : GestureDetector(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         //  nav(context, UpcomingBookings());
                  //         },
                  //         child: Text(
                  //           'Upcoming Events',
                  //           style: TextStyle(
                  //               color: Colors.white, fontSize: 14),
                  //         ),
                  //       ),
                  // Row(
                  //   children: const [
                  //     Text(
                  //       '',
                  //       style: TextStyle(color: Colors.white, fontSize: 12),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  // Container(
                  //   height: 10,
                  //   width: 30,
                  //   decoration: BoxDecoration(
                  //       color: Colors.blue[900],
                  //       borderRadius: BorderRadius.circular(30)),
                  //   child: Center(
                  //     child: Text(
                  //       '$formattedTime',
                  //       style:
                  //           TextStyle(color: Colors.white, fontSize: 6),
                  //     ),
                  //   ),
                  // )
                  //           ],
                  //         )
                  //   ],
                  // )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon1.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Location",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "WHERE YOU ARE?",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    
                   navigateAndRemove(context,   LocationScreen());
                    //  nav(context, MyProfile());
                    //  Navigator.pop(context);
                  },
                ),
              ),

              //2

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon2.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "YOUR\nCOCKTAIL",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "WHAT ARE YOU DRINKING",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "YOUR COCKTAIL"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              ///3
              ///
              ///

              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon3.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "ACTIVITY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "WHAT ARE YOU DOING?",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "ACTIVITY"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              //4

              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon4.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "FUR\nBUDDIES",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "IS THAT YOUR DOG?",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "FUR BUDDIES"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              //5

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon5.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "MIXOLOGY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "TRUE BELEVERS, RECIPES&\nMIXES",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "MIXOLOGY"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon6.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "YOUR\nLOCAL",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "WHERE CAN I GET\nA DRINK AROUND HERE?",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "YOUR LOCAL"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon7.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          const Text(
                            "EVENTS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "SHIT!!! WHATS\nHAPPENING THEN",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "EVENTS"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 22),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon8.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          const Text(
                            "TALL\nTALES",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "TALL TALES STORIES\nJOKES & COMMENT",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateAndRemove(context, RootApp(cat: "TALL TALES"));
                    //  Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 12),
                child: ListTile(
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon9.png',
                            width: 38,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          const Text(
                            "GOODIES",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "MERCHANISE",
                          style: TextStyle(
                              color: Colors.black,
                              //   fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Will available in next update');
                    //navigateAndRemove(context, RootApp(cat:"GOODIES"));
                    //  Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 50),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: ListTile(
              //     dense: true,
              //     title: Row(
              //       children: [
              //         Image.asset(
              //           'assets/icons/icon9.png',
              //           width: 28,
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           "T&C",
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 22),
              //         ),
              //       ],
              //     ),
              //     onTap: () {
              //       // nav(context, Termsandconditions2());
              //     },
              //   ),
              // ),
              // data == null
              //     ? Container()
              //     : Padding(
              //         padding: const EdgeInsets.only(top: 10.0),
              //         child: ListTile(
              //           dense: true,
              //           title: Row(
              //             children: [
              //               Icon(
              //                 Icons.delete,
              //                 color: Colors.white,
              //               ),
              //               // Image.asset(
              //               //   'assets/icons/Path 24766.png',
              //               //   width: 28,
              //               // ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 "Delete Acc",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 22),
              //               ),
              //             ],
              //           ),
              //           onTap: () {
              //             //  AwesomeDialog(
              //             //         context: context,
              //             //         dialogType: DialogType.question,
              //             //         animType: AnimType.rightSlide,
              //             //         title: 'Are you sure?',
              //             //         desc: 'You want to delete the account?',
              //             //         btnCancelOnPress: () {},
              //             //         btnOkOnPress: () {

              //             //            PrefManager().remove('userdetails');
              //             //                 //    if (data == null) {}
              //             //                 navigateAndRemove(context, SignIn());
              //             //         },
              //             //         btnCancelText: "NO",
              //             //         btnOkText: "YES"
              //             //         )..show();
              //           },
              //         ),
              //       ),
              // Spacer(),
              // data == null
              //     ? Container()
              //     : Padding(
              //         padding: const EdgeInsets.only(top: 10.0),
              //         child: ListTile(
              //           dense: true,
              //           title: Row(
              //             children: [
              //               Image.asset(
              //                 'assets/icons/logout.jpg',
              //                 width: 25,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 data == null ? 'Login' : "Logout",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 22),
              //               ),
              //             ],
              //           ),
              //           onTap: () async {
              //             //  PrefManager().remove('userdetails');
              //             //    if (data == null) {}
              //             //navigateAndRemove(context, SignIn());
              //           },
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
