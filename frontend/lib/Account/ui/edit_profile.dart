import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marginta/Account/functions/account_functions.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/text_fields.dart';

import '../../Controller/image_controller.dart';
import '../../Global/color.dart';
import '../../Global/nav.dart';
import '../../Global/utils.dart';

class EditProfile extends StatefulWidget {
  dynamic data;
   EditProfile({Key? key,this.data}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  bool isloading = false;

  bool isobsecure = false;
  String imageUrl = '';
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    username.text = widget.data['username'];
        name.text = widget.data['name'];

    bio.text = widget.data['bio'];
    imageUrl = widget.data['image'];

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/Untitled.png'), fit: BoxFit.fill)),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
GestureDetector(
  onTap: (){
    pop(context);
  },
  child:   Padding(
    padding: const EdgeInsets.only(top:18.0,left: 20),
    child:   Align(alignment: Alignment.topLeft,
    
    child: Icon(Icons.arrow_back_ios,color: Colors.white,),),
  ),
),

                Padding(
                    padding: const EdgeInsets.only(top: 80, left: 1),
                    child: Column(
                      children: [
                        imageUrl.isNotEmpty?imagewidget(NetworkImage(imageUrl)):image!=null? imagewidget(FileImage(image)):
                        
                        imagewidget(
                             AssetImage( 'assets/m.png')
                              )
                        ,
                      
                        SizedBox(
                            // color: Colors.purple,
                        //    height: isKeyboardVisible ? 300 : 500,
                            child: ListView(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Change profile photo',
                                      style: TextStyle(
                                          color: pc,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                    height: 40,
                                  ),
                                  Container(
                                    
                                  //  color: Colors.red,
                                     height: isKeyboardVisible ? 300 : 400,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      children: [
                                        SizedBox(           
                                          
                                          // d            height: isKeyboardVisible ? 500 : 700,

                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, bottom: 8.0),
                                                  child: Text(
                                                    'Name',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                customtextform(
                                                    h: 80,
                                                    prefixIcon: Icons.person,
                                                    //   suffixIcon: Icons.fork_right,
                                                    //  labeltext: '  Email  ',
                                                    hinttext: 'Name',
                                                    //  suffixIcon: Icons.person_outline,
                                                    context: context,
                                                    controller: name),

                                                    

                                                      const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 8,
                                                      left: 8.0, bottom: 8.0),
                                                  child: Text(
                                                    'Username',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                customtextform(
                                                    h: 80,
                                                    prefixIcon: Icons.person,
                                                    //   suffixIcon: Icons.fork_right,
                                                    //  labeltext: '  Email  ',
                                                    hinttext: 'Enter your username ',
                                                    //  suffixIcon: Icons.person_outline,
                                                    context: context,
                                                    controller: username),

                                                        const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 8,
                                                      left: 8.0, bottom: 8.0),
                                                  child: Text(
                                                    'Bio',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                customtextform(
                                                  maxlines: 5,
                                                  minlines: 5,
                                                // /  maxlines:4,
                                                    h: 120,
                                                 prefixIcon: Icons.chrome_reader_mode,
                                                    //   suffixIcon: Icons.fork_right,
                                                    //  labeltext: '  Email  ',
                                                    hinttext: 'Enter your bio ',
                                                    //  suffixIcon: Icons.person_outline,
                                                    context: context,
                                                    controller: bio),



                                          //       const Padding(
                                          //         padding: EdgeInsets.only(
                                          //             top: 8.0, left: 8.0, bottom: 8.0),
                                          //         child: Text(
                                          //           'Password',
                                          //           style: TextStyle(
                                          //               color: Colors.black,
                                          //               fontSize: 18,
                                          //               fontWeight: FontWeight.normal),
                                          //         ),
                                          //       ),
                                          //       customtextform(
                                          //           h: 80,
                                          //           prefixIcon: Icons.lock,
                                          //           //   suffixIcon: Icons.fork_right,
                                          //           //  labeltext: '  Email  ',
                                          //           hinttext: 'Password',
                                          //           suffixIcon: !isobsecure
                                          //               ? Icons.visibility_off
                                          //               : Icons.visibility,
                                          //           context: context,
                                          //           isobsecure: isobsecure,
                                          //           ontap: () {
                                          //             isobsecure = !isobsecure;
                                          //             setState(() {});
                                          //           },
                                          //           controller: pw),
                                              ],
                                            ),
                                          ),
                                        ),
                                              SizedBox(
                                    height:isKeyboardVisible ?120: 0,
                                  ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: BouncingWidget(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      scaleFactor: 1.5,
                                      onPressed: () async {
                                        await awaitfun();
                                        isloading = true;
                                        setState(() {});

if(name.text.length<4){

  Fluttertoast.showToast(msg: "Username can't be less than 4 characters");
}else{

                                        // ignore: use_build_context_synchronously
                                        await AccountFunctions().checkusername(context,name.text.trim(),widget.data['username'], username.text.trim(), bio.text.trim(),image,imageUrl,widget.data['_id']);


}

                                        // ignore: use_build_context_synchronously
                                  
                                        isloading = false;
                                        setState(() {});
                                       
                                        
                                        
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFF2F68),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 63,
                                        width: 390,
                                        child: Center(
                                          child: isloading
                                              ?  Center(
                                                  child:
                                                         spinkit,
                                                )
                                              : const Text(
                                                  'UPDATE',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
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

                            if(value!=null){
imageUrl = '';

                            }
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
                             if(value!=null){
imageUrl = '';

                            }
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

  imagewidget(image){
    return   CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: image,

                          child: 
                          InkWell(

                            onTap: (){
                              _showPicker(context);
                            },
                            child: Align(alignment: Alignment.bottomRight,child: Container(height: 30,width: 30,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Color.fromARGB(255, 77, 241, 82)),
                                        
                                        child: Center(child: Icon(Icons.add,color: Colors.white,size: 20,)))),
                          ),


                        );
  }
}
