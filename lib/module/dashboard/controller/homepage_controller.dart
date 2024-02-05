

import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:chat_bot_demo/services/shared_prefrences_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../auth/view/login_screen.dart';
import '../model/user.dart';

class HomePageController extends GetxController{
FirebaseServices services = FirebaseServices();
UserModel? user1;
String? groupChatId;
List<UserModel> users = [];
SharedPrefrencesServices prefs = SharedPrefrencesServices.instance;


getCurrentUserData() async {
 var user = await services.getUserData();
 user1=UserModel(
   id: user.id,
     email: user.data()['email']??'email',
     name: user.data()['name']??'user',
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
    await prefs.clearData();
    await services.logOut().then((value) =>
        Get.to(()=>const LoginScreen()));
  }

Future<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
    FirebaseFirestore.
    instance.collection('users').get();


void fetch() async{
 var currentUserId= FirebaseAuth.instance.currentUser!.uid;
 print(currentUserId);
  final result= await FirebaseFirestore.
  instance.collection('users').orderBy('name',descending: true).get();
  result.docs.forEach((element) async {
    UserModel user = UserModel();
    String id= element.id;
    user.id = element.id;
    user.name = element.data()['name']??"user";
    user.imageUrl=element.data()['image']??'';
    user.phoneNumber=element.data()['phone']??'';
    user.email= element.data()['email']??'';

    if (id.hashCode <= currentUserId.hashCode) {
      groupChatId = '$id-$currentUserId';
    } else {
      groupChatId = '$currentUserId-$id';
    }
    final m = await FirebaseFirestore.instance
        .collection('chats')
        .doc(groupChatId)
        .collection('messages').orderBy('timestamp',descending: true)
        .get();
    if (m.docs.isNotEmpty) {
      //user!.userLastMessage= m.docs.first.data()['content'];
      if(m.docs.first.data()['type'] =='text'){
        user!.userLastMessage= m.docs.first.data()['content'];
      }else if(m.docs.first.data()['type'] == 'video'){
        user!.userLastMessage = 'video';
      }else{
        user!.userLastMessage= 'image';
      }
      user!.lastMessageTime= DateFormat('hh:mm a').format(
        DateTime.fromMillisecondsSinceEpoch(
          int.parse(m.docs.first.data()['timestamp']),
        ),).toString();
      print(user!.lastMessageTime);
    }
   print(user!.lastMessageTime);
    print(user!.userLastMessage);
    users.add(user);
    update();
  });
}


@override
  void onInit() {
    super.onInit();
    //prefrencesServices.isLoginUser();
     getCurrentUserData();
    prefs.getFcmToken();
     fetch();
    readUsers();
  }

}