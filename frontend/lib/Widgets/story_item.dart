import 'package:flutter/material.dart';

import '../Global/color.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  const StoryItem({
    required this.img,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: pc),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: black,
                    //   width: 2
                    // ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(img),
                        // image:
                        //
                        // AssetImage(
                        //   "assets/icons/$img.png",
                        // ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: SizedBox(
              width: 70,
              child: Text(
                name,
                textAlign: TextAlign.center,
                //  overflow: TextOverflow.ellipsis,
                style: TextStyle(color: white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
