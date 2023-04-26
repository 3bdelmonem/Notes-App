import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FFStorage extends StatefulWidget {
  const FFStorage({super.key});

  @override
  State<FFStorage> createState() => _FFStorageState();
}

class _FFStorageState extends State<FFStorage> {
  
  late File file;

  ImagePicker imgpicker = ImagePicker();

  uploadImage() async{
    XFile? img = await imgpicker.pickImage(source: ImageSource.camera);
    if(img != null){
      file = File(img.path);
      String imgName = basename(img.path);
      Reference  refStorage = FirebaseStorage.instance.ref("Assets/$imgName");
      await refStorage.putFile(file);
      String url = await refStorage.getDownloadURL();
      print("url = $url");
    }
    else{
      print("there is no image");
    }
  }

  getImage() async{
    var refStorage = await FirebaseStorage.instance.ref("Assets").list(ListOptions(maxResults: 3));
    var refFoldersStorage = await FirebaseStorage.instance.ref().list();

    refStorage.items.forEach((element) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(element.name);
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    });

    refFoldersStorage.prefixes.forEach((element) {
      print("=========================================");
      print(element.name);
      print("=========================================");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ()=> uploadImage(),
              child: Text("Upload Image")
            ),
            ElevatedButton(
              onPressed: ()=> getImage(),
              child: Text("Get Image")
            )
          ],
        ),
      ),
    );
  }
}