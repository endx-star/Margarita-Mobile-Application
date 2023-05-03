import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marginta/Global/color.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Posts/functions/comment_function.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../Global/nav.dart';

class CommentCard extends StatefulWidget {
  dynamic postid;
  dynamic snap;
  CommentCard({Key? key, required this.snap, required this.postid})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  TextEditingController comment = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    print("my snaps are ${widget.snap}");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
          child: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Comments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        progressIndicator: spinkit,
        child: ListView(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.snap.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 408.0),
                    child: const Center(
                      child: Text('No Comments Found'),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.snap.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      var data = widget.snap[index];
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    data['userimg'],
                                  ),
                                  radius: 18,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: data['username'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text:
                                                      ' ${data['description']}',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Text(
                                            '2',
                                            // DateFormat.yMMMd().format(
                                            //   widget.snap
                                            //       .data()['datePublished']
                                            //       .toDate(),
                                            // ),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: const EdgeInsets.all(8),
                                //   child: const Icon(
                                //     Icons.favorite,
                                //     size: 16,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      );
                    }))
            //  Spacer(),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30), color: pc),
                        child: TextFormField(
                          controller: comment,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Write your message",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30), color: pc),
                      child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () async {
                            if (comment.text.isEmpty) {
                            } else {
                              isloading = true;
                              setState(() {});
                              await CommentFunctions().postComment(
                                  context, widget.postid, comment.text.trim());

                              await getComments();
                            }

                            // await Database().sendmessage(
                            //     'chat',
                            //     {
                            //       'id': 'user',
                            //       'message': message.text.trim()
                            //     },
                            //     "${FirebaseAuth.instance.currentUser!.uid}_${widget.data['userid']}");
                            // message.text = '';
                            // Navigator.pop(context);
                          }),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }

  getComments() async {
    isloading = true;
    setState(() {});
    var response = await CommentFunctions().getcomments(widget.postid);

    widget.snap = response['comments'];

    isloading = false;
    setState(() {});
  }
}
