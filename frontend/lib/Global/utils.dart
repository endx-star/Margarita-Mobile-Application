import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

logs(data) {
  if (kDebugMode) {
    print(data);
  }
}

awaitfun() async {
  await Future.delayed(const Duration(milliseconds: 150));
}

   var spinkit = const SpinKitCircle(
      color: Color.fromARGB(255, 35, 255, 42),
      size: 50.0,
    );