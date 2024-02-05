

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/shared_prefrences_services.dart';

class RegisterController extends GetxController{
  final registerFormKey=GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  FirebaseServices services = FirebaseServices();
  SharedPrefrencesServices prefs = SharedPrefrencesServices.instance;

  register(){
    services.createUser
      (name.text, email.text, password.text).
    then((value) {
      prefs.saveUserDetails(value.toString());
      Get.offAll(()=>const MyHomePage());

    });
    prefs.isLoginUser();
    update();
  }

  @override
  void onInit() {

    super.onInit();
    name= TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }
}