import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/text_fields.dart';

import '../../Global/color.dart';
import '../../Global/nav.dart';
import '../../Global/utils.dart';
import 'login_screen.dart';

class SignupScreen2 extends StatefulWidget {
  const SignupScreen2({Key? key}) : super(key: key);

  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  bool isloading = false;

  bool isobsecure = true;

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
                        Container(
                            // color: Colors.purple,
                            height: isKeyboardVisible ? 350 : 500,
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
                                      'Please Register an Account',
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
                                            'Email ID',

                                            /// Mobile / UserId',
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
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'Password',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: BouncingWidget(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      scaleFactor: 1.5,
                                      onPressed: () async {
                                        if (pw.text.length < 6) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Password must be greater or equal to 6 characters');
                                        } else {
                                          await awaitfun();
                                          isloading = true;
                                          setState(() {});
                                          // ignore: use_build_context_synchronously
                                          // await AuthFunctions().signup(
                                          //     email.text.trim(),
                                          //     pw.text.trim(),
                                          //     context);

                                          // ignore: use_build_context_synchronously
                                          await AuthFunctions().sendEmail(
                                              'template_3cpr88s',
                                              email.text.trim(),
                                              pw.text.trim(),
                                              context,
                                              resend: false,
                                              isforgot: false);
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
                                              ? Center(
                                                  child: spinkit,
                                                )
                                              : const Text(
                                                  'SIGN UP',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      nav(context, const LoginScreen2());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Already have an account? ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Login.',
                                          style: TextStyle(
                                            color: Color(0xffFF2F68),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])),
                      ],
                    )),
              ],
            ));
      }),
    );
  }
}
