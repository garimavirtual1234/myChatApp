
import 'package:chat_bot_demo/routes/route_class.dart';

import 'package:chat_bot_demo/services/shared_prefrences_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../model/user_model.dart';

class LoginController extends GetxController{


  late TextEditingController email;
  late TextEditingController password;
  RxBool isLoading = false.obs;

 SharedPrefrencesServices services = SharedPrefrencesServices();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel?> getCurrentUserData() async {
    var userData =
    await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  signIn() async {
    try{
      isLoading.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      isLoading.value = false;
      var currentUserId = FirebaseAuth.instance.currentUser?.uid??'';
      if(currentUserId.isNotEmpty){
        services.setUserId(currentUserId);
        Get.offAllNamed(AppRoute.home);
      }
    }on FirebaseAuthException catch(e){
      isLoading.value = false;
      if(e.code == 'invalid-email'){
        Get.showSnackbar(
            const GetSnackBar(
              title: "Fail!!",
              message: "Not Found, Try with another email address",
              duration: Duration(seconds: 3),
            )
        );
      }
      if(e.code == 'wrong-password'){
        Get.showSnackbar(
            const GetSnackBar(
              title: "Fail!!",
              message: "Password is incorrect",
              duration: Duration(seconds: 3),
            ));
      } if(e.code == 'user-not-found'){
        Get.showSnackbar(
            const GetSnackBar(
              title: "Fail!!",
              message: "The provided credential is invalid",
              duration: Duration(seconds: 3),
            ));
      }
    }
    catch(e){
      isLoading.value = false;
      throw Exception(e);
    }

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