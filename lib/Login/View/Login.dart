import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_app/Forgot%20Password/View/ForgotPassword.dart';
import 'package:notes_app/Login/controller/LoginController.dart';

class Login extends StatelessWidget {
  Login({super.key});
  LoginController controller = Get.put(LoginController());
  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Noteworthy Notes"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: height*0.08, right: width*0.2, left: width*0.05),
                height: height*0.3,
                width: width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blueAccent,
                    Colors.indigoAccent,
                    Colors.indigo,
                  ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                  ),
                  backgroundBlendMode: BlendMode.modulate
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    "Sign in to your Account",
                    style: TextStyle(
                      fontSize: width*0.12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    ),
                    Text(
                    "Sign in to your Account",
                    style: TextStyle(
                      fontSize: width*0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.w100
                    ),
                  ),

                  ]
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: height*0.1, left: width*0.05, right: width*0.05),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: height*0.05,),
                    TextField(
                      controller: passController,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        hintText: "Enter Your Password",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold
                          ),
                      ), onPressed: (){
                        Get.to(()=>ForgotPassword());
                      },),
                    ),
                    SizedBox(height: height*0.05,),
                    SizedBox(
                      width: width*0.9,
                      height: height*0.07,
                      child: ElevatedButton(onPressed: (){
                        controller.LoginWithEmail(emailController.text, passController.text);
                      }, style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ), child: const Text("Login"),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do You Have An Account?"),
                        TextButton(onPressed: (){
                          Get.toNamed("/Signup");
                        }, child: const Text("Register",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold
                          ),
                        ))
                      ]
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
