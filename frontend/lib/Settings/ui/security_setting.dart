import 'dart:convert';
import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Auth/Functions/auth_functions.dart';
import 'package:marginta/Global/text_fields.dart';


import '../../Controller/shared_preferences.dart';
import '../../Global/color.dart';
import '../../Global/nav.dart';
import '../../Global/utils.dart';

class SecurityScreen extends StatefulWidget {
  dynamic data;
  SecurityScreen({Key? key, this.data}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<SecurityScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController cpw = TextEditingController();

  bool isloading = false;
  bool isobsecure = true;
var userdetails;
  getuserdetails()async{

    userdetails =                    await   json.decode(await PrefManager().get('userdetaills', {}));
print('user details are $userdetails');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdetails();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
            title: const Text( '',style: TextStyle(color: Colors.black),)),
     
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [GestureDetector(
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
                      padding: const EdgeInsets.only(top: 10, left: 1),
                      child: Column(
                        children: [
      
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                              // color: Colors.purple,
                            //  height: isKeyboardVisible ? 300 : 450,
                              child: ListView(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: pc,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Please Enter New Password',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                bottom: 8.0),
                                            child: Text(
                                              'New Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          customtextform(
                                              h: 80,
                                              prefixIcon: Icons.lock,
                                              //   suffixIcon: Icons.fork_right,
                                              //  labeltext: '  Email  ',
                                              hinttext: 'Enter New Password',
                                              suffixIcon: !isobsecure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              context: context,
                                              isobsecure: isobsecure,
                                              ontap: () {
                                                isobsecure = !isobsecure;
                                                setState(() {});
                                              },
                                              controller: pw),

                                               const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0,
                                                left: 8.0,
                                                bottom: 8.0),
                                            child: Text(
                                              'Confirm Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          customtextform(
                                              h: 80,
                                              prefixIcon: Icons.lock,
                                              //   suffixIcon: Icons.fork_right,
                                              //  labeltext: '  Email  ',
                                              hinttext: 'Enter Confirm Password',
                                              suffixIcon: !isobsecure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              context: context,
                                              isobsecure: isobsecure,
                                              ontap: () {
                                                isobsecure = !isobsecure;
                                                setState(() {});
                                              },
                                              controller: cpw),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: BouncingWidget(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        scaleFactor: 1.5,
                                        onPressed: () async {
                                          if (pw.text.isEmpty) {
                                          } else {
                                                        var id =         await  PrefManager().get('user', '');

                                            isloading = true;
                                            setState(() {});

                                            if(pw.text ==cpw.text){

// ignore: use_build_context_synchronously
await AuthFunctions().forgotpassword(
                                              context,
                                              userdetails['email'],
                                              pw.text.trim(),
                                  
                                             changepw: true,
                                             
                                            // userdetails['_id'],
                                            );
                                            }else{

                                              Fluttertoast.showToast(msg: 'Password and confirm password doesnot match');
                                            }

                                            isloading = false;
                                            setState(() {});
                                          }
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
                                                ?     spinkit
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
                                     SizedBox(height: 50,)
                
                                  ])),
                                   
 ],
                      )),
                ],
              ));
        }),
      );
  }
 
}
