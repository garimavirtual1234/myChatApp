
import 'dart:convert';
import 'dart:io';

import 'package:chat_bot_demo/module/chat_room/model/message_model.dart';
import 'package:chat_bot_demo/module/utils/application_utils.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';




class FirebaseServices {
  Future userAuthentication(String email, String password) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        print("invalid");
        return null;
      }
    } on FirebaseAuthException catch (e){
      Get.snackbar("Fail", "Wrong Email or Password",
      colorText: Colors.white
      );
    }
    catch (e) {
      throw Exception(e);
    }
  }


  Future updateUserProfile(image,email,name,phone) async{
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    try{
      var updateUserProfile = await FirebaseFirestore.instance.collection('users').doc(currentUser).set({
        "id":currentUser,
        'image':image,
        'email':email,
        'name':name,
        'phone':phone,
      });

      return updateUserProfile;
    }catch(e){
      throw Exception(e);
    }

  }




  getUserData() async{
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var user = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // var list = json.decode(jsonEncode(user));
    // var response = list.map((e) => UserModel.fromJson(e)).toList();
     return user;

  }

//upload image to firebase Storage
UploadTask uploadImageFile(File image,String filename){
   Reference reference = FirebaseStorage.instance.ref().child(filename);
   UploadTask uploadTask = reference.putFile(image);
   return uploadTask;
}

UploadTask uploadVideoFile(File video,String videoName){
    Reference reference = FirebaseStorage.instance.ref().child(videoName);
    UploadTask uploadTask = reference.putFile(video);
    return uploadTask;
}


//To update the Firestore database information regarding user IDs who will be chatting with each other:
Future<void> updateFirestoreData(
    String collectionPath, String docPath, Map<String,dynamic> dataUpdate){
   return FirebaseFirestore.instance.
   collection(collectionPath).
   doc(docPath).
   update(dataUpdate);
}


//get Stream of Chat Messages while user chat with each other
  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit){
    print("getMessage-$groupChatId");
   var currentUserId = FirebaseAuth.instance.currentUser!.uid;
   print(currentUserId);
   var messages = FirebaseFirestore.instance.collection('chats').doc(groupChatId).collection("messages").orderBy('timestamp',descending: true).limit(limit).snapshots();
   return messages;
  }


  //send messages to other users
  void sendChatMessage(
      String content,
     String type,
      String groupChatId,
      String currentUserId,
      String peerId){
    var currentUserId= FirebaseAuth.instance.currentUser!.uid;
    print("sendMessage-$groupChatId");
    print("ccc-$currentUserId");
   DocumentReference documentReference =
  // FirebaseFirestore.instance.collection('messages').
 //  doc("groupChatId").collection("groupChatId").doc(DateTime.now().millisecondsSinceEpoch.toString());
   FirebaseFirestore.instance.collection("chats").doc(groupChatId).collection("messages").doc();
   ChatMessages chatMessages = ChatMessages(
       idFrom: FirebaseAuth.instance.currentUser!.uid,
       idTo: peerId,
       timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
       content: content,
       type: type);

   FirebaseFirestore.instance.runTransaction((transaction) async {
     transaction.set(documentReference, chatMessages.toJson());
   });
  }


  Future logOut() async{
    try{
      await FirebaseAuth.instance.signOut();

    }catch(e){
      throw Exception(e);
    }
  }

getCurrentUserProfile()async{
  String currentUser = FirebaseAuth.instance.currentUser?.uid??'';
  var user = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: currentUser).get();
  return user;
}

}