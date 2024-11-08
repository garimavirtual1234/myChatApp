

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? imageUrl;
  String? phoneNumber;
  String? password;
  String? userLastMessage;
  String? lastMessageTime;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.imageUrl,
    this.phoneNumber,
    this.password,
    this.userLastMessage,
    this.lastMessageTime,
  });

  // Factory constructor to create a UserModel instance from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      password: map['password'] ?? '',
      userLastMessage: map['userLastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'] ?? '',
    );
  }

  // Factory constructor to create a UserModel instance from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      password: data['password'] ?? '',
      userLastMessage: data['userLastMessage'] ?? '',
      lastMessageTime: data['lastMessageTime'] ?? '',
    );
  }

  // Method to convert UserModel instance to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'password': password,
      'userLastMessage': userLastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }
}
