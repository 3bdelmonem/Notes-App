import 'dart:convert';
import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class NotesNotification {
  String serverToken = "AAAAB5ublX4:APA91bHL8takr-pPyhoXzCC0dr1U6v8Tbx4J7ab3z3inqic6ThXTxBoYfOx-sy5CeppFEc8InnxoaBK40q276tlCex5-vdfsZmLk_AH-L6KuR-nxG96NgTU3zMIyOZf4a4Q-8PqIvGT5";
  fcm() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    fcm.getToken().then(
      (value) {
        log(value.toString());
      });
    log('User granted permission: ${settings.authorizationStatus}');
  }

  onScreen(context) async {
    FirebaseMessaging.onMessage.listen((event) {
      ElegantNotification(
        title: Text("${event.notification!.title}", style: TextStyle(color: Color(0xFF6034A6), fontWeight: FontWeight.bold, fontSize: 22.sp)),
        description: Text("${event.notification!.body}", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        icon: Image(image: AssetImage("Assets/notesNotification.png"), fit: BoxFit.contain),
        progressIndicatorColor: Color(0xFF6034A6),
        animation: AnimationType.fromTop,
        animationDuration: Duration(seconds: 3),
        showProgressIndicator: false,
        background: Colors.grey.shade800,
        radius: 20.r,
        width: double.infinity,
        height: 100.h,
      ).show(context);
      log(event.notification!.body.toString());
    });
  }

  clickOnBackgroundAppNotification(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.of(context).pushNamed("AddNote");
    });
  }

  initialMessage(context) async {
    var message = await FirebaseMessaging.instance.getAPNSToken();
    if (message != null) {
      Navigator.of(context).pushNamed("AddNote");
    }
  }

  sendNotification(String body, String title, String id) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString()
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }
}
