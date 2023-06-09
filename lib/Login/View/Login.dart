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
              padding: EdgeInsets.only(
                  top: height * 0.08, right: width * 0.2, left: width * 0.05),
              height: height * 0.3,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blueAccent,
                    Colors.indigoAccent,
                    Colors.indigo,
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                  backgroundBlendMode: BlendMode.modulate),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign in to your Account",
                      style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Sign in to your Account",
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: height * 0.1, left: width * 0.05, right: width * 0.05),
              child: Column(
                children: [
                  TextFormField(
                    validator: (input) {
                      const pattern =
                          r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                      final regex = RegExp(pattern);
                      if (input!.isEmpty) {
                        return "Please Enter Email";
                      }
                      return input.isNotEmpty && !regex.hasMatch(input)
                          ? 'Enter a valid email address'
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                          label: const Text("Password"),
                          hintText: "Enter Your Password",
                          border: const OutlineInputBorder(),
                          floatingLabelStyle:
                              const TextStyle(color: Colors.grey),
                          focusedBorder: const OutlineInputBorder(),
                          suffixIcon: Obx(
                            () => IconButton(
                              icon: controller.obscure.value
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                controller.obscure.value =
                                    !controller.obscure.value;
                              },
                            ),
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.obscure.value,
                      validator: (input) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#&*~]).{8,}$');
                        if (input!.isEmpty) {
                          return 'Please enter password';
                        } else {
                          if (!regex.hasMatch(input)) {
                            return 'Enter valid password';
                          } else {
                            return null;
                          }
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.to(() => ForgotPassword());
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailController.text != "" &&
                            passController.text.length > 6) {
                          controller.LoginWithEmail(
                              emailController.text, passController.text);
                        } else {
                          Get.snackbar("Error", "Please Fill all the data",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Do You Have An Account?"),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/Signup");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ))
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
