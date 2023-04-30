import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
  final String id;
  final String noteId;
  final String noteTitle;
  final String noteContent;

  AddNoteAppbar({
    required this.id,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Color(0xFF6034A6),
          foregroundColor: Colors.white,
          // title: Text("Notes"),
          leading: IconButton(
            onPressed: () async{
              CollectionReference userId = await FirebaseFirestore.instance.collection("users");
              userId.doc(id).collection("userNotes").doc(noteId).set({
                "title" : noteTitle,
                "content" : noteContent,
              });
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          actions: [
            Container(alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){},
                child: Text("Save", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white))
              ),
            )
          ],
        );
  }
}