import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marginta/Account/functions/account_functions.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/text_fields.dart';
import 'package:marginta/Settings/ui/profile_page.dart';
import 'package:marginta/Settings/ui/settings.dart';

import '../../Controller/image_controller.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/color.dart';
import '../../Global/nav.dart';
import '../../Global/utils.dart';

class GeneralSetting extends StatefulWidget {
  dynamic data;
   GeneralSetting({Key? key,this.data}) : super(key: key);

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
    TextEditingController lname = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isloading = false;
  bool isloading2 = false;

  bool isobsecure = false;
  String imageUrl = '';

  var data ; 


getUserdetails()async{
  isloading2 = true;
  setState(() {
    
  });

 var userid =     await  PrefManager().get('user','');

 data = await AccountFunctions().getuser(userid);

 await PrefManager().set('userdetaills',json.encode(data));
 logs("my data is $data");
 name.text = data['firstname'];
  lname.text = data['lastname'];

 phone.text = data['phone'];

 email.text = data['email'];


 isloading2 = false;
 setState(() {
   
 });
}

@override
  void initState() {
    super.initState();
    getUserdetails();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              
              
              onPressed: (){

    navandThenNav(context, const ProfilePage(), const Settings());

             //   pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
            title: const Text('General Settings',style: TextStyle(color: Colors.black),)),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: isloading2? Center(child: spinkit,):ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [


                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 1),
                    child: Column(
                      children: [
           
                      
                        SizedBox(
                            // color: Colors.purple,
                       height: isKeyboardVisible ? 500 : 700,
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
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'First Name',
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
                                            hinttext: 'Enter your First Name',
                                            //  suffixIcon: Icons.person_outline,
                                            context: context,
                                            controller: name),

                                            
             const Padding(
                                          padding: EdgeInsets.only(
                                            top: 8,
                                              left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'Last Name',
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
                                            hinttext: 'Enter your Last Name',
                                            //  suffixIcon: Icons.person_outline,
                                            context: context,
                                            controller: lname),


                                                const Padding(
                                          padding: EdgeInsets.only(
                                            top: 8,
                                              left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        customtextform(
                                            h: 80,
                                            prefixIcon: Icons.mail,
                                            //   suffixIcon: Icons.fork_right,
                                            //  labeltext: '  Email  ',
                                            hinttext: 'Enter your email ',
                                            //  suffixIcon: Icons.person_outline,
                                            context: context,
                                            controller: email),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: 8,
                                              left: 8.0, bottom: 8.0),
                                          child: Text(
                                            'Phone',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        customtextform(
                                            h: 80,
                                            prefixIcon: Icons.call,
                                            //   suffixIcon: Icons.fork_right,
                                            //  labeltext: '  Email  ',
                                            hinttext: 'Enter your phone no ',
                                            //  suffixIcon: Icons.person_outline,
                                            context: context,
                                            controller: phone),

                                            
                                            
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


               if(data['email']==email.text)   {



                 var userid =     await  PrefManager().get('user','');

                                // ignore: use_build_context_synchronously
                            // /    await AuthFunctions().updatepassword(context, email.text.trim(), 'sssssssss', userid);

                                 // ignore: use_build_context_synchronously
                                 await AccountFunctions().updatesettings(context, name.text.trim(), lname.text.trim(), email.text.trim(),phone.text.trim(),userid).then((value) => {
                                  

                                //  getUserdetails()
                                 });
                       
               }       else{

 // ignore: use_build_context_synchronously
 await AuthFunctions().sendEmail(
                                            'template_3cpr88s',
                                            email.text.trim(),
                                            data['email'],
                                            context,
                                            resend: false,
                                            isforgot: false,
                                            firstname:name.text.trim(),
                                            lastname:lname.text.trim(),
                                            phone:phone.text.trim()
                                            
                                            
                                            
                                            );
               }               // ignore: use_build_context_synchronously
                      
                                  
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
                                  const SizedBox(
                                    height: 200,
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


//                           child: 
                          
//                           Column(mainAxisAlignment: MainAxisAlignment.center,
//                             children: [  SizedBox(height: 30,),
//                            imageUrl.isNotEmpty
//                                       ? Image.network(
//                                           imageUrl,
//                                           scale: 6,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : image == null
//                                           ?  Image.asset(
//                                 'assets/logo.jpg',
//                                 width: 120,
//                                 fit: BoxFit.fill,
//                               )
//                                           : Image.file(
//                                               image,
//                                               scale: 2,
//                                               fit: BoxFit.fill,
//                                             ),   
//                               SizedBox(height: 30,),
// InkWell(

//   onTap: (){
// _showPicker(context);
//   },
//   child:   Align(alignment: Alignment.bottomRight,child: Container(height: 30,width: 30,
//                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Color.fromARGB(255, 77, 241, 82)),
                                      
//                                       child: Center(child: Icon(Icons.add,color: Colors.white,size: 20,)),
                                      
//                                       ),),
// ),                            ],
//                           ),
                          // backgroundImage: AssetImage(
                          //   'assets/logo.jpg',
                          // ),
                        );
  }
}
