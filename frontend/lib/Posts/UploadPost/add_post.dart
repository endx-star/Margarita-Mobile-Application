import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:marginta/Account/ui/account_screen.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Model/location_model.dart';
import 'package:marginta/Model/user_info_model.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/Posts/UploadPost/post_upload_helper.dart';
import 'package:marginta/Posts/ViewPost/view_all_user_post.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/image_controller.dart';
import '../../Controller/shared_preferences.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

     VideoPlayerController? _videocontroller;
   Future<void>? _initializeVideoPlayerFuture;
  //For DropDown for categories
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "CATEGORIES", child: Text("CATEGORIES")),
      const DropdownMenuItem(
          value: "YOUR COCKTAIL", child: Text("YOUR COCKTAIL")),
      const DropdownMenuItem(value: "ACTIVITY", child: Text("ACTIVITY")),
      const DropdownMenuItem(value: "FUR BUDDIES", child: Text("FUR BUDDIES")),
      const DropdownMenuItem(value: "MIXOLOGY", child: Text("MIXOLOGY")),
      const DropdownMenuItem(value: "YOUR LOCAL", child: Text("YOUR LOCAL")),
      const DropdownMenuItem(value: "EVENTS", child: Text("EVENTS")),
      const DropdownMenuItem(value: "TALL TALES", child: Text("TALL TALES")),
      const DropdownMenuItem(value: "GOODIES", child: Text("GOODIES")),
    ];
    return menuItems;
  }

  //post Url link;
  String uploadedUrl = "";
  //selected value of dropdown
  String selectedValue = "YOUR COCKTAIL";
  //Location
  bool isSwitched = false;
  //LocationOfPost latLongLocation = LocationOfPost(lat: 0, long: 0);
  String lat = "";
  String long = "";
  bool isloading = false;
  //caption controller;
  final TextEditingController _controller =  TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        _initializeVideoPlayerFuture = _videocontroller?.initialize();


  }

   @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
            title: const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 5, 5, 5),
              child: Text(
                "Post Text",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: "Montserrat-Medium",
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                ),
                child: SizedBox(
                  height: 20,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 0.0,
                      //  maximumSize: const Size(65, 40),
                      foregroundColor: const Color(0xFFFF2F68),
                      backgroundColor: const Color(0xFFFDEEF2),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Montserrat-Medium",
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      List<String> img =[];
                      if (_controller.text.isEmpty || image == null) {
                        Fluttertoast.showToast(
                            msg: 'Please fill all the fields first');
                      } else {
                        isloading = true;
                        setState(() {});
                        await PrefManager()
                            .get('user', null)
                            .then((value) async {
                          if (value != null) {
                            logs("user id is $value");

                            if (images.isNotEmpty) {

                              for(int i = 0; i<images.length;i++){

                                 await ProfileController().uploadFile(images[i]).then(
                                  (value) => {uploadedUrl = value.toString(),
                                  
                                  img.add(uploadedUrl)
                                  });
                              }
                            
                            }

                            UserPost newPost = UserPost(
                                likes: [],
                                comment: [],
                                lat: lat,
                                lng: long,
                                imgurl: json.encode(img),
                                description: _controller.text.trim(),
                                cat: selectedValue,
                                user: UserInfoModel(userid: value));

                            // de: ,
                            // postURL: await uploadedUrl,
                            //  location: latLongLocation,
                            //category: selectedValue,
                            //);

                            // ignore: use_build_context_synchronously
                            await addPostToData(newPost, context);
                          } else {
                            logs("data is returned AS NULL");
                            Fluttertoast.showToast(msg: "USer not login");
                          }
                          isloading = false;
                          setState(() {});
                        });
                      }

                      //   await PrefManager().set("post", postString).then((value) {
                      //   print("I'm in then$value");
                      // print(postString);
                      //  });
                    },
                    child: const Text(
                      "Post",
                    ),
                  ),
                ),
              )
            ]),
        body: ModalProgressHUD(
          inAsyncCall: isloading,
          progressIndicator: spinkit,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height(context),
              width: width(context),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xFF838383),
                            ),
                          ),
                          hintText: 'Say Something ...',
                          hintStyle: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFFC8C8C8),
                            fontFamily: "Montserrat-Medium",
                          ),
                          hintMaxLines: 5,
                          //contentPadding: EdgeInsets.symmetric(vertical: 40),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customerUploadRow(),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Color(0xFFF2F2F2),
                    ),
                    customLocationRow(),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Color(0xFFF2F2F2),
                    ),
                    Flexible(
                      child: customCategoryRow(),
                    ),

                    images.isEmpty
              ? Container()
              : SizedBox(
                  height: 200,
                  width: width(context),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, i) {
                      
                      return Stack(
                        children: [
                        //images[i].toString().contains(".mp4")?
                        
//                         SizedBox(
//                          //,

// width: 200,                          child: Column(children: [FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the VideoPlayerController has finished initialization, use
//             // the data it provides to limit the aspect ratio of the video.
//             return AspectRatio(
//               aspectRatio: 3/4,
//               // Use the VideoPlayer widget to display the video.
//               child: VideoPlayer(_videocontroller!),
//             );
//           } else {
//             // If the VideoPlayerController is still initializing, show a
//             // loading spinner.
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
    //    FloatingActionButton(
    //     onPressed: () {
    //       print("im pressed");
    //         _videocontroller?.play();
    //       // Wrap the play or pause in a call to `setState`. This ensures the
    //       // correct icon is shown.
    //       setState(() {
    //         // If the video is playing, pause it.
    //         if (_videocontroller!.value.isPlaying) {
    //           _videocontroller!.pause();
    //         } else {
    //           // If the video is paused, play it.
    //           _videocontroller!.play();
    //         }
    //       });
    //     },
    //     // Display the correct icon depending on the state of the player.
    //     child: Icon(
    //       _videocontroller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    
    // )
    // ],),
    //                     ),
    //: 
    Container(),
      Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              images[i],
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                          ),
                          Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
          onTap: (){
            print('delete image from List');
            images.removeAt(i);
              setState((){
                print('set new state of images');
              });


          },
          child: Icon(
        Icons.cancel,
        color: Colors.white,
      ),
     ),
    ),
                        ],
                      );

                    },
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customerUploadRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 35, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                CupertinoIcons.photo_on_rectangle,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Photo/Video",
                style: TextStyle(
                  fontFamily: "Montserrat-Medium",
                  fontSize: 18,
                ),
              ),
            ],
          ),
                
          TextButton(
            style: TextButton.styleFrom(
              elevation: 0.0,
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFFFF2F68),
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat-Medium",
                fontSize: 18,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.red)),
            ),
            onPressed: () async {
              if(images.length==3){
                Fluttertoast.showToast(msg: 'You can upload 3 images max');
              }else{
       _showPicker(context);

              }
       
              // File file = await pickPostImage();
              // if (file != null) {
              //   uploadedUrl = await uploadFile(file);
              //   Fluttertoast.showToast(msg: "Selected");
              // } else {
              //   Fluttertoast.showToast(msg: "No Item Selected");
              // }
            },
            child: const Text("Upload"),
          ),
        ],
      ),
    );
  }

  Widget customLocationRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Location",
                style: TextStyle(
                  fontFamily: "Montserrat-Medium",
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Switch(
              activeColor: const Color(0xFFFF2F68),
              value: isSwitched,
              onChanged: (value) async {
                if (!isSwitched) {
                  try {
                    setState(() {
                      isSwitched = value;
                    });
                    Location location = new Location();

                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    isSwitched = await location.serviceEnabled();
                    if (!isSwitched) {
                      isSwitched = await location.requestService();
                      if (!isSwitched) {
                        return;
                      }
                    }
                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }

                    _locationData = await location.getLocation();

                    setState(() {
                      lat = _locationData.latitude.toString();
                      long = _locationData.longitude.toString();
                    });
                  } catch (e) {
                    print("Error Logs");
                    print(e.toString());
                  }
                } else {
                  setState(() {
                    isSwitched = value;
                  });
                }
              })
        ],
      ),
    );
  }

  dynamic image;

  List<dynamic> images =[];
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text(
                      'Photo From Library',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      await ProfileController()
                          .pickImage(ImageSource.gallery)
                          .then((value) {
                        if (value != null) {
                                images.add(value);
                           setState(() {
                        image = value;
                      });
                
                        }
                        // setState(() {
                        //   image = value;
                        // });
                      });
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text(
                    'Photo From Camera',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () async {
                    await ProfileController()
                        .pickImage(ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        // if(value.toString().contains(".mp4")){

                        //    VideoPlayerController.file(value);
                        //      images.add( VideoPlayerController.file(value));
                        // }else{  
                          images.add(value);}

                            
                         setState(() {
                        image = value;
                      });


                     // images.add(value);
                     // }
                     
                    });
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
    //              ListTile(
    //               leading: const Icon(Icons.photo_camera),
    //               title: const Text(
    //                 'Video From Library',
    //                 style: TextStyle(color: Colors.grey),
    //               ),
    //               onTap: () async {
    //                 await ProfileController()
    //                     .pickVideo(ImageSource.gallery)
    //                     .then((value) {
    //                   if (value != null) {
    //                       if(value.toString().contains(".mp4")){

    //                        VideoPlayerController.file(value);
    //                          images.add( VideoPlayerController.file(value));
    //                     }else{  images.add(value);}
    //                      setState(() {
    //                     image = value;
    //                   });
    //                  // images.add(value);
    //                   }
                     
    //                 });
    //                 Navigator.of(context).pop();
    //                 setState(() {});
    //               },
    //             ),
    //              ListTile(
    //               leading: const Icon(Icons.photo_camera),
    //               title: const Text(
    //                 'Video From Camera',
    //                 style: TextStyle(color: Colors.grey),
    //               ),
    //               onTap: () async {
    //                 await ProfileController()
    //                     .pickVideo(ImageSource.camera)
    //                     .then((value) {
    //                   if (value != null) {

    //                       if(value.toString().contains(".mp4")){

    //                       _videocontroller = VideoPlayerController.file(value);
    //                           _initializeVideoPlayerFuture = _videocontroller?.initialize();
    // _videocontroller?.setLooping(true);
    // _videocontroller?.play();

    //                          images.add( VideoPlayerController.file(value));
    //                     }else{  images.add(value);}
    //                      setState(() {
    //                     image = value;
    //                   });
    //                  // images.add(value);
    //                   }
                     
    //                 });
    //                 Navigator.of(context).pop();
    //                 setState(() {});
    //               },
    //             ),
              ],
            ),
          );
        });
  }

  Widget customCategoryRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.widgets_outlined,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Select Category",
                style: TextStyle(
                  fontFamily: "Montserrat-Medium",
                  fontSize: 18,
                ),
              ),
            ],
          ),
          DropdownButton(elevation: 1,
            value: selectedValue,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          )
        ],
      ),
    );
  }
}
