import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Crud/editNote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/Component/addNoteAppbar.dart';
import 'package:notes/Home/home.dart';

class showNote extends StatefulWidget{
  final String id;
  final String noteId;
  final String title;
  final String content;

  const showNote({
    required this.id,
    required this.noteId,
    required this.title,
    required this.content,
    super.key
  });
  @override
  State<showNote> createState() => _showNoteState();
}
class _showNoteState extends State<showNote>{
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6034A6),
          foregroundColor: Colors.white,
          leadingWidth: 150,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Notes", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white)),
              )
            ],
          ),
          actions: [
            Container(alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditNote(
                    noteId: widget.noteId,
                    title: widget.title,
                    content: widget.content,    
                  )));
                },
                child: Text("Edit", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white))
              ),
            )
          ],
        ),
        body: 
          Container(
            // alignment: Alignment.center,
            height: double.infinity,
            padding: EdgeInsets.all(10),
            color: Color(0xFF0F0F1E),
            child:SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formState,
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      initialValue: "${widget.title}",
                      // controller: titleController,
                      keyboardType: TextInputType.text,
                      maxLength: 65,
                      maxLines: null,
                      cursorColor: Color(0xFF6034A6),
                      style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        focusColor: Color(0xFF6034A6),
                        hintText: "title",
                        counterText: "",
                        hintStyle: TextStyle(color: Colors.white30 ,fontSize: 26) ,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: "${widget.content}",
                      // controller: contentController,
                      keyboardType: TextInputType.text,
                      minLines: 18,
                      maxLines: null,
                      cursorColor: Color(0xFF6034A6),
                      style: TextStyle(color: Colors.white ,fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        focusColor: Color(0xFF6034A6),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}