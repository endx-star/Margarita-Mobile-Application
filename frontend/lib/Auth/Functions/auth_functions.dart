import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Auth/UI/login_screen.dart';
import 'package:marginta/Auth/UI/pin_put.dart';
import 'package:marginta/Dashboard/ui/root_app.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Model/user_model.dart';
import '../../Controller/api_methods.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/nav.dart';
import '../../Settings/ui/profile_page.dart';
import '../../Settings/ui/settings.dart';

class AuthFunctions {
  Future<dynamic> login(email, pass, context) async {
    if (email.isEmpty || pass.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter all the fields first');
    } else {
      if (email.contains('@') && email.contains('.com')) {
        var body = {'email': email, 'password': pass};
        await Controller()
            .postApi(endpoint: 'login3', body: body)
            .then((value) async => {
                  if (value == null ||
                      value == "Unauthorized" ||
                      value == "User not exist")
                    {Fluttertoast.showToast(msg: 'Unauthorized ')}
                  else
                    {
                      await PrefManager().set('user', value['_id']),
                      await PrefManager().set('login', 'true'),
                      await PrefManager().set('userlogin', json.encode(body)),
                      Fluttertoast.showToast(msg: 'Success '),
                      navigateAndRemove(
                        context,
                        RootApp(),
                      )
                    }
                });
      }
    }
  }

  Future<String> signup(email, password, context) async {
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter all the fields first');
    } else {
      if (email.contains('@') && email.contains('.com')) {
        var body = {'email': email, 'password': password, 'usertype': 'user'};

        await Controller()
            .postApi(endpoint: 'signupwithbycript2', body: body)
            .then((value) async => {
                  if (value == null || value == 'email is not avilable')
                    {Fluttertoast.showToast(msg: 'email is not available')}
                  else
                    {
                      body = {
                        'email': email,
                        'name': '',
                        'usertype': 'user',
                        'username': '',
                        'bio': '',
                        'userid': value['_id'],
                        'image': '',
                        'firstname': '',
                        'lastname': '',
                        'phone': ''
                      },
                      await Controller()
                          .postApi(endpoint: 'adduser', body: body)
                          .then((value) => {
                                if (value != null)
                                  {
                                    //Fluttertoast.showToast(msg: 'Register successfully'),
                                  }
                              }),
                      Fluttertoast.showToast(msg: 'Register successfully'),
                      navandThen(context, const LoginScreen2(), false)
                    }
                });
      } else {
        Fluttertoast.showToast(msg: 'email format is wrong');
      }
    }
    return "Register";
  }

  Future<dynamic> forgotpassword(context, email, password,
      {changepw = false}) async {
    var body = {'email': email, 'password': password, 'usertype': 'user'};
    await Controller()
        .postApi(endpoint: 'forgotpasswordss', body: body)
        .then((value) async => {
              if (value == 'User not exist' || value == null)
                {
                  Fluttertoast.showToast(msg: 'User not exist'),
                }
              else
                {
                  await AuthFunctions().sendEmail(
                      'template_nbdhd4a', email, password, context,
                      resend: false,
                      isforgot: true,
                      data: value,
                      changepw: changepw),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<String> sendEmail(tempid, email, password, context,
      {resend,
      isforgot,
      data,
      firstname,
      lastname,
      phone,
      isgeneral,
      changepw}) async {
    var code =
        DateTime.now().millisecondsSinceEpoch.toString().substring(7, 11);
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
          msg:
              'Please enter all the fields first or password must be greater than 6 digits');
    } else {
      if (EmailValidator.validate(email)) {
        var body = {
          'service_id': 'service_04pzfgo',
          'template_id': '$tempid',
          'user_id': 'd1V_FkWvrBglq1D3r',
          'template_params': {
            'to_name': email.toString().split("@")[0],
            'message': code,
            'to_email': firstname == null ? email : password
          }
        };
        await Controller()
            .sendEmailApi(
                endpoint: 'https://api.emailjs.com/api/v1.0/email/send',
                body: json.encode(body))
            .then((value) async => {
                  if (value == "OK")
                    {
                      if (!resend)
                        {
                          navigateAndRemove(
                            context,
                            VerifyCode(
                                code: code,
                                email: email,
                                password: password,
                                isforgot: isforgot,
                                data: data,
                                changepw: changepw,
                                firstname: firstname,
                                lastname: lastname,
                                phone: phone),
                          ),
                        },
                      logs('success')
                    }
                });
      } else {
        Fluttertoast.showToast(msg: 'email format is wrong');
      }
    }
    return code;
  }

  Future<dynamic> resetpassword(context, email, password, id) async {
    var body = {'email': email, 'password': password, 'usertype': 'user'};
    await Controller()
        .postApi(endpoint: 'updateuserbyid/$id', body: body)
        .then((value) async => {
              if (value == 'User not exist' || value == null)
                {
                  Fluttertoast.showToast(msg: 'User not exist'),
                }
              else
                {
                  Fluttertoast.showToast(msg: 'Success'),
                  navandThen(context, LoginScreen2(), false)
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<dynamic> updatepassword(context, email, password, id) async {
    var body = {'email': email};
    await Controller()
        .postApi(endpoint: 'updateuserbyid/$id', body: body)
        .then((value) async => {
              if (value == 'User not exist' || value == null)
                {
                  Fluttertoast.showToast(msg: 'User not exist'),
                }
              else
                {
                  Fluttertoast.showToast(msg: 'Success'),
                  navandThen(context, LoginScreen2(), false)
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<dynamic> updatepasswords(context, email, password, id) async {
    var body = {'password': password};
    await Controller()
        .postApi(endpoint: 'updateuserbyid/$id', body: body)
        .then((value) async => {
              if (value == 'User not exist' || value == null)
                {
                  Fluttertoast.showToast(msg: 'User not exist'),
                }
              else
                {
                  Fluttertoast.showToast(msg: 'Success'),
                  navandThenNav(context, const ProfilePage(), const Settings())

                  // navandThen(context, LoginScreen2(), false)
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }
}

class A {}
