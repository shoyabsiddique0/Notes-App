import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_app/HomePage/controller/HomeController.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final HomeController controller = Get.put(HomeController());
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = controller.data;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Noteworthy Notes"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          actions: [
            IconButton(onPressed: () async{
              Get.defaultDialog(
                onConfirm:() => controller.logout(),
                onCancel: () => Get.back(),
                title: "Alert",
                middleText: "Are You Sure You Want to Logout"
              );
            }, icon: Icon(Icons.logout_sharp))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              CircleAvatar(
                radius: width*0.2,
                backgroundImage: data['imageLink'] != null ? NetworkImage(data["imageLink"]) as ImageProvider: AssetImage("assets/images/quill.png") as ImageProvider,
                ),
              SizedBox(height: width*0.1,),
              data['firstName'] != null ? Text("First Name: ${data['firstName']}") : Text(""),
              SizedBox(height: width*0.05,),
              data['lastName'] != null ? Text("Last Name: ${data['lastName']}") : Text(""),
              SizedBox(height: width*0.05,),
              data['email'] != null ? Text("Email: ${data['email']}") : Text(""),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){

        }, child: Image.asset("assets/images/quill.png", fit: BoxFit.contain,),shape: StarBorder(),),
        backgroundColor: Colors.white,
      body: Text("Data")
    );
  }
}
