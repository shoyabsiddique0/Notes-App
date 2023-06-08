import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_app/Forgot%20Password/controller/ForgotController.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final ForgotController controller = Get.put(ForgotController());
  final TextEditingController emailController = TextEditingController();
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
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: width*0.05, right: width*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                width: width*0.9,
                height: height*0.07,
                child: ElevatedButton(onPressed: ()async{
                  String data = await controller.sendEmail(emailController.text);
                  Get.snackbar("Message", data);
                }, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ), child: const Text("Send Link"),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
