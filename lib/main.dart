import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notes/Authentication/login.dart';
import 'package:notes/Authentication/signUp.dart';
import 'package:notes/Component/help.dart';
import 'package:notes/Crud/addNote.dart';
import 'package:notes/Home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/Authentication/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late bool isActive;
late String id;
late String username;
late String email;
late String password;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.notification!.body}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  var activeUser = FirebaseAuth.instance.currentUser;
  if (activeUser == null) {
    isActive = false;
  } else {
    prefs.reload();
    id = prefs.getString("id") ?? "";
    username = prefs.getString("username") ?? "";
    email = prefs.getString("email") ?? "";
    password = prefs.getString("password") ?? "";
    isActive = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:(context, child) => MaterialApp(
        home: isActive == true
            ? Home(
                id: id,
                username: username,
                email: email,
                password: password,
              )
            : splashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          "Login": (context) => Login(),
          "SignUp": (context) => SignUp(),
          "AddNote": (context) => AddNote(),
          "SplashScreen": (context) => splashScreen(),
          "Help": (context) => HelpScreen(),
        },
        theme: ThemeData(
            primaryColor: Color(0xFF6034A6),
            textTheme: TextTheme(
              labelLarge: TextStyle(
                  color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
            )),
      ),
      designSize: Size(411.42857142857144, 867.4285714285714),
    );
  }
}
