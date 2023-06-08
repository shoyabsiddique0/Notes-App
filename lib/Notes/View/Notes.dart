import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notes extends StatelessWidget {
  Notes({super.key});
  final height = ScreenUtil.defaultSize.height;
  final width = ScreenUtil.defaultSize.width;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Noteworthy Notes"),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.check))
          ],
        ),
        backgroundColor: Colors.white,
      body: Container(
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
    );
  }
}
