import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ShowNotificatons{
  fcm() async{
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
    fcm.getToken().then((value) {
      log(value.toString());
    },);
    log('User granted permission: ${settings.authorizationStatus}');
  }
  onScreen(context, String username) {
    FirebaseMessaging.onMessage.listen((event) { 
      ElegantNotification(
        title:  Text("NOTES", style: TextStyle(color: Color(0xFF6034A6), fontWeight: FontWeight.bold, fontSize: 22)),
        description:  Text("I Love You ${username} 😘❤️", style: TextStyle(color: Colors.white, fontSize: 16),),
        icon: Image(
          image: AssetImage("Assets/notesNotification.png"),
          fit: BoxFit.contain,
        ),
        progressIndicatorColor: Color(0xFF6034A6),
        animation: AnimationType.fromTop,
        animationDuration: Duration(seconds: 3),
        showProgressIndicator: false,
        background:  Colors.grey.shade800,
        radius: 20,
        width: double.infinity,
        height: 100,
      ).show(context);
      log(event.notification!.body.toString());
    });
  }
}