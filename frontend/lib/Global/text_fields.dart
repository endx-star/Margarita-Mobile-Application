import 'package:flutter/material.dart';
import 'package:marginta/Global/color.dart';

Widget customtextform(
    {dynamic labeltext,
    dynamic hinttext,
    IconData? suffixIcon,
    TextEditingController? controller,
    BuildContext? context,
    maxlines = 1,
    minlines = 1,
    double h = 60.0,
    bool isobsecure = false,
    ontap,
    prefixIcon}) {
  return SizedBox(
    height: h,
    width: MediaQuery.of(context!).size.width - 60,
    child: Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 8, right: 8),
      child: TextField(
        scrollPadding: EdgeInsets.only(
            bottom:MediaQuery.of(context).viewInsets.bottom/3 ),
        obscureText: isobsecure,
        maxLines: maxlines,
        minLines: minlines,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelText: labeltext,
          // labelStyle: TextStyle(
          //     color: Colors.red, fontSize: 13.5, fontWeight: FontWeight.w500),
          hintText: hinttext,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          contentPadding: const EdgeInsets.only(top: 2, left: 5, bottom: 45),
          prefixIcon: Icon(
            prefixIcon,
            size: 22,
            color: pc,
            //color: ColorSelect().blue,
          ),
          suffixIcon: IconButton(
            onPressed: ontap,
            icon: Icon(
              suffixIcon,
              size: 22, color: pc,
              // color: ColorSelect().blue,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: pc, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: pc, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
  );
}
