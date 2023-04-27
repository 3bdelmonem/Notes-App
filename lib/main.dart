import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/Authentication/login.dart';
import 'package:notes/Authentication/signUp.dart';
import 'package:notes/Crud/addNote.dart';
import 'package:notes/Home/home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/Test/AnonymousAuth.dart';
import 'package:notes/Test/GoogleAuth.dart';
import 'package:notes/Test/PasswordAuth.dart';
import 'package:notes/Authentication/splashScreen.dart';
import 'package:notes/Home/drawer.dart';
import 'package:notes/Test/fireStoreUi.dart';
import 'package:notes/Test/futureFirestoreUi.dart';
import 'package:notes/Test/streamFirestore.dart';
import 'package:notes/Test/firebaseStrorage.dart';
import 'package:notes/Test/test.dart';
import 'package:shared_preferences/shared_preferences.dart';


late bool isActive;
late String id;
late String username;
late String email;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  var activeUser = FirebaseAuth.instance.currentUser;
  if(activeUser == null){
    isActive = false;
  }
  else{
    id = prefs.getString("id")??"";
    username = prefs.getString("username")??"";
    email = prefs.getString("email")??"";
    isActive = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Test(),
      home: isActive == true ? Home(id: id, username: username, email: email,) : splashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "Login":(context) =>  Login(),
        "SignUp":(context) => SignUp(),
        // "Home":(context) => Home(),
        "AddNote":(context) => AddNote(),
        "SplashScreen":(context) => splashScreen()
      },











      
      theme: ThemeData(
        primaryColor: Color(0xFF6034A6),
        textTheme: TextTheme(
          labelLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        )
      ),
    );
  }
}