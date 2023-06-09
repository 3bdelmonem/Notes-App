import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text("Help", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            ],
          ),
        ),
      ),
      
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Get Support", style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.only(top: 10).h,
              child: InkWell(
                onTap: () async{
                  const number = '+201111239035'; //set the number here
                  await FlutterPhoneDirectCaller.callNumber(number);
                },
                child: Icon(Icons.phone_iphone, color: Color(0xFF6034A6), size: 75.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}