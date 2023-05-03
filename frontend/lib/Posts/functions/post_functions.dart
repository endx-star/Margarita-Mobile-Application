import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Controller/shared_preferences.dart';
import 'package:marginta/Global/nav.dart';

import '../../Account/ui/account_screen.dart';
import '../../Controller/api_methods.dart';
import '../../Global/utils.dart';

class PostFunctions {
  Future<dynamic> likeDislike(context, postid, userid) async {
    var data;
    await PrefManager().get("user", null).then((value1) async {
      await Controller()
          .getApi(endpoint: "likedislike/${postid}", id: "${value1}")
          .then((value) => {
                if (value['status'] == 'failure' || value == null)
                  {
                    Fluttertoast.showToast(msg: 'error'),
                  }
                else
                  {data = value}
              });
    });

    return data;
  }

  Future<dynamic> updatePost(context, post) async {
    var body = {
      "lat": post.lat,
      "lng": post.lng,
      "description": post.description,
      "imgurl": post.imgurl,
      "user": post.user!.userid,
      "cat": post.cat
    };
    await Controller()
        .postApi(endpoint: 'updatePost/${post.id}', body: body)
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

  Future<dynamic> getArticlesbyarticleID(id) async {
    await Controller()
        .getApi(endpoint: 'getArticle', id: id)
        .then((value) async => {
              if (
               // value['status'] == 'failure' ||
                 value == null)
                {
                  Fluttertoast.showToast(msg: 'error'),
                }
              else
                {data = value}
            });

    return data;
  }

  addbookmark({userid, postid}) async {
    var body = {"user": userid, "post": postid};
    print(body);
    await Controller()
        .postApi(endpoint: "addBookMark", body: body)
        .then((value) => {
              print(value),
            });
  }

  deleteBookmark({postid, userid}) async {
    //var body = {"post": postid};
    await Controller()
        .deleteApi(endpoint: "deletebookMark", id: "$userid/$postid")
        .then((value) => {
              print(value),
            });
  }

  Future<dynamic> getAllBookMarks({userid}) async {
    var data;
    await Controller()
        .getApi(id: userid, endpoint: "getBookmark")
        .then((value) {
      print("in getAllbookmark function $value");
      data = value;
      // return value;
    });
    return data;
  }
}
