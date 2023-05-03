import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Crud/editNote.dart';
import 'package:notes/Home/drawer.dart';
import 'package:notes/Home/data.dart';
import 'package:notes/main.dart';
import '../Crud/showNote.dart';

class Home extends StatefulWidget {
  final String id;
  final String username;
  final String email;

  const Home(
      {required this.id,
      required this.email,
      required this.username,
      super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  late CollectionReference notes = FirebaseFirestore.instance.collection("notes").doc(widget.id).collection("userNotes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6034A6),
        foregroundColor: Colors.white,
        title: Text(widget.username),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: Mydrawer(widget.username, widget.email),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushNamed("AddNote");
        }),
        backgroundColor: Color(0xFF6034A6),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        color: Color(0xFF0F0F1E),
        child: StreamBuilder(
          stream: notes.snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      notes.doc(snapshot.data!.docs[index]["noteId"]).delete().then((value) {
                        print("Deleted Successful");
                      }).catchError((e){
                        print("Error = $e");
                      });
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.red, borderRadius: BorderRadius.circular(15)),
                      child: Icon(Icons.delete, color: Colors.white, size: 35),
                    ),
                    key: Key(snapshot.data!.docs[index]["noteId"]),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [Color(0xFF6034A6), Color(0xFF4833A6)],
                            radius: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => showNote(
                            id: id,
                            noteId: snapshot.data!.docs[index]["noteId"],
                            title: snapshot.data!.docs[index]["title"],
                            content: snapshot.data!.docs[index]["content"],
                          )));
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        leading: Icon(Icons.note, color: Color(0xFF0F0F1E), size: 50),
                        title: Text(
                          "${snapshot.data!.docs[index]["title"]}",
                          style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold)),
                        subtitle: SizedBox(
                          width: 200,
                          child: Text(
                            "${snapshot.data!.docs[index]["content"]}",
                            style: TextStyle(color: Color(0xFFAEAEB3), fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNote(
                              noteId: snapshot.data!.docs[index]["noteId"],
                              title: snapshot.data!.docs[index]["title"],
                              content: snapshot.data!.docs[index]["content"],
                            )));
                          },
                          icon: Icon(Icons.edit, color: Color(0xFF0F0F1E), size: 40),
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  );
                },
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError) {
            return Center(child: Text("Error.. Try Again Later", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700)));
              
            }
            return Center(child: Text("Write It Down Before You Forget It", style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w700)));
          },
        )
      ),
    );
  }
}