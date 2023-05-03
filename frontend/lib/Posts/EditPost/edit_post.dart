import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Global/utils.dart';
import 'package:marginta/Model/user_info_model.dart';
import 'package:marginta/Model/user_post_model.dart';
import 'package:marginta/Posts/functions/post_functions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../Controller/image_controller.dart';
import '../../Controller/shared_preferences.dart';

class EditPost extends StatefulWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  // ignore: prefer_typing_uninitialized_variables
  final isLoved;
  final String likedBy;
  final List<dynamic> viewCount;
  final String dayAgo;
  final bool? isSingle;

  final dynamic id;
  final dynamic cat;
  final dynamic lat;

  final dynamic lng;

  // ignore: use_key_in_widget_constructors
  const EditPost({
    required this.profileImg,
    required this.name,
    required this.postImg,
    this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.dayAgo,
    required this.caption,
    required this.id,
    required this.cat,
    required this.lat,
    required this.lng,
    this.isSingle = false,
  });

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
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
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    uploadedUrl = widget.postImg;
    selectedValue = widget.cat;
    _controller.text = widget.caption;
    lat = widget.lat;
    long = widget.lng;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
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
              padding: const EdgeInsets.fromLTRB(0.0, 5, 5, 5),
              child: Text(
                "Edit Post",
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
                      //  if (_controller.text.isEmpty || image == null) {
                      // Fluttertoast.showToast(
                      //     msg: 'Please fill all the fields first');
                      //  } else {
                      isloading = true;
                      setState(() {});
                      await PrefManager().get('user', null).then((value) async {
                        if (value != null) {
                          logs("user id is $value");

                          if (image != null) {
                            await ProfileController().uploadFile(image).then(
                                (value) => {uploadedUrl = value.toString()});
                          }

                          UserPost newPost = UserPost(
                              id: widget.id,
                              isLoved: false,
                              likes: [],
                              comment: [],
                              lat: lat,
                              lng: long,
                              imgurl: uploadedUrl,
                              description: _controller.text.trim(),
                              cat: selectedValue,
                              user: UserInfoModel(userid: value));

                          // ignore: use_build_context_synchronously
                          await PostFunctions().updatePost(context, newPost);

                          // de: ,
                          // postURL: await uploadedUrl,
                          //  location: latLongLocation,
                          //category: selectedValue,
                          //);

                          // await EditPostToData(newPost, context);
                        } else {
                          logs("data is returned AS NULL");
                          Fluttertoast.showToast(msg: "USer not login");
                        }
                        isloading = false;
                        setState(() {});
                      });
                      // }

                      //   await PrefManager().set("post", postString).then((value) {
                      //   print("I'm in then$value");
                      // print(postString);
                      //  });
                    },
                    child: const Text(
                      "Update",
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
                      padding: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
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
      padding: EdgeInsets.fromLTRB(12, 35, 10, 10),
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
          uploadedUrl != ""
              ? SizedBox(
                  height: 70,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      uploadedUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : image == null
                  ? Container()
                  : SizedBox(
                      height: 70,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          TextButton(
            style: TextButton.styleFrom(
              elevation: 0.0,
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFFF2F68),
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat-Medium",
                fontSize: 18,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.red)),
            ),
            onPressed: () async {
              _showPicker(context);
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
      padding: EdgeInsets.fromLTRB(12, 20, 10, 20),
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
                      'Photo Library',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      await ProfileController()
                          .pickImage(ImageSource.gallery)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            image = value;
                            uploadedUrl = '';
                          });
                        }
                      });
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text(
                    'Camera',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () async {
                    await ProfileController()
                        .pickImage(ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          image = value;
                          uploadedUrl = '';
                        });
                      }
                    });
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget customCategoryRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 20, 10, 20),
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
          DropdownButton(
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
