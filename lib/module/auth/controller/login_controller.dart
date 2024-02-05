import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:chat_bot_demo/services/shared_prefrences_services.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  FirebaseServices services = FirebaseServices();
  SharedPrefrencesServices prefs = SharedPrefrencesServices.instance;

  login() {
   services.userAuthentication(email.text,password.text)
       .then((value) async {
     print("loginvalue-$value");
      if(value == null){
     //   Get.snackbar("Fail", "Invalid User");
        print("Invalid");
      }else{
      //  print("loginvalue-$value");

        prefs.saveUserDetails(value.toString());

        Get.offAll(()=>const MyHomePage());

      }
     prefs.isLoginUser();
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
  void onClose() {

    super.onClose();
    email.dispose();
    password.dispose();
  }

}