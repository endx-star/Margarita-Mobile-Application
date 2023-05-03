import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:marginta/Location/Utils/snazzy_map.dart';

import '../../Controller/api_methods.dart';
import '../../Controller/shared_preferences.dart';
import '../../Global/nav.dart';


import 'package:flutter/services.dart';
// ignore: library_prefixes
import 'package:image/image.dart' as Images;

import '../../Global/utils.dart';
import '../../Model/user_post_model.dart';
import '../../Posts/functions/post_functions.dart';
import '../../Widgets/post_item.dart';
import 'location_post.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var latlng = [];
    var imgUrl = [];

    List<dynamic> fromAPi = [];
 int len = 0;
  getLatLngPost() async {
    setState(() {
      isloading = true;
    });
 
    List<dynamic> postsList =
        await Controller().getApi(endpoint: "articles", id: '') ?? [];

    logs("postsList is$postsList");
   
  for (var element in postsList) {
      newPost.add(UserPost.fromJson(element));
      bookmarList.add(false);

    }
    setState(() {
      fromAPi = postsList;
     
      if (kDebugMode) {
        print("Length is location$len");
      }
             isloading = false;

    });
      latlng = [];
    for( int i = 0;i<fromAPi.length;i++){


if(fromAPi[i]['lat']==null||fromAPi[i]['lng']==null){

  
}else if(fromAPi[i]['lat']=='null'||fromAPi[i]['lng']=='null'){

  
}else if(fromAPi[i]['lat']==''||fromAPi[i]['lng']==''){}else{
  latlng.add( {
      "lat":fromAPi[i]['lat'].toString(),
      "lng":fromAPi[i]['lng'].toString()
    },);

    imgUrl.add(fromAPi[i]['imgurl']);
}
print("my lat lng are $latlng");
      
    }

    
    await getIcons();
   
  }

  @override
  void initState() {
    super.initState();
    try{  getLatLngPost();}catch(e){print(e);}
  }
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GlobalKey key = GlobalKey();

  List<bool> bookmarList = [];

  List<UserPost> userPost = [];
    List<UserPost> newPost = [];
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  bool isloading = false;
  // ignore: prefer_typing_uninitialized_variables
  var userdata;
  int i = 0;

    Future<List<int>> makeReceiptImage(img) async {
    // load avatar image

  dynamic imageData ;
if(img==null||img==''||img=='asdf'){

   imageData = (await NetworkAssetBundle(Uri.parse('https://www.nj.com/resizer/zovGSasCaR41h_yUGYHXbVTQW2A=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg'))
            .load('https://www.nj.com/resizer/zovGSasCaR41h_yUGYHXbVTQW2A=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg'))
            .buffer
            .asUint8List();
}else{


   imageData = (await NetworkAssetBundle(Uri.parse(img[0]))
            .load(img[0]))
            .buffer
            .asUint8List();
}
  
            
    // ByteData imageData = bytes;
    List<int> bytes = Uint8List.view(imageData.buffer);
    var avatarImage = Images.decodeImage(Uint8List.fromList(bytes));

    //load marker image 
    imageData = await rootBundle.load('assets/transparentIcon.png');
    bytes = Uint8List.view(imageData.buffer);
    var markerImage = Images.decodeImage(Uint8List.fromList(bytes));

    //resize the avatar image to fit inside the marker image
    avatarImage = Images.copyResize(avatarImage!,
        width: markerImage!.width ~/ 1.1, height: markerImage.height ~/ 1.4);


    var radius = 90;
    int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;

    //draw the avatar image cropped as a circle inside the marker image
    for (int y = -radius; y <= radius; y++)
      // ignore: curly_braces_in_flow_control_structures
      for (int x = -radius; x <= radius; x++) {
        if (x * x + y * y <= radius * radius)
          // ignore: curly_braces_in_flow_control_structures
          markerImage.setPixel(originX + x+8, originY + y+10,
              avatarImage.getPixelSafe(originX + x, originY + y));
      }


    return Images.encodePng(markerImage);
  }
  getIcons() async {
    setState(() {
      isloading = true;
    });
      for (int index = 0; index < latlng.length; index++) {

            var myImage ;
  await  makeReceiptImage(json.decode(imgUrl[index])).then((List<int> image) {
      setState(() {
        myImage = image;
      });
    });
      var icon =  BitmapDescriptor.fromBytes(Uint8List.fromList(myImage));
              var marker = Marker(
         icon: icon,
            markerId: MarkerId('$index'),
            position: LatLng(
            latlng[index]['lat']=='null'?33.60274171218822:  double.parse(latlng[index]['lat']!),
            latlng[index]['lng']=='null'? 73.04845809821701:  double.parse(latlng[index]['lng']!),
            ),
            onTap: (){
              print("im pressed");
            },
            infoWindow: InfoWindow(
            title: "See the Post",
                onTap: () async{
                          var   images = json.decode(newPost[index].imgurl!);
                            print("my images are $images");
             
     print("the index is $i");

 userdata =await json.decode(await  PrefManager().get('userlogin', null));

 userdata =await json.decode(await  PrefManager().get('userlogin', null));
 print("userdata is $userdata");
     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LocationPost(
                              profileImg: newPost[index].user?.image == "" ||
                                      newPost[index].user?.image == null
                                  ? "https://firebasestorage.googleapis.com/v0/b/wikly-3fa72.appspot.com/o/PostStorage%2F2023-02-22%2000%3A57%3A18.121147%2Fdata%2Fuser%2F0%2Fcom.example.marginta%2Fcache%2Fimage_picker8497766138402990208.jpg%7D?alt=media&token=dc3a430e-74a8-490c-8af1-43ad01a93292"
                                  : newPost[index].user!.image!,
                              name: newPost[index].user?.username == "" ||
                                        newPost[index].user?.username == null
                                    ? userdata['email'].toString().split("@")[0]
                                    : newPost[index].user!.username!,
                                postImg: images ?? [],
                              likedBy: newPost[index].likes,
                              isLoved: newPost[index].likes!.length == 0
                                  ? false
                                  : !(newPost[index].isLoved),
                              viewCount: newPost[index].comment!,
                              dayAgo: "1",
                              caption: newPost[index].description ?? "",
                              id: newPost[index].id,
                              cat: newPost[index].cat,
                              lat: newPost[index].lat,
                              lng: newPost[index].lng,
                              userid: newPost[index].user?.userid,
                              postid: newPost[index].id,
                              isbookMark: bookmarList[index],
                              onLocationTap:(){

                                nav(context, LocationScreen());
                              },
                              onTap: () async {
                                if (bookmarList[index]) {
                                  bookmarList[index]=false;
                                   var userid =
                                      await PrefManager().get('user', '');

                                  PostFunctions().deleteBookmark(
                                      userid: userid,
                                      postid: newPost[index].id);
                                  // userPost.removeAt(index);
                                  setState(() {});
                                } else {
                                  bookmarList[index]= true;
                                  setState(() {});
                                  print(newPost[index].user?.userid);
                                  print(newPost[index].id);

                                  var userid =
                                      await PrefManager().get('user', '');

                                  PostFunctions().addbookmark(
                                      userid: userid,
                                      postid: newPost[index].id);
                                }

                                print("my bookmarlist is $bookmarList");
                              },
                            ),));
                                }));

        markers[MarkerId(index.toString())] = marker;
      
      }
        try {
      _kGooglePlex = CameraPosition(
        target: LatLng(
                 double.parse(latlng[0]['lat']!),
            double.parse(latlng[0]['lng']!),
        ),

        zoom: 18.2000,
     
        tilt: 59.440717697143555,
      );

     
    } catch (e) {

      
    }

     


      setState(() {
        isloading = false;
      });
    //}
   // );
  }

  double calculateZoomLevel() {
    double equatorLength = 40075004; // in meters
    double widthInPixels = width(context);
    double metersPerPixel = equatorLength / 256;
    double zoomLevel = 1.0;
    while ((metersPerPixel * widthInPixels) > 2000) {
      metersPerPixel /= 2;
      ++zoomLevel;
    }
    // Log.i("ADNAN", "zoom level = "+zoomLevel);
    return zoomLevel;
  }


