import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/SignUp/controller/SignUpController.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final SignUpController controller = Get.put(SignUpController());

  var image = XFile("").obs;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    return img;
  }

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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Create a new Account",
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
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        label: Text("Full Name"),
                        hintText: "Enter Your Name",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                        label: Text("Password"),
                        hintText: "Enter Your Password",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()),
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
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Upload Image"),
                      ElevatedButton(
                          onPressed: () async {
                            XFile data = await getImage(ImageSource.gallery);
                            image.value = data;
                          },
                          child: const Text("upload")),
                      Flexible(
                        child: Obx(
                          () => Text(
                            image.value.name ?? "",
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    width: width * 0.9,
                    height: height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        if(emailController.text != "" && passController.text != "" && nameController.text != "" && image.value != XFile("")){
                          controller.createNewUser(
                            emailController.text,
                            passController.text,
                            nameController.text,
                            image.value);
                        }
                        else{
                          Get.snackbar("Error", "Please fill everything", snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                      child: const Text("Sign Up"),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Already Have An Account?"),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "Login",
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
