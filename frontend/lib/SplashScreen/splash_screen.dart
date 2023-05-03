import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Auth/UI/welcome_screen.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/nav.dart';
import 'package:provider/provider.dart';

import '../Auth/UI/login_screen.dart';
import '../Controller/shared_preferences.dart';
import '../utils/nextScreen.dart';
import '../provider/sign_in_provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    // TODO: implement initState
    super.initState();
    // getsecond();
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen2())
          : nextScreen(context, RootApp());
    });
  }

  var userdetails;
  getsecond() async {
    await Future.delayed(const Duration(seconds: 3));
    var login = await PrefManager().get('login', null);

    print("my login is $login");

    if (login == null) {
// ignore: use_build_context_synchronously
      navigateAndRemove(context, const LoginScreen2());
    }
    // ignore: unnecessary_null_comparison
    else if (login == 'false') {
      userdetails =
          await json.decode(await PrefManager().get('userdetaills', {}));

// ignore: use_build_context_synchronously
      navigateAndRemove(context, WelcomeScreen(data: userdetails));
    } else {
      userdetails =
          await json.decode(await PrefManager().get('userdetaills', {}));
      print(userdetails);
      // ignore: use_build_context_synchronously
      navigateAndRemove(context, RootApp());
    }
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitCircle(
      color: Colors.red,
      size: 50.0,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          Image.asset(
            'assets/logo.png',
            width: 400,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 150,
          ),
          const Text(
            '"Dedicated to the pursuit of \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCocktails"',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 80,
          ),
          spinkit
        ],
      ),
    );
  }
}
