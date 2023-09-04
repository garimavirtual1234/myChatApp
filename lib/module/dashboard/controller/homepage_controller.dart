

import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../../auth/view/login_screen.dart';
import '../model/user.dart';

class HomePageController extends GetxController{
FirebaseServices services = FirebaseServices();
UserModel? user1;

getCurrentUserData() async {
 var user = await services.getUserData();
 user1=UserModel(
   id: user.id,
     email: user.data()['email']??'',
     name: user.data()['name']??'',
     password: user.data()['password']??'',
     imageUrl: user.data()['image']??'',
   phoneNumber: user.data()['phone']??''
 );
 update();
 print("name-${user1?.name??'null'}");
 print(user1?.email??'null');
 print("imageUrl-${user1?.imageUrl?? "image"}");
}

  loggingOut() async {
    await services.logOut().then((value) =>
        Get.to(()=>const LoginScreen()));
  }

Future<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
    FirebaseFirestore.
    instance.collection('users').get();

@override
  void onInit() {
    super.onInit();
     getCurrentUserData();
    readUsers();
  }

}