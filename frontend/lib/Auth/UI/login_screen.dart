import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:marginta/Auth/UI/signup_screen.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/text_fields.dart';
import 'package:marginta/Global/utils.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Global/color.dart';
import '../../Global/nav.dart';
import '../../provider/internet_provider.dart';
import '../../provider/sign_in_provider.dart';
import '../../utils/nextScreen.dart';
import '../../utils/snack_bar.dart';
import '../Functions/auth_functions.dart';
import 'forget_password.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  String emailsrch = '';
  String password = '';

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
              key: _scaffoldKey,
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
                              width: 140,
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
                              height: isKeyboardVisible ? 350 : 450,
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
                                        'Please Log In to Your Account',
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
                                                left: 8.0, bottom: 8.0),
                                            child: Text(
                                              'Email ID / Mobile / UserId',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                            controller: email,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                bottom: 8.0),
                                            child: Text(
                                              'Password',
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
                                              hinttext: 'Password',
                                              suffixIcon: isobsecure
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
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 40.0),
                                    //   child: BouncingWidget(
                                    //     duration:
                                    //         const Duration(milliseconds: 100),
                                    //     scaleFactor: 1.5,
                                    //     onPressed: () async {
                                    //       await awaitfun();
                                    //       // isloading = true;
                                    //       setState(() {});
                                    //       // ignore: use_build_context_synchronously
                                    //       // await AuthFunctions().sendEmail(
                                    //       //     email.text.trim(),
                                    //       //     pw.text.trim(),
                                    //       //     context);
                                    //       // isloading = false;
                                    //       // setState(() {});
                                    //     },
                                    //     child: Container(
                                    //       decoration: BoxDecoration(
                                    //           color: const Color(0xffFF2F68),
                                    //           borderRadius:
                                    //               BorderRadius.circular(5)),
                                    //       height: 63,
                                    //       width: 390,
                                    //       child: Center(
                                    //         child: isloading
                                    //             ? const Center(
                                    //                 child:
                                    //                        spinkit,
                                    //               )
                                    //             : const Text(
                                    //                 'LOGIN',
                                    //                 style: TextStyle(
                                    //                     color: Colors.white,
                                    //                     fontSize: 20),
                                    //               ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        nav(context, const ForgotPassword());
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, right: 38.0, bottom: 8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            'Forget Password?',
                                            style: TextStyle(
                                                color: Color(0xffFFB703),
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
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
                                          if (kDebugMode) {
                                            print("onPressed");
                                          }
                                          isloading = true;
                                          setState(() {});

                                          await AuthFunctions().login(
                                              email.text.trim(),
                                              pw.text.trim(),
                                              context);
                                          isloading = false;
                                          setState(() {});
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
                                                ? spinkit
                                                : const Text(
                                                    'LOGIN',
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
                                    //     nav(context, const LoginScreen2());
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

                          const SizedBox(
                            height: 20,
                          ),
                          isKeyboardVisible
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      height: 2,
                                      width: 100,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text(
                                      'or connect with',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      height: 2,
                                      width: 100,
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          // isKeyboardVisible
                          //     ? const SizedBox()
                          //     : BouncingWidget(
                          //         duration: const Duration(milliseconds: 100),
                          //         scaleFactor: 1.5,
                          //         onPressed: () {
                          //           if (kDebugMode) {
                          //             print("onPressed");
                          //           }
                          //         },
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               color: const Color(0xffD9D9D9),
                          //               borderRadius: BorderRadius.circular(5)),
                          //           height: 63,
                          //           width: 390,
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             children: [
                          //               Image.asset(
                          //                 'assets/fb_login.png',
                          //                 width: 30,
                          //               ),
                          //               const SizedBox(
                          //                 width: 5,
                          //               ),
                          //               const Center(
                          //                 child: Text(
                          //                   'Facebook',
                          //                   style: TextStyle(
                          //                       color: Color(0xff3B5998),
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 20),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          RoundedLoadingButton(
                            onPressed: () {
                              handleFacebookAuth();
                            },
                            controller: facebookController,
                            successColor: Colors.blue,
                            width: MediaQuery.of(context).size.width * 0.80,
                            elevation: 0,
                            borderRadius: 25,
                            color: Colors.blue,
                            child: Wrap(
                              children: [
                                // Icon(
                                //   FontAwesomeIcons.facebook,
                                //   size: 20,
                                //   color: Colors.white,
                                // ),
                                Image.asset(
                                  'assets/fb_login.png',
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Facebook",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              nav(context, const SignupScreen2());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Sign up.',
                                  style: TextStyle(
                                    color: Color(0xffFF2F68),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ));
        }),
      ),
    );
  }

  // handling facebookauth
  // handling google sigin in
  Future handleFacebookAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, RootApp());
    });
  }
}
