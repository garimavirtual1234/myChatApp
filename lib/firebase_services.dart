
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:chat_bot_demo/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class FirebaseServices {
  Future userAuthentication() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        print(FirebaseAuth.instance.currentUser!.uid ?? "0");
        return FirebaseAuth.instance.currentUser!.uid ?? "0";
      } else {
        print("invalid");
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future createUser(String name, String email, String password, context) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User Exist!")));
      }
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
      FirebaseFirestore.
      instance.collection('users').get();


 getUserData(uid) async{
  var user = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: uid).get();
  var list = json.decode(jsonEncode(user));
  var response = list.map((e) => UserModel.fromJson(e)).toList();
  return response;

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