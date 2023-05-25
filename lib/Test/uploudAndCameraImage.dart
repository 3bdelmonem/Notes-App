import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  File? image;
  final imagePicker = ImagePicker();
  uploadImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 375,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3)),
              child: image == null
                  ? Text("Image not Found", style: TextStyle(color: Colors.blue, fontSize: 24, fontFamily: "DeliciousHandrawn", fontWeight: FontWeight.bold))
                  : Image.file(image!),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Image", style: TextStyle(fontSize: 24, fontFamily: "DeliciousHandrawn")),
            )
          ],
        ),
      ),
    );
  }
}
