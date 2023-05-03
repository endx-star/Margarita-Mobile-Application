import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marginta/Account/functions/account_functions.dart';

import '../../Controller/image_controller.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/nav.dart';
import '../../Global/utils.dart';

class LocationSetting extends StatefulWidget {
  dynamic data;
  LocationSetting({Key? key, this.data}) : super(key: key);

  @override
  State<LocationSetting> createState() => _LocationSettingState();
}

class _LocationSettingState extends State<LocationSetting> {
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isloading = false;

  bool isobsecure = false;
  String imageUrl = '';

  var data;

  getUserdetails() async {
    isloading = true;
    setState(() {});

    var userid = await PrefManager().get('user', '');

    data = await AccountFunctions().getuser(userid);

    await PrefManager().set('userdetaills', json.encode(data));
    logs("my data is $data");
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    )),
                title: const Text(
                  'Location Settings',
                  style: TextStyle(color: Colors.black),
                )),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 1),
                    child: Column(
                      children: [
                        SizedBox(
                            child: ListView(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Material(
                                  elevation: 1.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 0.5, color: Colors.white),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          listtile2(
                                              icon1: Icons.lock_open_rounded,
                                              text:
                                                  'Allow to track the location',
                                              ontap: () {}),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                      ],
                    )),
              ],
            ));
      }),
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
                        setState(() {
                          image = value;
                        });
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
                      setState(() {
                        image = value;
                      });
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

  bool status = false;

  Widget listtile2({dynamic text, IconData? icon1, IconData? icon2, ontap}) {
    return ListTile(
      title: Text(
        text,
        style:
            TextStyle(fontSize: 22, color: Color.fromARGB(255, 122, 119, 119)),
      ),
      trailing: Container(
        width: 80.0,
        height: 40.0,
        child: FlutterSwitch(
          width: 100.0,
          height: 50.0,
          valueFontSize: 25.0,
          toggleSize: 40.0,
          value: status,
          borderRadius: 30.0,
          padding: 8.0,
          //showOnOff: true,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),
      ),
    );
  }

  imagewidget(image) {
    return CircleAvatar(
      radius: 80,
      backgroundColor: Colors.white,
      backgroundImage: image,
      child: InkWell(
        onTap: () {
          _showPicker(context);
        },
        child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 77, 241, 82)),
                child: Center(
                    child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                )))),
      ),
    );
  }
}
