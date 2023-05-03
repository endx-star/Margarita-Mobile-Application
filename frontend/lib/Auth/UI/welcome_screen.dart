import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Auth/UI/signup_screen.dart';

import '../../Controller/shared_preferences.dart';
import '../../Global/nav.dart';

class WelcomeScreen extends StatefulWidget {
  dynamic data;
  WelcomeScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    print('my data is ${widget.data}');

    // ignore: prefer_const_constructors
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/Untitled.png'), fit: BoxFit.fill)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 120, left: 1),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.red,
                          backgroundImage: NetworkImage(widget.data['image'] ==
                                  ''
                              ? 'https://www.hollywoodreporter.com/wp-content/uploads/2013/08/nick_jonas_headshot_p_2013.jpg?w=2000&h=1126&crop=1'
                              : widget.data['image'])),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.data['name']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      const Text(
                        'Let\'s Share\n Cocktails',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      BouncingWidget(
                        duration: const Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        onPressed: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          await PrefManager().set('login', 'true');
                          // ignore: use_build_context_synchronously
                          navigateAndRemove(context, const AccountScreen());

                          if (kDebugMode) {
                            print(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString()
                                .substring(7, 11));
                            //   nav(context, LoginScreen2());
                          }

                          // await AuthFunctions().sendEmail(
                          //     'abrarmalik7236@gmail.com', 'ab', context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffFF2F68),
                              borderRadius: BorderRadius.circular(5)),
                          height: 63,
                          width: 349,
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(0)),
                            height: 2,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text(
                            'OR',
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
                                borderRadius: BorderRadius.circular(0)),
                            height: 2,
                            width: 100,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Switch accounts',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
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
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Sign up.',
                              style: TextStyle(
                                color: Color(0xffFF2F68),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
