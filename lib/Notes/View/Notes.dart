import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_app/Notes/controller/NotesController.dart';

class Notes extends StatelessWidget {
  Notes({super.key});
  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final NotesController controller = Get.put(NotesController());
  @override
  Widget build(BuildContext context) {
    if(Get.arguments[0] != "new"){
      titleController.text = Get.arguments[1];
      bodyController.text = Get.arguments[2];
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Noteworthy Notes"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          actions: [
            IconButton(onPressed: ()async{
              if(Get.arguments[0] == "new"){
                await controller.addNote(titleController.text, bodyController.text);
                AsyncSnapshot.waiting();
                Get.back();
              }
              else{
                await controller.updateNote(titleController.text, bodyController.text, Get.arguments[3]);
                AsyncSnapshot.waiting();
                Get.back();
              }
            }, icon: Icon(Icons.check))
          ],
        ),
        backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: width*0.05, right: width*0.05, top: height*0.05),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    label: Text("Title"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.lerp(BorderSide(color: Colors.blue, width: 2), BorderSide(color: Colors.indigo, width: 2), 2.0)
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width*0.07
                ),
              ),
              SizedBox(height: height*0.02,),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.lerp(BorderSide(color: Colors.blue, width: 2), BorderSide(color: Colors.indigo, width: 2), 2.0)
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
      
                ),
                maxLines: (height*0.04).toInt(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