GoogleMapController? con;
 

  var markerIcon;
  CameraPosition? _kGooglePlex;
  Set<Circle>? circles;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: SizedBox(
          height: height(context),
          width: width(context),
          child: isloading
              ? Center(
                  child: spinkit,
                )
              : newPost.isEmpty||_kGooglePlex==null?Center(child: Text("No Post Found"),):
                     Stack(
                       children: [
                         GoogleMap(
                          zoomControlsEnabled: false,
                         // mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex!,
                          markers: Set<Marker>.of(markers.values),
                    // circles: circles!,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);

                            controller.setMapStyle(mapStyle);
                            con = controller;
                          },
                                                       // polylines: Set<Polyline>.of(polylines.values),

                   
        ),
        Positioned(
      top: 100,
      left: 5,
      child: Card(
        elevation: 2,
        child: Container(
          color: Color(0xFFFAFAFA),
          width: 40,
          height: 100,
          child: Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    var currentZoomLevel = await con!.getZoomLevel();

                    currentZoomLevel = currentZoomLevel + 2;
                    con!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(double.parse(latlng[0]['lat']!),
            double.parse(latlng[0]['lng']!),),
                          zoom: currentZoomLevel,
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 2),
              IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () async {
                    var currentZoomLevel = await con!.getZoomLevel();
                    currentZoomLevel = currentZoomLevel - 2;
                    if (currentZoomLevel < 0) currentZoomLevel = 0;
                    con!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(double.parse(latlng[0]['lat']!),
            double.parse(latlng[0]['lng']!),),
                          zoom: currentZoomLevel,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    )
                       ],
                     )));
  }


 
}
class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "Agent 1", "id": "1", "lat": 26.3054, "lon": 31.1367},
    {"title": "Agent 2", "id": "2", "lat": 26.5082, "lon": 31.3713},
    // {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
  ];
}
