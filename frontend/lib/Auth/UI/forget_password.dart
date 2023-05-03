import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/nav.dart';

import '../../Global/color.dart';
import '../../Global/text_fields.dart';
import '../../Global/utils.dart';

import 'login_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/Untitled.png'), fit: BoxFit.fill)),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
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
                        const Text(
                          'Forget Password!',
                          style: TextStyle(
                              color: pc,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Please Enter email to reset the password',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                            //   color: Colors.black,
                            height: isKeyboardVisible ? 120 : 120,
                            child: ListView(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'Email ID',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        customtextform(
                                            h: 80,
                                            prefixIcon: Icons.mail,
                                            //   suffixIcon: Icons.fork_right,
                                            //  labeltext: '  Email  ',
                                            hinttext: 'Email',
                                            //  suffixIcon: Icons.person_outline,
                                            context: context,
                                            controller: email),
                                        // const Padding(
                                        //   padding: EdgeInsets.only(
                                        //       top: 8.0, left: 8.0, bottom: 8.0),
                                        //   child: Text(
                                        //     'Password',
                                        //     style: TextStyle(
                                        //         color: Colors.black,
                                        //         fontSize: 12,
                                        //         fontWeight: FontWeight.normal),
                                        //   ),
                                        // ),
                                        // customtextform(
                                        //     prefixIcon: Icons.lock,
                                        //     //   suffixIcon: Icons.fork_right,
                                        //     //  labeltext: '  Email  ',
                                        //     hinttext: 'Password',
                                        //     suffixIcon: Icons.visibility,
                                        //     context: context,
                                        //     controller: pw),
                                      ],
                                    ),
                                  ),
                                ])),
                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       top: 8.0, right: 35.0, bottom: 8.0),
                        //   child: Align(
                        //     alignment: Alignment.bottomRight,
                        //     child: Text(
                        //       'Forget Password',
                        //       style: TextStyle(
                        //           color: Color(0xffFFB703),
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.normal),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        BouncingWidget(
                          duration: const Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () async {
                            awaitfun();
                            isloading = true;
                            setState(() {});

                            if(email.text.isEmpty){}else{

                              await AuthFunctions().forgotpassword(
                                context, email.text.trim(), 'pw.text.trim()');
                            }
                            
                            // ignore: use_build_context_synchronously

                            isloading = false;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFF2F68),
                                borderRadius: BorderRadius.circular(5)),
                            height: 63,
                            width: 390,
                            child: Center(
                              child: isloading
                                  ?     spinkit
                                  : const Text(
                                      'SEND CODE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.grey,
                        //           borderRadius: BorderRadius.circular(0)),
                        //       height: 2,
                        //       width: 100,
                        //     ),
                        //     const SizedBox(
                        //       width: 2,
                        //     ),
                        //     const Text(
                        //       'or connect with',
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 2,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.grey,
                        //           borderRadius: BorderRadius.circular(0)),
                        //       height: 2,
                        //       width: 100,
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // BouncingWidget(
                        //   duration: const Duration(milliseconds: 100),
                        //   scaleFactor: 1.5,
                        //   onPressed: () {
                        //     if (kDebugMode) {
                        //       print("onPressed");
                        //     }
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: const Color(0xffD9D9D9),
                        //         borderRadius: BorderRadius.circular(5)),
                        //     height: 45,
                        //     width: 290,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/fb_login.png',
                        //           width: 25,
                        //         ),
                        //         const SizedBox(
                        //           width: 5,
                        //         ),
                        //         const Center(
                        //           child: Text(
                        //             'Facebook',
                        //             style: TextStyle(
                        //                 color: Color(0xff3B5998),
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                nav(context, const LoginScreen2());
                              },
                              child: const Text(
                                'Sign in.',
                                style: TextStyle(
                                  color: Color(0xffFF2F68),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ));
      }),
    );
  }
}
