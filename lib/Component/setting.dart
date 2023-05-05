import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // color: Colors.red,
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
                  // alignment: Alignment.center,
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
              padding: const EdgeInsets.fromLTRB(10, 85, 10, 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text("Change Picture",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF6034A6), fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      
    );
  }
}