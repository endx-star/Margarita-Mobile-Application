import 'package:flutter/material.dart';

import '../../Global/nav.dart';


class HelpAndFeedback extends StatefulWidget {
  dynamic data;
  HelpAndFeedback({Key? key, this.data}) : super(key: key);

  @override
  State<HelpAndFeedback> createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  bool istrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        
        leading: InkWell(
          
          onTap: (){
            pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.white),
      body: Container(
        height: MediaQuery.of(context).size.height,
     
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10,top: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 145,
                  ),

                 Image.asset(
                              'assets/logo.jpg',
                              width: 200,
                   
                        
                          ),
       
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Center(child:  Text(
                                        'Help & Feedback',
                                      //  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since '
                                            textAlign: TextAlign.justify,
                                      style:TextStyle(fontSize: 19.5,color: Colors.black,)),
                                 
              ),

                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                                        'Please read carefully',
                                      //  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since '
                                            textAlign: TextAlign.justify,
                                      style:TextStyle(fontSize: 19.5,color: Colors.black,)),
                                 
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                              padding: EdgeInsets.only(
                                  left:0, top: 15, bottom: 20),
                              child: Center(
                                  child: Container(
                                    //height: 200,
                                    width: 350,
                                    child: Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since '
                                      //  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since '
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since ',
                                            textAlign: TextAlign.justify,
                                      style:TextStyle(fontSize: 12.5,color: Colors.black,)),
                                  )),
                            ),
                  SizedBox(
                    height: 10,
                  ),
                           const SizedBox(
                    height: 15,
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
