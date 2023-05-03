import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:marginta/Settings/ui/local_notification.dart';

class notificationPage extends StatefulWidget {
  notificationPage({Key? key}) : super(key: key);

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  String notificationMsg = "Waiting for notifications";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // LocalNotificationService.initilize();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body} Terminated Notification";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      // LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} Foreground Notification";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} Background Notification";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MargaritaApp Notifications"),
      ),
      body: Center(
        child: Text(
          notificationMsg,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
