import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/text_fields.dart';


import '../../Global/color.dart';
import '../../Global/utils.dart';
import 'forget_password.dart';

class NewPassword extends StatefulWidget {
  dynamic data;
  NewPassword({Key? key, this.data}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  bool isloading = false;
  bool isobsecure = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('assets/Untitled.png'), fit: BoxFit.fill)),
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 80, left: 1),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/logo.jpg',
                              width: 100,
                            ),
                            // backgroundImage: AssetImage(
                            //   'assets/logo.jpg',
                            // ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              // color: Colors.purple,
                              height: isKeyboardVisible ? 300 : 450,
                              child: ListView(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Welcome Back!',
                                        style: TextStyle(
                                            color: pc,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Please Enter New Password',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                bottom: 8.0),
                                            child: Text(
                                              'New Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          customtextform(
                                              h: 80,
                                              prefixIcon: Icons.lock,
                                              //   suffixIcon: Icons.fork_right,
                                              //  labeltext: '  Email  ',
                                              hinttext: 'Enter New Password here',
                                              suffixIcon: !isobsecure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              context: context,
                                              isobsecure: isobsecure,
                                              ontap: () {
                                                isobsecure = !isobsecure;
                                                setState(() {});
                                              },
                                              controller: pw),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: BouncingWidget(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        scaleFactor: 1.5,
                                        onPressed: () async {
                                          if (pw.text.isEmpty) {
                                          } else {
                                            isloading = true;
                                            setState(() {});
                                            await AuthFunctions().resetpassword(
                                              context,
                                              widget.data['email'],
                                              pw.text.trim(),
                                              widget.data['_id'],
                                            );
                                            isloading = false;
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF2F68),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 63,
                                          width: 390,
                                          child: Center(
                                            child: isloading
                                                ?     spinkit
                                                : const Text(
                                                    'UPDATE',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     nav(context, const NewPassword());
                                    //   },
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: const [
                                    //       Text(
                                    //         'Already have an account? ',
                                    //         style: TextStyle(
                                    //           color: Colors.grey,
                                    //           fontSize: 16,
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         'Login.',
                                    //         style: TextStyle(
                                    //           color: Color(0xffFF2F68),
                                    //           fontSize: 16,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ])),
                          // const Text(
                          //   'Welcome Back!',
                          //   style: TextStyle(
                          //       color: pc,
                          //       fontSize: 26,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // const Text(
                          //   'Please Log In to Your Account',
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.normal),
                          // ),
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          // SizedBox(
                          //     //   color: Colors.black,
                          //     height: isKeyboardVisible ? 250 : 250,
                          //     child: ListView(
                          //         physics: const ScrollPhysics(),
                          //         shrinkWrap: true,
                          //         children: [
                          //           Center(
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 const Padding(
                          //                   padding: EdgeInsets.only(
                          //                       left: 8.0, bottom: 8.0),
                          //                   child: Text(
                          //                     'Email ID / Mobile / UserId',
                          //                     style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.normal),
                          //                   ),
                          //                 ),
                          //                 customtextform(
                          //                     h: 80,
                          //                     prefixIcon: Icons.mail,
                          //                     //   suffixIcon: Icons.fork_right,
                          //                     //  labeltext: '  Email  ',
                          //                     hinttext: 'Email',
                          //                     //  suffixIcon: Icons.person_outline,
                          //                     context: context,
                          //                     controller: email),
                          //                 const Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 8.0, left: 8.0, bottom: 8.0),
                          //                   child: Text(
                          //                     'Password',
                          //                     style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.normal),
                          //                   ),
                          //                 ),
                          //                 customtextform(
                          //                     h: 80,
                          //                     prefixIcon: Icons.lock,
                          //                     //   suffixIcon: Icons.fork_right,
                          //                     //  labeltext: '  Email  ',
                          //                     hinttext: 'Password',
                          //                     suffixIcon: Icons.visibility,
                          //                     context: context,
                          //                     controller: pw),
                          //               ],
                          //             ),
                          //           ),
                          //         ])),
                        ],
                      )),
                ],
              ));
        }),
      ),
    );
  }
}
