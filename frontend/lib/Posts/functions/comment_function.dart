import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Global/nav.dart';

import '../../Account/ui/account_screen.dart';
import '../../Controller/api_methods.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/utils.dart';

class CommentFunctions {
  Future<dynamic> postComment(context, postid, desc) async {
    var userdetails =
        await json.decode(await PrefManager().get('userdetaills', {}));
    var body = {
      "user": userdetails['_id'],
      "description": desc,
      "username": userdetails['username'].isEmpty
          ? "ؐMargarita User"
          : userdetails['username'],
      "userimg": userdetails['image'].isEmpty
          ? "https://static.vecteezy.com/system/resources/previews/000/566/937/non_2x/vector-person-icon.jpg"
          : userdetails['image']
    };
    await Controller()
        .postApi(endpoint: 'addComment/$postid', body: body)
        .then((value) async => {
              if (value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {
                  //  navandThen(context, AccountScreen(), false),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  Future<dynamic> deletePost(
    context,
    id,
  ) async {
    await Controller()
        .deleteApi(endpoint: 'deletePost', id: id)
        .then((value) async => {
              if (value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {
                  Fluttertoast.showToast(msg: 'Post deleted successfully'),
                  navigateAndRemove(
                    context,
                    const AccountScreen(),
                  ),
                  logs(value),
                }
            });

    //   Fluttertoast.showToast(msg: 'Success');
  }

  var data;

  Future<dynamic> getcomments(id) async {
    await Controller()
        .getApi(endpoint: 'getCommentbyId', id: id)
        .then((value) async => {
              if (value['status'] == 'failure' || value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {data = value}
            });

    return data;
  }
}
