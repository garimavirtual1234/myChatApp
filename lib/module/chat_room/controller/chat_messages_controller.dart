
import 'dart:io';

import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textController=TextEditingController();

  }

  //checking if sent message
  bool isMessageSent(int index){
    print("ppp"+listMessages[index]);
    if((index > 0 && listMessages[index-1].get('idFrom') != FirebaseAuth.instance.currentUser!.uid)|| index == 0){
      return true;
    }else{
      return false;
    }
  }

  //checking if received message
bool isMessageReceived(int index){
    print(listMessages[index]);
    if((index>0 && listMessages[index-1].get('idFrom') == FirebaseAuth.instance.currentUser!.uid) || index == 0){
      return true;
    }
    else {
        return false;
      }
}

void onSendMessage(String content,String type){
    if(content.trim().isNotEmpty){
      textController.clear();
      services.sendChatMessage(
         content, type,
        //  FirebaseFirestore.instance.collection('chats').
          // doc(FirebaseAuth.instance.currentUser!.uid).collection("messages").id,
           FirebaseAuth.instance.currentUser!.uid.toString(),
         args[0]
      );
    }else{
      Get.snackbar("Alert!", "Nothing to send");
    }
    update();
}

Future getImage() async{
    ImagePicker imagePicker = ImagePicker();

  var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
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
   services.getChatMessage(10);
}

void uploadImageFile() async{
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
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

}







