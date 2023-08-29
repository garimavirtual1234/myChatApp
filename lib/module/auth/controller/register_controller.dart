

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  final registerFormKey=GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  FirebaseServices services = FirebaseServices();

  register(){
    services.createUser
      (name.text, email.text, password.text).
    then((value) {
      Get.offAll(()=>const MyHomePage());
    });
  }

  @override
  void onInit() {

    super.onInit();
    name= TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {

    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
  }
}