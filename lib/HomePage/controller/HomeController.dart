import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  Map data = {};
  @override
  void onInit() async{
    data = await retriveInfo();
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
        print(element);
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
}