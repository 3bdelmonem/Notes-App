import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/Component/cardInfo.dart';
import 'package:http/http.dart' as http;
import 'package:notes/Component/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/home.dart';
import 'deleteAccount.dart';

// ignore: must_be_immutable
class Setting extends StatefulWidget {
  late String username;
  late String email;
  late String password;
  late String id;
  Setting({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
    super.key
  });
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  File? imageFile;
  late Reference  refStorage;
  ImagePicker imagePicker = ImagePicker();
  
  chooseFromCamera(BuildContext context) async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      Navigator.of(context).pop();
    }
  }
  chooseFromGallery(BuildContext context) async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      Navigator.of(context).pop();
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
    if(imageFile != null){
      showLoading(context);
      Reference  refStorage = FirebaseStorage.instance.ref("Assets/${widget.id}/avatarImage");
      await refStorage.putFile(imageFile!);
      String url = await refStorage.getDownloadURL();
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        saveImage(response.bodyBytes);
      }else{
        //TODO: Handle error
      }
    }
  }

  changePicOptions(context) {
    return showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.all(25).r,
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35.r), topRight: Radius.circular(35.r)),
          color: Color(0xFF0F0F1E),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10).w,
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Color(0xFF6034A6),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30.r,),
                ),
                InkWell(
                  onTap: ()=> chooseFromCamera(context),
                  child: Text("Open Camera", style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Divider(color: Color(0xFF6034A6), thickness: 3.r,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10).w,
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Color(0xFF6034A6),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Icon(Icons.photo_album_outlined, color: Colors.white, size: 30.r),
                ),
                InkWell(
                  onTap: ()=> chooseFromGallery(context),
                  child: Text("Choose From Gallery", style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
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
        backgroundColor: Color(0xFF0F0F1E),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF6034A6),
          foregroundColor: Colors.white,
          leadingWidth: 150.w,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15).w,
                  child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25.r),
                ),
                Text("Setting", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100.h,
                      padding: EdgeInsets.only(top: 30).h,
                      decoration: BoxDecoration(
                        color: Color(0xFF6034A6),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r)),
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF0F0F1E),
                        radius: 85.r,
                        child: Container(
                          width: 155.w,
                          height: 155.h,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF6034A6),
                            borderRadius: BorderRadius.circular(360.r)
                          ),
                          child: imageFile == null?
                          FutureBuilder(
                            future: getImage(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Image(image: snapshot.data!.image, fit: BoxFit.cover,);
                              }
                              else{
                                return Center(child: CircularProgressIndicator(color: Color(0xFF6034A6), strokeWidth: 6.w));
                              }
                            },
                          )
                          : Image(image: FileImage(imageFile!), fit: BoxFit.cover)
                        )
                      ),
                    )
                  ],
                ),
              ),
              
              Container(
                height: 600.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => changePicOptions(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_square, color: Color(0xFF6034A6), size: 30.r),
                          Text("Change Picture", style: TextStyle(color: Color(0xFF6034A6), fontSize: 22.sp, fontWeight: FontWeight.bold),),
                          
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Info(title: "Username", content: widget.username, show: true,),
                        Info(title: "Email", content: widget.email, show: true),
                        Info(title: "Password", content: widget.password, show: false),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async{
                              await saveChanges();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(
                                id: widget.id,
                                username: widget.username,
                                email: widget.email,
                                password: widget.password,
                              )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6034A6),
                              minimumSize: Size(375.w, 60.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))
                            ),
                            child: Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold),),
                          ),
                          InkWell(
                            onTap: () => delAccount(context, widget.id, widget.email, widget.password),
                            child: Text("Delete Account", style: TextStyle(color: Colors.red, fontSize: 22.sp, fontWeight: FontWeight.bold),)
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),             
            ],
          ),
        ),
        
      ),
    );
  }
}