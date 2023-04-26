import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Home/drawer.dart';
import 'package:notes/Home/data.dart';

class Home extends StatefulWidget {
  final String id;
  final String username;
  final String email;

  const Home({
    required this.id,
    required this.email,
    required this.username,
    super.key
  });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List notes = Data().Notes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6034A6),
        foregroundColor: Colors.white,
        title: Text(widget.username),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search)
          )
        ],
      ),
      drawer: Mydrawer(widget.username, widget.email),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushNamed("AddNote");
        }),
        backgroundColor: Color(0xFF6034A6),
        child: Icon(Icons.add, color: Colors.white,size: 35,),        
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        color: Color(0xFF0F0F1E),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Icon(Icons.delete, color: Colors.white, size: 35),
              ),
              key: Key("$index"),
              child: ListNotes(notes: notes[index]),
            );
          },
        ),
      ),
    );
  }
}

class ListNotes extends StatelessWidget{
  final notes;
  ListNotes({this.notes});
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF6034A6),
            Color(0xFF4833A6)
          ],
          radius: 2.5,
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: Icon(Icons.note, color: Color(0xFF0F0F1E), size: 50),
        title: Text("${notes["noteTitle"]}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
        subtitle: Text("${notes["noteContent"]}", style: TextStyle(color: Color(0xFFAEAEB3), fontSize: 11)),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit, color: Color(0xFF0F0F1E), size: 40),
        ),
        isThreeLine: true,
      ),
    );
  }
}