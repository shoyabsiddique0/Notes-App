import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController{
  Future<String> sendEmail(String email) async{
    try{
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
      return "Password Reset Link Sent";
    } on FirebaseAuthException catch(e){
      return e.message.toString();
    }
  }
}