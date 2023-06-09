import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  var obscure = true.obs;
  void LoginWithEmail(String email, String pass) async{
    try{
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      // AsyncSnapshot.waiting();
      // Get.offNamed("/");
    }on FirebaseAuthException catch (e){
      print("Catch kar liya");

      Get.snackbar("Error", e.message.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}