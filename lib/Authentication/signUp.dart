import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/Authentication/signupAndLoginValidation.dart';


class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool seePassword = true;
  bool seeConfirmPassword = true;

  GlobalKey<FormState> _formState = new GlobalKey<FormState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  var hiddenIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 22.r);
  var visibleIcon = Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 22.r);
  var passordIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 22.r);
  var confirmPassordIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 22.r);

  
  @override
  Widget build(BuildContext context) {
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
              Center(
                  child: Image.asset(
                "Assets/notesLogo.png",
                height: 250.h,
                fit: BoxFit.contain,
              )),
              Form(
                  key: _formState,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (!RegExp(r'\w{3,}').hasMatch(value!)) {
                            return "Invalid USername";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF6034A6),
                            size: 30.r,
                          ),
                          hintStyle: TextStyle(color: Color(0xFFAEAEB3)),
                          // enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.w, color: Colors.red),
                              borderRadius: BorderRadius.circular(35.r)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20).h,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)) {
                              return "Invalid Email";
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email address",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF6034A6),
                              size: 30.r,
                            ),
                            hintStyle: TextStyle(color: Color(0xFFAEAEB3)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.w, color: Colors.red),
                                borderRadius: BorderRadius.circular(35.r)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20).h,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value!)) {
                              return "Weak Password";
                            } else {
                              return null;
                            }
                          },
                          obscureText: seePassword,
                          style: seePassword == false ? TextStyle(color: Colors.white) : TextStyle(color: Color(0xFF6034A6)),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  seePassword = !seePassword;
                                  passordIcon = seePassword == true
                                      ? hiddenIcon
                                      : visibleIcon;
                                });
                              },
                              icon: passordIcon,
                            ),
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_person,
                              color: Color(0xFF6034A6),
                              size: 30.r,
                            ),
                            hintStyle: TextStyle(color: Color(0xFFAEAEB3)),
                            // enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.w, color: Colors.red),
                                borderRadius: BorderRadius.circular(35.r)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.w, color: Color(0xFF6034A6)),
                                borderRadius: BorderRadius.circular(35.r)),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (!(confirmPasswordController.text ==
                              passwordController.text)) {
                            return "Password Not Match";
                          } else {
                            return null;
                          }
                        },
                        obscureText: seeConfirmPassword,
                        style: seeConfirmPassword == false ? TextStyle(color: Colors.white) : TextStyle(color: Color(0xFF6034A6)),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  seeConfirmPassword = !seeConfirmPassword;
                                  confirmPassordIcon = seeConfirmPassword == true
                                      ? hiddenIcon
                                      : visibleIcon;
                                });
                              },
                              icon: confirmPassordIcon),
                          hintText: "Confirm Password",
                          prefixIcon: Icon(
                            Icons.lock_person,
                            color: Color(0xFF6034A6),
                            size: 30.r,
                          ),
                          hintStyle: TextStyle(color: Color(0xFFAEAEB3)),
                          // enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.w, color: Colors.red),
                              borderRadius: BorderRadius.circular(35.r)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Color(0xFF6034A6)),
                              borderRadius: BorderRadius.circular(35.r)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20).h,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_formState.currentState!.validate()){
                              await SignupAndLoginValidation(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text
                              ).signUpValidation(usernameController.text);
                            }
                          },
                          child: Text("Sign Up",
                              style: Theme.of(context).textTheme.labelLarge),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(370.w, 60.h),
                              backgroundColor: Color(0xFF6034A6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.r))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16.sp)),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed("Login");
                                },
                                child: Text("Login Now",
                                    style: TextStyle(
                                        color: Color(0xFF6034A6),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ),
                    ],
                  )
                )
            ],
          ),
        ),
      )),
    );
  }
}
