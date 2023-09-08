
import 'dart:io';
import 'package:chat_bot_demo/main.dart';
import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
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
 String? videoUrl;
 List<File> selectedImages = [];
  var args= Get.arguments;
String currentUser = FirebaseAuth.instance.currentUser!.uid;
String? groupChatId;
File? videoFile;
  String? name;
  ImagePicker imagePicker = ImagePicker();

  @override
  void onInit() {

    super.onInit();
    textController=TextEditingController();

  }


void onSendMessage(String content,String type){
    var uid= Get.find<HomePageController>().user1?.id??'0';
    var name = Get.find<HomePageController>().user1?.name??"user";
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

   //   showNotification(content,uid,name);
    }else{
      Get.snackbar("Alert!", "Nothing to send");
    }
    update();
}



Future getVideo(ImageSource source) async{
   var pickedFile = await imagePicker.pickVideo(source: source);
     if(pickedFile != null){
       videoFile = File(pickedFile.path);
     }
    uploadVideoFile(videoFile);
     update();
}


Future getImage(ImageSource source) async{

    if(source==ImageSource.gallery){
      var pickedFile = await imagePicker.pickMultiImage(
          imageQuality: 100
      );
      if(pickedFile.isNotEmpty){
        for(var i =0;i<pickedFile.length;i++){
          selectedImages.add(File(pickedFile[i].path));
         uploadImageFile(File(pickedFile[i].path));
        }
      }
    }else{
      var pickedFile = await imagePicker.pickImage(source:source,
      imageQuality: 100
      );
      if(pickedFile != null){
        imageFile = File(pickedFile.path);
        uploadImageFile(imageFile);
      }
      if(imageFile != null){
        isLoading = true;
      }
    }


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

void uploadImageFile(image) async{
    // ignore: prefer_interpolation_to_compose_strings

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var uploadTask = services.uploadImageFile(image!, fileName);
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

void uploadVideoFile(video) async{
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var uploadTask= services.uploadVideoFile(video!,fileName );
    try{
      TaskSnapshot snapshot = await uploadTask;
      videoUrl = await snapshot.ref.getDownloadURL();
      onSendMessage(videoUrl!, "video");
      update();
    }catch(e){
      throw Exception(e);
    }
}

Future<void> showNotification(message,uid,name)  async {

    flutterLocalNotificationsPlugin.show(
     0,
        name,
        message,
    NotificationDetails(
            android: AndroidNotificationDetails(
               uid,
                name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'
            )
        )
    );
    update();
}

@override
  void dispose() {

    super.dispose();
    textController.dispose();
  }

}







