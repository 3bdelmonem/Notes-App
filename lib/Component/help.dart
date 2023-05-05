import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
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
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Get Support", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () async{
                  const number = '+201111239035'; //set the number here
                  await FlutterPhoneDirectCaller.callNumber(number);
                },
                child: Icon(Icons.phone_iphone, color: Color(0xFF6034A6), size: 75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}