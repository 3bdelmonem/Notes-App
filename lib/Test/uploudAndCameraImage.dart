import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});
  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {

  File? imageFile;
  final imagePicker = ImagePicker();
  String? imagePath;
  var finalImage;

  chooseFromCamera() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        imagePath = pickedImage.path;
      });
    }
  }
  uploudFromGallery() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        imagePath = pickedImage.path;
      });
    }
  }
  
  static Future<bool> saveImage(List<int> imageBytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    return prefs.setString("avatar", base64Image);
  }

  static Future<Image> getImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? img = prefs.getString("avatar");
    Uint8List bytes = base64Decode(img!);
    return Image.memory(bytes);
  }

  saveChanges() async{   
    if(imagePath!= null){
      Reference  refStorage = FirebaseStorage.instance.ref("Assets/id/avatarImage");
      await refStorage.putFile(imageFile!);
      ByteData bytes = await rootBundle.load(imagePath!);
      saveImage(bytes.buffer.asUint8List());
    }
  }

  // onlineImageGallery() async{
  //   XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if(img != null){
  //     setState(() {
  //       imageFile = File(img.path);
  //     });
  //     Reference  refStorage = FirebaseStorage.instance.ref("Assets/id/avatarImage");
  //     await refStorage.putFile(imageFile!);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString("avatar", img.path.toString());
  //     setState(() {
  //       avatar = prefs.getString("avatar");
  //       print("======================================${avatar}==================");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Preview", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: 175,
                      height: 175,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3)),
                      child:  imageFile == null
                          ? CircularProgressIndicator()
                          : Image.file(imageFile!),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Save Changes", style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: 175,
                      height: 175,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3)),
                      child: CircularProgressIndicator()
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: chooseFromCamera,
                  child: Text("choose From Camera", style: TextStyle(fontSize: 14, fontFamily: "DeliciousHandrawn")),
                ),
                ElevatedButton(
                  onPressed: uploudFromGallery,
                  child: Text("Uploud From Gallery", style: TextStyle(fontSize: 14, fontFamily: "DeliciousHandrawn")),
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: saveChanges,
                  child: Text("Save Changes", style: TextStyle(fontSize: 14, fontFamily: "DeliciousHandrawn")),
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text("Delete Image", style: TextStyle(fontSize: 14, fontFamily: "DeliciousHandrawn")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
//Text("Image not Found", style: TextStyle(color: Colors.blue, fontSize: 24, fontFamily: "DeliciousHandrawn", fontWeight: FontWeight.bold))

