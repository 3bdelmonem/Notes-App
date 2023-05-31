import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late String id;
  late String username;
  late String email;

  getUserId() {
    User? activeUser = FirebaseAuth.instance.currentUser;
    id = activeUser!.uid.toString();
    getUserInfo();
  }

  getUserInfo() async{
    CollectionReference user = await FirebaseFirestore.instance.collection("users");
    await user.doc(id).get().then((value) {
      if(value.exists){
        username = value["username"];
        email = value["email"];
      }
    });
  }
  @override
  void initState() {
    getUserId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print(email);
                print(username);
              },
              child: Text(username),
            )
          ],
        ),
      ),
    );
  }
}





