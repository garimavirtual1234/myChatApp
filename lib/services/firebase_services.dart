
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';

import 'package:chat_bot_demo/module/chat_room/model/message_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../module/dashboard/model/user.dart';

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
    } catch (e) {
      throw Exception(e);
    }
  }

  Future createUser(String name, String email, String password) async {
    try {

      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);
      var currentUserId = FirebaseAuth.instance.currentUser!.uid ?? '0';
      print(user);
      if (user != null) {
        await FirebaseFirestore.instance.collection('users')
            .doc(currentUserId)
            .set(
            {
          "id":currentUserId,
          "name": name, "email": email, "password": password
        }
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Fail!','User  Exist');
      }
    }
    catch (e) {
      throw Exception(e);
    }
  }



 getUserData() async{
    var uid = FirebaseAuth.instance.currentUser!.uid;
  var user = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: uid).get();
  var list = json.decode(jsonEncode(user));
  var response = list.map((e) => UserModel.fromJson(e)).toList();
  return response;

}

//upload image to firebase Storage
UploadTask uploadImageFile(File image,String filename){
   Reference reference = FirebaseStorage.instance.ref().child(filename);
   UploadTask uploadTask = reference.putFile(image);
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
  Stream<QuerySnapshot> getChatMessage( int limit){
   var currentUserId = FirebaseAuth.instance.currentUser!.uid;
   print(currentUserId);
   var messages=FirebaseFirestore.instance.
   collection('chats').doc(currentUserId).
   collection("messages").
   orderBy('timestamp',descending: true)
       .limit(limit).snapshots();
   print("messges-${messages.length}");
   return messages;
  }


  //send messages to other users
  void sendChatMessage(
      String content,
     String type,
      String currentUserId,
      String peerId){
    var currentUserId= FirebaseAuth.instance.currentUser!.uid;
    print("ccc-$currentUserId");
   DocumentReference documentReference =
  // FirebaseFirestore.instance.collection('messages').
 //  doc("groupChatId").collection("groupChatId").doc(DateTime.now().millisecondsSinceEpoch.toString());
   FirebaseFirestore.instance.collection("chats").doc(FirebaseAuth.instance.currentUser!.uid).collection("messages").doc();
   ChatMessages chatMessages = ChatMessages(
       idFrom: FirebaseAuth.instance.currentUser!.uid,
       idTo: peerId,
       timestamp: DateTime.now().toString(),
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