import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notes/Component/addNoteAppbar.dart';

class AddNote extends StatefulWidget{
  const AddNote({super.key});
  @override
  State<AddNote> createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote>{
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();
  late String id;
  late String noteId;

  getUserID() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id")??"";
  }

  createNoteId(){
    String firstRandom = Random().nextInt(99999).toString();
    String secondRandom = Random().nextInt(99999).toString();
    noteId = "${firstRandom}ABDELMONEM${secondRandom}";
  }  

  @override
  void initState() {
    getUserID();
    createNoteId();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AddNoteAppbar(),
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
                      controller: titleController,
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
                      controller: bodyController,
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