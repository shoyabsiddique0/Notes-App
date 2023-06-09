import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var data = {}.obs;
  var notes = [].obs;
  @override
  void onInit() async{
    notes.value = await retriveNotes();
    data.value = await retriveInfo();
    super.onInit();
  }
  void logout(){
      try{
        final auth = FirebaseAuth.instance;
        auth.signOut();
        Get.back();
      } on FirebaseAuthException catch(e){
        Get.snackbar("Error", e.message.toString());
      }
  }
  Future<Map<String, String>> retriveInfo() async{
    Map<String, String> data = {};
    final databaseRef = FirebaseFirestore.instance.collection("User");
    await databaseRef.where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email).get().then((QuerySnapshot value) {
      for (var element in value.docs) {
        data = {
          'firstName': element['firstName'],
          'lastName': element['lastName'],
          'email': element['email'],
          'imageLink': element['imageLink'],
        };
      }
    });
    return data;
  }
  Future<List> retriveNotes() async{
    Map<String, String> notes = {};
    List allNotes = [];
    final databaseRef = FirebaseFirestore.instance.collection("Notes/${FirebaseAuth.instance.currentUser!.email}/notes");
    await databaseRef.get().then((QuerySnapshot value) {
      for (var element in value.docs) {
        notes={
          'title': element['title'],
          'body': element['body'],
          'id' : element.id
        };
        allNotes.add(notes);
      }
    });
    return allNotes;
  }
  Future<void> deleteNote(String id) async{
    final databaseRef = FirebaseFirestore.instance.collection("Notes/${FirebaseAuth.instance.currentUser!.email}/notes");
    await databaseRef.doc(id).delete().then((value) => print("Deleted Successfully")).catchError((error)=>print("error"));
    HomeController controller = Get.find<HomeController>(tag: "HomeController");
    controller.notes.value = await controller.retriveNotes();
  }
}