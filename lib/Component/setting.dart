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
                    onTap: () {},
                    child: Text("Change Picture",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF6034A6), fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SettingInfo(title: "Username", content: widget.username),
                      SettingInfo(title: "Email", content: widget.email),
                      SettingInfo(title: "Password", content: widget.password),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}