import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddNoteSave{
  final String id;
  final String noteId;
  final String noteTitle;
  final String noteContent;

  AddNoteSave({
    required this.id,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
  });

  saveData() async{
    CollectionReference userId = await FirebaseFirestore.instance.collection("users");
    userId.doc(id).collection("userNotes").doc(noteId).set({
      "title" : noteTitle,
      "content" : noteContent,
    });
  }
}