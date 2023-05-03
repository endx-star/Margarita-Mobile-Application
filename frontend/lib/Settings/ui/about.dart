import 'package:flutter/material.dart';
import 'package:marginta/Global/nav.dart';


class AboutUs extends StatefulWidget {
  dynamic data;
  AboutUs({Key? key, this.data}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
      body: SizedBox(
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
                   
                            // backgroundImage: AssetImage(
                            //   'assets/logo.jpg',
                            // ),
                          ),
                  // Row(
                  //   children: [
                  //     Center(
                  //         child: text2('Accept Terms & Conditions', 20,
                  //             ColorSelect().white)),
                  //   ],
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Center(child:  Text(
                                        'About Us',
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
