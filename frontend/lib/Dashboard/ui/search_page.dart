import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marginta/Global/utils.dart';

import '../../Controller/api_methods.dart';
import '../../Global/color.dart';
import '../../Model/user_post_model.dart';
import '../../Widgets/search_category_item.dart';
import '../../constant/search_json.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isloading = false;
  List<dynamic> fromAPi = [];
  List<UserPost> userPost = [];
  getDashboardPost() async {
    setState(() {
      isloading = true;
    });
    //https://margaritaapp.herokuapp.com/getarticlesbyUserID/63f1200d6d86af00148b0fb8
    //  await PrefManager().get("user", null).then((value) async {
    List<dynamic> postsList =
        await Controller().getApi(endpoint: "articles", id: '') ?? [];

    logs("postsList is$postsList");

    setState(() {
      fromAPi = postsList;
      // });

      // for (var element in postsList) {
      //   fromAPi.add(element);
      // userPost.add(UserPost.fromJson(element));
      //}

      if (kDebugMode) {
        print("Length is search${fromAPi.length}");
      }
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDashboardPost();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: isloading
          ? Center(
              child: spinkit,
            )
          : SingleChildScrollView(
              child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SafeArea(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: size.width - 30,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[350]),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: white.withOpacity(0.3),
                              )),
                          style: TextStyle(color: white.withOpacity(0.3)),
                          cursorColor: white.withOpacity(0.3),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 15),
                //     child: Row(
                //         children: List.generate(searchCategories.length, (index) {
                //       return CategoryStoryItem(
                //         name: searchCategories[index],
                //       );
                //     })),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: List.generate(fromAPi.length, (index) {
                    return Container(
                      width: (size.width - 3) / 3,
                      height: (size.width - 3) / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(fromAPi[index]['imgurl'] ??
                                  "https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-22%2000%3A57%3A18.121147%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker8497766138402990208.jpg%7D?alt=media&token=dc3a430e-74a8-490c-8af1-43ad01a93292"),
                              fit: BoxFit.cover)),
                    );
                  }),
                )
              ],
            )),
    );
  }
}
