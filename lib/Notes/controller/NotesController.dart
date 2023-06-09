import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/HomePage/controller/HomeController.dart';

class NotesController extends GetxController{
  Future addNote(String title, String body) async{
    try{
      final databaseRef = FirebaseFirestore.instance.collection("Notes/${FirebaseAuth.instance.currentUser?.email}/notes");
      await (databaseRef.add({
        "title": title,
        "body": body
      }));
    } catch(e){
      print(e);
    }
    HomeController controller = Get.find<HomeController>(tag: "HomeController");
    controller.notes.value = await controller.retriveNotes();
  }
  Future updateNote(String title, String body, String id) async{
    try{
      final databseRef = FirebaseFirestore.instance.collection("Notes/${FirebaseAuth.instance.currentUser?.email}/notes");
      await databseRef.doc(id).update({
        'title': title,
        'body': body
      }).then((value) => print("Updated")).catchError((error) => print(error));
      HomeController controller = Get.find<HomeController>(tag: "HomeController");
      controller.notes.value = await controller.retriveNotes();
    }
    catch(e){
      print(e);
    }
  }
}