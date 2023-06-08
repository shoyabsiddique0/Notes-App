import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController{
  Future<String> createNewUser(String email, String pass, String name, XFile image) async{
    try{
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      var nameList = name.split(" ");
      final storageref = FirebaseStorage.instance.ref("images/$name.jpg");
      String filePath = image.path;
      File file = File(filePath);
      try{
        await storageref.putFile(file);
      } catch(e){
        Get.snackbar("Error", e.toString());
      }
      String imageLink = await storageref.getDownloadURL();
      final databaseRef = FirebaseFirestore.instance.collection("User");
      await databaseRef.add({
        "firstName": nameList[0],
        "lastName" : nameList[nameList.length - 1],
        "email": email,
        "imageLink": imageLink
      });
    } on FirebaseAuthException catch(e){
      Get.snackbar("Error", e.message.toString());
    }
    return "";
  }
}