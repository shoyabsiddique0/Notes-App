import 'dart:math';

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
  final HomeController controller = Get.put(HomeController(), tag: "HomeController");
  @override
  Widget build(BuildContext context) {
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
        drawer: Obx(()=>Drawer(
            child: ListView(
              children: [
                CircleAvatar(
                  radius: width*0.2,
                  backgroundImage: controller.data.value['imageLink'] != null ? NetworkImage(controller.data.value["imageLink"]) as ImageProvider: AssetImage("assets/images/quill.png") as ImageProvider,
                  ),
                SizedBox(height: width*0.1,),
                controller.data.value['firstName'] != null ? Text("First Name: ${controller.data.value['firstName']}") : Text(""),
                SizedBox(height: width*0.05,),
                controller.data.value['lastName'] != null ? Text("Last Name: ${controller.data.value['lastName']}") : Text(""),
                SizedBox(height: width*0.05,),
                controller.data.value['email'] != null ? Text("Email: ${controller.data.value['email']}") : Text(""),
              ],
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Get.toNamed("/notes", arguments: ["new"]);
        },shape: const StarBorder(), child: Image.asset("assets/images/quill.png", fit: BoxFit.contain,),),
        backgroundColor: Colors.white,
      body: Obx(()=> StaggeredGrid.count(crossAxisCount: 2,
      axisDirection: AxisDirection.down,
        children: controller.notes.value != [] ? controller.notes.value.map((e) => StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: GestureDetector(
            onTap: (){
              Get.defaultDialog(
                title: "What You Want to do",
                textConfirm: "Edit",
                textCancel: "Delete",
                onConfirm: (){
                  Get.back();
                  Get.toNamed('/notes', arguments: ["update", e['title'], e['body'], e['id']]);
                },
                onCancel: (){
                  controller.deleteNote(e['id']);
                  Get.back();
                }
              );
            },
            child: Container(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              child: Column(children: [
                Text(e['title'], style: TextStyle(
                  fontSize: width*0.07
                ),),
                Text(e['body'], style: TextStyle(
                  fontSize: width*0.06
                ),),
              ]),
            ),
          ),
        )).toList() : [],
      // ),
      // body: Obx(()=>ListView(
      //   children: controller.notes.value.map((e) => ListTile(
      //     title: Text(e['title']),
      //     subtitle: Text(e['body']),
      //     onTap: (){
      //       Get.defaultDialog(
      //         title: "What You Want to do",
      //         textConfirm: "Edit",
      //         textCancel: "Delete",
      //         onConfirm: (){
      //           Get.back();
      //           Get.toNamed('/notes', arguments: ["update", e['title'], e['body'], e['id']]);
      //         },
      //         onCancel: (){
      //           controller.deleteNote(e['id']);
      //           Get.back();
      //         }
      //       );
      //     },
      //   )).toList(),
      )),
      // )
    );
  }
}
