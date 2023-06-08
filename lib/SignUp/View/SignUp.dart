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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: width*0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      "Create a new Account",
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
                    controller: nameController,
                    decoration: const InputDecoration(
                        label: Text("Full Name"),
                        hintText: "Enter Your Name",
                        border: OutlineInputBorder(),
                        floatingLabelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: height*0.05,),
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
                  SizedBox(height: height*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Upload Image"),
                      ElevatedButton(onPressed: () async{
                        XFile data = await getImage(ImageSource.gallery);
                        print(data.path);
                        image.value = data;
                      }, child: Text("upload")),
                      Flexible(
                        child: Obx(()=>Text(
                            image.value.name == null ? "" : image.value.name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,

                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height*0.05,),
                  Container(
                    width: width*0.9,
                    height: height*0.07,
                    child: ElevatedButton(onPressed: (){
                      controller.createNewUser(emailController.text, passController.text, nameController.text, image.value);
                    }, child: const Text("Sign Up"), style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already Have An Account?"),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: const Text("Login",
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
