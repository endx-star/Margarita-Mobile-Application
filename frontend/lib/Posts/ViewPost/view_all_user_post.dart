import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:marginta/Controller/api_methods.dart';
import 'package:marginta/Controller/shared_preferences.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/Posts/ViewPost/view_post.dart';

class ViewAllPost extends StatefulWidget {
  const ViewAllPost({super.key});

  @override
  State<ViewAllPost> createState() => _ViewAllPostState();
}

class _ViewAllPostState extends State<ViewAllPost> {
  List<UserPost> posts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  getPosts() async {
    posts = [];
    PrefManager().get('user', null).then((value) async {
      List<dynamic> getlist = await Controller()
              .getApi(id: value, endpoint: "getarticlesbyUserID") ??
          [];
      getlist.forEach((element) {
        posts.add(UserPost.fromJson(element));
      });
      setState(() {});
      print("Length is allpost${posts.length}");
    });
  } 

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 2,
        // childAspectRatio: 2.0,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext ctx, index) {
        return GestureDetector(
          onTap: () {
            navandThen(
                context,
                ViewPost(
                  userPost: posts[index],
                ),
                getPosts());
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white24,
                image: DecorationImage(
                  image: NetworkImage(posts[index].imgurl!),
                  fit: BoxFit.cover,
                )),
          ),
        );
      },
    );
  }
}
