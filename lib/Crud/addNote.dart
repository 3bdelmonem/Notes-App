import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNote extends StatefulWidget{
  const AddNote({super.key});
  @override
  State<AddNote> createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6034A6),
        foregroundColor: Colors.white,
        title: Text("Notes"),
        actions: [
          Container(alignment: Alignment.center,
          padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: (){},
              child: Text("Done", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F0F1E)))
            ),
          )
        ],
      ),
      body: 
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          color: Color(0xFF0F0F1E),
          child:SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 20,
                        maxLines: 1,
                        cursorColor: Color(0xFF6034A6),
                        style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          focusColor: Color(0xFF6034A6),
                          hintText: "title",
                          hintStyle: TextStyle(color: Colors.white30 ,fontSize: 26) ,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none
                          )
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 25,
                        cursorColor: Color(0xFF6034A6),
                        style: TextStyle(color: Colors.white ,fontSize: 18),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          focusColor: Color(0xFF6034A6),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}