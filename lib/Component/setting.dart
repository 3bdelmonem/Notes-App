import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Component/settingInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  changePicOptions() {
    return showModalBottomSheet(backgroundColor: Colors.white.withOpacity(0), context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.all(25),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          color: Color(0xFF6034A6),
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
                  color: Color(0xFF0F0F1E),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30,),
                ),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Text("Open Camera", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Divider(color: Color(0xFF0F0F1E), thickness: 2.5,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Color(0xFF0F0F1E),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.photo_album_outlined, color: Colors.white, size: 30,),
                ),
                InkWell(
                  onTap: () {
                    
                  },
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
        backgroundColor: Color(0xFF0F0F1E),
        appBar: AppBar(
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
                      color: Color(0xFF6034A6),
                      width: double.infinity,
                      height: 150,
                      padding: EdgeInsets.only(top: 30),
                      child: Text("Edit Your Information",textAlign: TextAlign.center ,style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 80,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF0F0F1E),
                        radius: 75,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF6034A6),
                          backgroundImage: AssetImage("Assets/avatar.png"),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85),
                  child: InkWell(
                    onTap: () => changePicOptions(),
                    child: Text("Change Picture",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF6034A6), fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SettingInfo(title: "Username", content: widget.username, enableEditing: true,),
                      SettingInfo(title: "Email", content: widget.email, enableEditing: false),
                      SettingInfo(title: "Password", content: widget.password, enableEditing: false),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final SharedPreferences changes = await SharedPreferences.getInstance();
                    String newUsername = changes.getString("newUsername")??"";
                    String id = prefs.getString("id")??"";
                    if(newUsername == "" || newUsername.startsWith(" ") || newUsername == widget.username){
                      Navigator.of(context).pop();
                    }
                    else{
                      prefs.setString("username", newUsername);
                      prefs.reload();
                      CollectionReference userUpdate = await FirebaseFirestore.instance.collection("users");
                      userUpdate.doc(id).update({
                        "username": newUsername,
                      }).then((value) {
                        print("Updated Successfully");
                      }).catchError((e){
                        print("Error = $e");
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Save Changes", style: Theme.of(context).textTheme.labelLarge),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(370, 60),
                    backgroundColor: Color(0xFF6034A6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)
                    )
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