

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  FirebaseServices services = FirebaseServices();

  login() {
   services.userAuthentication(email.text,password.text)
       .then((value) {
     print(value);
      if(value==null){
     //   Get.snackbar("Fail", "Invalid User");
        print("Invalid");
      }else{
        Get.offAll(()=>const MyHomePage());
      }
      update();
    });
  }
  @override
  void onInit() {
    super.onInit();
    email= TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {

    super.dispose();
    email.dispose();
    password.dispose();
  }

}