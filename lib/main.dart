import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/HomePage/View/Home.dart';
import 'package:notes_app/Login/View/Login.dart';
import 'package:notes_app/Login/controller/LoginController.dart';
import 'package:notes_app/Notes/View/Notes.dart';
import 'package:notes_app/SignUp/View/SignUp.dart';
import 'package:notes_app/firebase_options.dart';

void main() async{
  String path = "/login";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot){
        if(snapshot.hasData){
          return Home();
        }
        else if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        return Login();
      },
    ),
    getPages: [
      GetPage(name: '/', page: () => Home()),
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/Signup', page: () => SignUp()),
      GetPage(name: '/notes', page: () => Notes()),
    ],
  ));
}