import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:marginta/Global/nav.dart';
import 'package:marginta/Settings/ui/general_setting.dart';


import '../../Account/functions/account_functions.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/utils.dart';
import 'help_and_feedback.dart';
import 'location_setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  var data ; 

bool isloading2 = false;
getUserdetails()async{
  isloading2 = true;
  setState(() {
    
  });

                var userid =     await  PrefManager().get('user','');

 data = await AccountFunctions().getuser(userid);

 await PrefManager().set('userdetaills',json.encode(data));
 logs("my data is $data");

 isloading2 = false;
 setState(() {
   
 });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdetails();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(elevation: 0.0,

      backgroundColor: Colors.transparent,
      centerTitle:true,
      title: const Text('Profile Settings',style: TextStyle(fontSize: 22,color: Colors.black),),
 leading: IconButton(
              
              
              onPressed: (){
           pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                 ),

      body:isloading2?Center(child: spinkit,): Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Material(   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                        elevation: 2.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                          //  color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 0.5, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                               
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: 'First name',
                                    text2: data['firstname']==''?'........':data['firstname'],
                                    ontap: () {


                              nav(context,  GeneralSetting(data:data));
                                    }),
                               const Padding(
                                 padding: EdgeInsets.symmetric(horizontal:8.0),
                                 child: Divider(),
                               ),
                                
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: 'Last name',
                          text2: data['lastname']==''?'........':data['lastname'],

                                    ontap: () {

                              nav(context,  GeneralSetting(data:data));
                                    }),
                                         const Padding(
                                 padding: EdgeInsets.symmetric(horizontal:8.0),
                                 child: Divider(height: 1,),
                               ),
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: 'Email',
                                     text2: data['email']==''?'........':data['email'],

                                    ontap: () {
print('im clicked');
                              nav(context,  GeneralSetting(data:data));
                                    }),
                                              const Padding(
                                 padding: EdgeInsets.symmetric(horizontal:8.0),
                                 child: Divider(height: 1,),
                               ),
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: 'Phone no',
                                    text2:data['phone']==''?'........':data['phone'],

                                    ontap: () {

                                nav(context,  GeneralSetting(data:data));

                                    }),

                                    //SizedBox(height: 20,),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
const SizedBox(height: 10,),


  Center(
    child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:48.0),
                            child: BouncingWidget(
                              duration: const Duration(milliseconds: 100),
                              scaleFactor: 1.5,
                              onPressed: () async {
                              //  isloading = true;
                              nav(context,  GeneralSetting(data:data));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffFF2F68),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 45,
                                width: 200,
                                child:const Center(
                                  child:  Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20),
                                        ),
                                ),
                              ),
                            ),
                          ),
  ),

                   //                                   ),

        ]),
    );
  }



  Widget tile(txt){

    return                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Material(
                        elevation: 1.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.5, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                               
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt',
                                    ontap: () {}),
                               
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
  }
  Widget tile2(txt1,txt2){

    return                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Material(
                        elevation: 1.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.5, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                               
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt1',
                                    ontap: () {}),
                                      listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt2',
                                    ontap: () {}),
                               
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
  }
  Widget tile3(txt1,txt2,txt3,txt4){

    return                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Material(
                        
                        elevation: 1.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.5, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                               
                                listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt1',
                                    ontap: () {}),
                                      listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt2',
                                    ontap: () {}),

                                      listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt3',
                                    ontap: () {}),
                               

                                      listtile2(
                                    icon1: Icons.lock_open_rounded,
                                    text: '$txt4',
                                    ontap: () {}),
                              
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
  }


  Widget listtile2({dynamic text,dynamic text2, IconData? icon1, IconData? icon2, ontap}) {
    return 
    
    // BouncingWidget(
    //   duration: Duration(milliseconds: 100),
    //   scaleFactor: 1.5,
    //   onPressed: ontap,
    //   child:
      
       ListTile(
        onTap: ontap,
        // leading: Icon(
        //   icon1,
        //   size: 25,
        //   color: Colors.black,
        // ),
        title: Text(
          text,
          style:const TextStyle(
            fontSize: 18,
            color: Colors.black
          ),
        ),
        trailing:Text(
          text2,
          style:const TextStyle(
            fontSize: 18,
            color: Colors.black
          ),
        ),
     // ),
    );
  }
}



