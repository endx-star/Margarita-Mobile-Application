import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Auth/UI/login_screen.dart';
import 'package:marginta/Auth/UI/pin_put.dart';
import 'package:marginta/Global/utils.dart';

import '../../Controller/api_methods.dart';
import '../../Controller/image_controller.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/nav.dart';
import '../../Settings/ui/profile_page.dart';
import '../../Settings/ui/settings.dart';

class AccountFunctions {
  Future<dynamic> login(email, pass, context) async {
    if (email.isEmpty || pass.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter all the fields first');
    } else {
      if (email.contains('@') && email.contains('.com')) {
        var body = {'email': email, 'password': pass};
        await Controller()
            .postApi(endpoint: 'login3', body: body)
            .then((value) => {
                  if (value == null || value == "Unauthorized")
                    {Fluttertoast.showToast(msg: 'Unauthorized ')}
                  else
                    {
                      PrefManager().set('user', value['_id']),
                      Fluttertoast.showToast(msg: 'Success '),
                      navandThen(context, const AccountScreen(), false)
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
                        'userid': value['_id']
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
                      // navandThen(context, const LoginScreen2(), false)
                    }
                });
      } else {
        Fluttertoast.showToast(msg: 'email format is wrong');
      }
    }
    return "Register";
  }

  Future<dynamic> forgotpassword(context, email, password) async {
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
                  await AccountFunctions().sendEmail(
                      'template_nbdhd4a', email, 'pw.text.trim()', context,
                      resend: false, isforgot: true, data: value),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<String> sendEmail(tempid, email, password, context,
      {resend, isforgot, data}) async {
    var code =
        DateTime.now().millisecondsSinceEpoch.toString().substring(7, 11);
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
          msg:
              'Please enter all the fields first or password must be greater than 6 digits');
    } else {
      if (email.contains('@') && email.contains('.com')) {
        var body = {
          'service_id': 'service_04pzfgo',
          'template_id': '$tempid',
          'user_id': 'd1V_FkWvrBglq1D3r',
          'template_params': {
            'to_name': email.toString().split("@")[0],
            'message': code,
            'to_email': '$email'
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
                          navandThen(
                              context,
                              VerifyCode(
                                  code: code,
                                  email: email,
                                  password: password,
                                  isforgot: isforgot,
                                  data: data),
                              false),
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
  }

  var data;

  Future<dynamic> getuser(id) async {
    await Controller()
        .getApi(endpoint: 'getuserinformation', id: id)
        .then((value) async => {
              if (value == 'User not exist' || value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {data = value}
            });

    return data;
  }

  Future<dynamic> checkusername(
      context, name, us, username, bio, img, imgurl, id) async {
    if (name.isEmpty || bio.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all the fields first');
    } else {
      if (username == us) {
        if (img != null) {
          await ProfileController()
              .uploadFile(img)
              .then((value) => {imgurl = value.toString()});
        }
        await updateprofile(context, name, us, bio, imgurl, id);
      } else {
        await Controller()
            .getApi(endpoint: 'checkusername', id: username)
            .then((value) async => {
                  if (value == null)
                    {
                      if (img != null)
                        {
                          await ProfileController()
                              .uploadFile(img)
                              .then((value) => {imgurl = value.toString()}),
                        },
                      await updateprofile(
                          context, name, username, bio, imgurl, id)
                    }
                  else
                    {
                      Fluttertoast.showToast(msg: 'Username is not available'),
                      data = value
                    }
                });
      }
    }

    return data;
  }

  Future<dynamic> updateprofile(
    context,
    name,
    username,
    bio,
    img,
    id,
  ) async {
    var body = {'name': name, 'username': username, 'bio': bio, 'image': img};
    await Controller()
        .postApi(endpoint: 'updateprofile/$id', body: body)
        .then((value) async => {
              if (value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {
                  navandThen(context, AccountScreen(), false),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<dynamic> updatesettings(
    context,
    firstname,
    lastname,
    email,
    phone,
    id,
  ) async {
    var body = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone
    };
    await Controller()
        .postApi(endpoint: 'updateprofile/$id', body: body)
        .then((value) async => {
              if (value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {
                  navandThenNav(context, const ProfilePage(), const Settings()),

                  //  navandThen(context, AccountScreen(), false),
                  Fluttertoast.showToast(msg: 'updated successfully'),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }
}
