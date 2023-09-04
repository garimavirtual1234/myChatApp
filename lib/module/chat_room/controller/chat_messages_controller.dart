
import 'dart:io';

import 'package:chat_bot_demo/main.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessageController extends GetxController{
  late TextEditingController textController;
  FirebaseServices services = FirebaseServices();
 List listMessages = [];
 File? imageFile;
 bool isLoading = false;
 String? imageUrl;
  var args= Get.arguments;
String currentUser = FirebaseAuth.instance.currentUser!.uid;
String? groupChatId;
  String? name;

  @override
  void onInit() {

    super.onInit();
    textController=TextEditingController();

  }

  //checking if sent message
  bool isMessageSent(int index){
 //   print("ppp"+listMessages[index] as DocumentSnapshot);
    if((index > 0 && listMessages[index-1].get('idFrom') != FirebaseAuth.instance.currentUser!.uid)|| index == 0){
      return true;
    }else{
      return false;
    }
  }

  //checking if received message
bool isMessageReceived(int index){
   // print(listMessages[index]);
    if((index>0 && listMessages[index-1].get('idFrom') == FirebaseAuth.instance.currentUser!.uid) || index == 0){
      return true;
    }
    else {
        return false;
      }
}

void onSendMessage(String content,String type){
  if (FirebaseAuth.instance.currentUser!.uid.hashCode <= args[0].hashCode) {
    groupChatId = '${FirebaseAuth.instance.currentUser!.uid}-${args[0]}';
  } else {
    groupChatId = '${args[0]}-${FirebaseAuth.instance.currentUser!.uid}';
  }
  // groupChatId= "${FirebaseAuth.instance.currentUser!.uid}-${args[0]}";
    if(content.trim().isNotEmpty){
      textController.clear();
      services.sendChatMessage(
         content, type,
        groupChatId!,
        //  FirebaseFirestore.instance.collection('chats').
          // doc(FirebaseAuth.instance.currentUser!.uid).collection("messages").id,
           FirebaseAuth.instance.currentUser!.uid.toString(),
         args[0]
      );
      //showNotification(content);
    }else{
      Get.snackbar("Alert!", "Nothing to send");
    }
    update();
}

selectImageSource(){
  Get.defaultDialog(
      title: "Select Image From",
      middleText: "",
      cancel: ElevatedButton(onPressed: (){
        getImage(ImageSource.camera);
      }, child: const Text("Camera")),
      confirm:  ElevatedButton(onPressed: (){
        getImage(ImageSource.gallery);
        Get.back();
      }, child: const Text("Gallery"))

  );
}

Future getImage(ImageSource source) async{
    ImagePicker imagePicker = ImagePicker();

  var pickedFile = await imagePicker.pickImage(source:source );
  if(pickedFile != null){
    imageFile = File(pickedFile.path);
  }
  if(imageFile != null){
    isLoading = true;
  }
  uploadImageFile();
  update();

}

getMessages() {
  if (FirebaseAuth.instance.currentUser!.uid.hashCode <= args[0].hashCode) {
    groupChatId = '${FirebaseAuth.instance.currentUser!.uid}-${args[0]}';
  } else {
    groupChatId = '${args[0]}-${FirebaseAuth.instance.currentUser!.uid}';
  }
   services.getChatMessage(groupChatId!,100);
}

void uploadImageFile() async{
    // ignore: prefer_interpolation_to_compose_strings

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var uploadTask = services.uploadImageFile(imageFile!, fileName);
    try{
     TaskSnapshot snapshot = await uploadTask;
     imageUrl = await snapshot.ref.getDownloadURL();
     isLoading = false;
     onSendMessage(imageUrl!,"image");
     update();
    }on FirebaseException catch(e){
      isLoading = false;
      Get.snackbar("Alert!", e.message??e.toString());
      update();
    }
}

// Future<void> showNotification(message)  async {
//
//     var user= FirebaseFirestore.instance.collection('users').doc(args[0]).snapshots().listen((docSnapshot) {
//       if (docSnapshot.exists) {
//         Map<String, dynamic> data = docSnapshot.data()!;
//         // You can then retrieve the value from the Map like this:
//        name = data['name'];
//        update();
//       }
//     });
//     flutterLocalNotificationsPlugin.show(
//        0,
//         name,
//         message,
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 "0",
//                 "name",
//                 importance: Importance.high,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher'
//             )
//         )
//     );
// }

@override
  void dispose() {

    super.dispose();
    textController.dispose();
  }

}







