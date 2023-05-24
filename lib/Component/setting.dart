import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/Component/cardInfo.dart';
class Setting extends StatefulWidget {
  late String username;
  late String email;
  late String password;
  Setting({
    required this.username,
    required this.email,
    required this.password,
    super.key
  });

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late File file;
  late Reference  refStorage;
  ImagePicker imgpicker = ImagePicker();
  String? url;
  String? newImage;

  uploadImageFromCamera() async{
    XFile? img = await imgpicker.pickImage(source: ImageSource.camera);
    if(img != null){
      file = File(img.path);
      newImage = img.path;
      String imgName = "$widget.id";
      refStorage = FirebaseStorage.instance.ref("Assets/$imgName");
    }
    else{
      print("there is no image");
    }
  }
  uploadImageFromGallery() async{
    XFile? img = await imgpicker.pickImage(source: ImageSource.gallery);
    if(img != null){
      file = File(img.path);
      newImage = img.path;
      String imgName = "$widget.id";
      refStorage = FirebaseStorage.instance.ref("Assets/$imgName");
    }
    else{
      print("there is no image");
    }
  }

  changePicOptions(context) {
    return showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.all(25),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          color: Color(0xFF0F0F1E),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Color(0xFF6034A6),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30,),
                ),
                InkWell(
                  onTap: ()=> uploadImageFromCamera(),
                  child: Text("Open Camera", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Divider(color: Color(0xFF6034A6), thickness: 3,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Color(0xFF6034A6),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.photo_album_outlined, color: Colors.white, size: 30,),
                ),
                InkWell(
                  onTap: ()=> uploadImageFromGallery(),
                  child: Text("Choose From Gallery", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF6034A6),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF6034A6),
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: MediaQuery.of(context).viewInsets.bottom != 0 ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: Color(0xFF0F0F1E),
                      width: double.infinity,
                      height: 150,
                      padding: EdgeInsets.only(top: 30),
                      child: Text("Don't Forget To Smile",textAlign: TextAlign.center ,style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 80,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF6034A6),
                        radius: 75,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF0F0F1E),
                          backgroundImage: newImage == null ? AssetImage("Assets/avatar.png") : AssetImage("$newImage")
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85),
                  child: InkWell(
                    onTap: () => changePicOptions(context),
                    child: Text("Change Picture",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF0F0F1E), fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Info(title: "Username", content: widget.username, show: true,),
                      Info(title: "Email", content: widget.email, show: true),
                      Info(title: "Password", content: widget.password, show: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}