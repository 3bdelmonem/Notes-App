import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/Component/loading.dart';
import 'package:notes/Component/setting.dart';
import 'package:notes/Component/showAvatar.dart';

// ignore: must_be_immutable
class Mydrawer extends StatelessWidget {
  late String myUsername, myEmail, myPassword, myId;
  Mydrawer(String username, String email, String password, String id) {
    myUsername = username;
    myEmail = email;
    myPassword = password;
    myId = id;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      backgroundColor: Color(0xFF6034A6),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            padding: EdgeInsets.fromLTRB(15.w, 50.h, 15.w, 15.h),
            decoration: BoxDecoration(color: Color(0xFF0F0F1E)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowAvatar(),
                Padding(
                  padding: const EdgeInsets.only(left: 15).w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(myUsername,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          width: 175.w,
                          child: Text("${myEmail}",
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10.sp,
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15).h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0F1E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(
                      Icons.auto_stories_rounded,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  ),
                  title: Text("Notes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(
                  color: Color(0xFF0F0F1E),
                  indent: 15.w,
                  endIndent: 15.w,
                  thickness: 2.r,
                ),
                ListTile(
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0F1E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(
                      Icons.border_color_rounded,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  ),
                  title: Text("Add Note",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).pushNamed("AddNote");
                  },
                ),
                Divider(
                  color: Color(0xFF0F0F1E),
                  indent: 15.w,
                  endIndent: 15.w,
                  thickness: 2.r,
                ),
                ListTile(
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0F1E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child:
                        Icon(Icons.settings, color: Colors.white, size: 30.r),
                  ),
                  title: Text("Setting",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Setting(
                              id: myId,
                              username: myUsername,
                              email: myEmail,
                              password: myPassword,
                            )));
                  },
                ),
                Divider(
                    color: Color(0xFF0F0F1E),
                    indent: 15.w,
                    endIndent: 15.w,
                    thickness: 2.r),
                ListTile(
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0F1E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(
                      Icons.handshake_outlined,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  ),
                  title: Text("Help",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).pushNamed("Help");
                  },
                ),
                Divider(
                    color: Color(0xFF0F0F1E),
                    indent: 15.w,
                    endIndent: 15.w,
                    thickness: 2.r),
                ListTile(
                  leading: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0F1E),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(Icons.logout_rounded,
                        color: Colors.white, size: 30.r),
                  ),
                  title: Text("Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF0F0F1E),
                          title: Text("Are you sure you want to Logout ?"),
                          titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold),
                          titlePadding: EdgeInsets.symmetric(horizontal: 10),
                          icon: Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.red,
                            size: 60.r,
                          ),
                          iconPadding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.red,
                                  width: 4.w,
                                  strokeAlign: BorderSide.strokeAlignInside),
                              borderRadius: BorderRadius.circular(25.r)),
                          actionsPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 20.h),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                showLoading(context);
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context)
                                    .pushReplacementNamed("SplashScreen");
                              },
                              child: Text("Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp)),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(135.w, 40.h),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.r))),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp)),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(135.w, 40.h),
                                  backgroundColor: Color(0xFF0F0F1E),
                                  foregroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.red,
                                          width: 3.w,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside),
                                      borderRadius: BorderRadius.circular(60.r))),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
