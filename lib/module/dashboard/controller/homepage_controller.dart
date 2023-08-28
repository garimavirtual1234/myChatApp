

import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../auth/view/login_screen.dart';
import '../model/user.dart';

class HomePageController extends GetxController{
FirebaseServices services = FirebaseServices();

UserModel? user;



  loggingOut() async {
    await services.logOut().then((value) =>
        Get.to(()=>const LoginScreen()));
  }

Future<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
    FirebaseFirestore.
    instance.collection('users').get();

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

}