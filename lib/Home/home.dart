import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:notes/Crud/editNote.dart';
import 'package:notes/Component/drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:elegant_notification/elegant_notification.dart';

class Home extends StatefulWidget {
  final String id;
  final String username;
  final String email;
  final String password;

  const Home(
      {required this.id,
      required this.email,
      required this.username,
      required this.password,
      super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late CollectionReference notes = FirebaseFirestore.instance.collection("notes").doc(widget.id).collection("userNotes");

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
  
  onScreen() {
    FirebaseMessaging.onMessage.listen((event) { 
      ElegantNotification(
        title:  Text("${event.notification!.title}", style: TextStyle(color: Color(0xFF6034A6), fontWeight: FontWeight.bold, fontSize: 22)),
        description:  Text("${event.notification!.body}", style: TextStyle(color: Colors.white, fontSize: 12),),
        icon: Image(
          image: AssetImage("Assets/notesNotification.png"),
          fit: BoxFit.contain,
        ),
        progressIndicatorColor: Color(0xFF6034A6),
        animation: AnimationType.fromTop,
        showProgressIndicator: false,
        background:  Colors.grey.shade800,
        radius: 20,
        width: double.infinity,
      ).show(context);
      log(event.notification!.body.toString());
    });
  }

  @override
  void initState() {
    fcm();
    onScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F1E),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu, size: 30),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }
        ),
        elevation: 0,
        backgroundColor: Color(0xFF6034A6),
        foregroundColor: Colors.white,
        title: Text(widget.username, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed("AddNote"), 
            icon: Icon(Icons.add, size: 30)
          )
        ],
      ),
      drawer:Mydrawer(widget.username, widget.email, widget.password, widget.id),
      body: StreamBuilder(
        stream: notes.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(15),
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) {
                    notes.doc(snapshot.data!.docs[index]["noteId"]).delete().then((value) {
                      print("Deleted Successful");
                    }).catchError((e) {
                      print("Error = $e");
                    });
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child:
                        Icon(Icons.delete, color: Colors.white, size: 35),
                  ),
                  key: Key(snapshot.data!.docs[index]["noteId"]),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Color(0xFF4833A6), Color(0xFF6034A6)],
                          radius: 2.5,
                          focalRadius: 25
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNote(
                                  noteId: snapshot.data!.docs[index]
                                      ["noteId"],
                                  title: snapshot.data!.docs[index]
                                      ["title"],
                                  content: snapshot.data!.docs[index]
                                      ["content"],
                                )));
                      },
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                      leading: Icon(Icons.note,
                          color: Color(0xFF0F0F1E), size: 50),
                      title: Text("${snapshot.data!.docs[index]["title"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      subtitle: SizedBox(
                        width: 200,
                        child: Text(
                          "${snapshot.data!.docs[index]["content"]}",
                          style: TextStyle(
                              color: Color(0xFFAEAEB3), fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Color(0xFF6034A6), strokeWidth: 6));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Error.. Try Again Later",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)));
          }
          return Center(
              child: Text("Write It Down Before You Forget It",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)));
        },
      ),
    );
  }
}
