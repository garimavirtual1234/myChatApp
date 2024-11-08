

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_class.dart';
import '../../../services/shared_prefrences_services.dart';

class RegisterController extends GetxController{

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  RxBool isLoading = false.obs;
  SharedPrefrencesServices prefs = SharedPrefrencesServices();

  Future createUser() async {
    try {
      isLoading.value = true;
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text);
      var currentUserId = FirebaseAuth.instance.currentUser?.uid??'';
      if(currentUserId != ''){
        await FirebaseFirestore.instance.collection('users')
            .doc(currentUserId)
            .set(
            {
              "id":currentUserId,
              "name": name.text,
              "email": email.text,
              "password": password.text
            }
        );
        isLoading.value = false;
        prefs.setUserId(currentUserId);
        Get.offAllNamed(AppRoute.home);
        Get.showSnackbar(
          const GetSnackBar(
            title: "Success",
            message: "SignUp Successfully",
            duration: Duration(seconds: 3),
          ),
        );

      }

      return user;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'email-already-in-use') {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Fail!',
            message: "${e.message}",
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
    catch (e) {
      isLoading.value = false;
      Get.showSnackbar(
          GetSnackBar(
              title: 'Fail!',
              message: "$e",
              duration: const Duration(seconds: 3)));
      throw Exception(e);
    }
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
  void onDispose() {
    super.onClose();
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }
}