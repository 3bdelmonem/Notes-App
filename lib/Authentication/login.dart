import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/Authentication/signupAndLoginValidation.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget>  createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  
  bool seePassword = true;
  Icon hiddenIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 22.r);
  Icon visibleIcon = Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 22.r);
  Icon passordIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 22.r);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10).r,
          color: Color(0xFF0F0F1E),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(child: Image.asset("Assets/notesLogo.png", height: 250.h, fit: BoxFit.contain,)),
                Form(
                  key: _formState,
                  child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (!RegExp(r'\w{3,}').hasMatch(value!)){
                        return "Invalid Email";
                        }
                        else{
                          return null; 
                        }
                      },
                      cursorColor: Color(0xFF6034A6),
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.person, color: Color(0xFF6034A6), size: 30.r,),
                        hintStyle: TextStyle(color:Color(0xFFAEAEB3)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Colors.red),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ), 
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      validator: (value) {
                        // (?=.*[A-Z])       ===> should contain at least one upper case
                        // (?=.*[a-z])       ===> should contain at least one lower case
                        // (?=.*?[0-9])      ===> should contain at least one digit
                        // (?=.*?[!@#\$&*~]) ===> should contain at least one Special character
                        // .{8,}             ===> Must be at least 8 characters in length  
                        if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!)){
                        return "Invalid Password";
                        }
                        else{
                          return null; 
                        }
                      },
                      cursorColor: Color(0xFF6034A6),
                      controller: passwordController,
                      obscureText: seePassword,
                      style: seePassword == false ? TextStyle(color: Colors.white) : TextStyle(color: Color(0xFF6034A6)),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              seePassword = !seePassword;
                              passordIcon = seePassword == true ? hiddenIcon:visibleIcon;
                            });
                          },
                          icon: passordIcon,
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_person, color: Color(0xFF6034A6), size: 30.r,),
                        hintStyle: TextStyle(color:Color(0xFFAEAEB3)),
                        // enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Colors.red),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                          borderRadius: BorderRadius.circular(35.r)
                        ),
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.only(top: 20).h,
                      child: ElevatedButton(
                        onPressed: () async{
                          if(_formState.currentState!.validate()){
                            await SignupAndLoginValidation(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text
                              ).loginValidation();
                          }
                        },
                        child: Text("Login", style: Theme.of(context).textTheme.labelLarge),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(370.w, 60.h),
                          backgroundColor: Color(0xFF6034A6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.r)
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushReplacementNamed("SignUp");
                              },
                              child: Text("Sign Up Now", style: TextStyle(color: Color(0xFF6034A6), fontSize: 16.sp, fontWeight: FontWeight.bold))
                            )
                        ],
                      ),
                    ),
                  ],
                )
              )
              ],
            ),
          ),
        )
      ),
    );
  }
}