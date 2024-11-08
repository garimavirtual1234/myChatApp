
import 'dart:io';

import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/model/user_model.dart';


class MyProfileController extends GetxController{
  final formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  File? imageFile;
  String? imageUrl;
  FirebaseServices services = FirebaseServices();
  UserModel?  user1;

  var uploadTask;
  var args= Get.arguments;


  selectImageSource(){
    Get.defaultDialog(
        title: "Select Image From",
        middleText: "",
        cancel: ElevatedButton(onPressed: (){
          getImage(ImageSource.camera);
          Get.back();
        }, child: const Text("Camera")),
        confirm:  ElevatedButton(onPressed: (){
          getImage(ImageSource.gallery);
          Get.back();
        }, child: const Text("Gallery"))

    );
  }

  Future getImage(ImageSource source) async{
    ImagePicker imagePicker = ImagePicker();

    var pickedFile = await imagePicker.pickImage(source:source,
    imageQuality: 100
    );
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      uploadTask = services.uploadImageFile(imageFile!, fileName);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      print(imageUrl);
    }
    update();

  }

  // getCurrentUserData() async {
  //
  //   var user = await services.getUserData(id);
  //   user1=UserModel(
  //       id: user.id,
  //       email: user.data()['email']??'',
  //       name: user.data()['name']??'',
  //       password: user.data()['password']??'',
  //       imageUrl: user.data()['image']??'',
  //       phoneNumber: user.data()['phone']??''
  //   );
  //   update();
  //   print("name-${user1?.name??'null'}");
  //   print(user1?.email??'null');
  //   print("imageUrl-${user1?.imageUrl?? "image"}");
  // }

  updateProfile() async{
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // var uploadTask = services.uploadImageFile(imageFile!, fileName);

  await services.updateUserProfile(imageUrl, email.text, name.text, phone.text).then((value) async {
    Get.snackbar("Success", "Update Data Successfully");
    //getCurrentUserData();
    update();
  });

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    name = TextEditingController();
    name.text = user1?.name??args[0].name;
print(name.text);
    email = TextEditingController();
    email.text= user1?.email??args[0].email;
    phone=TextEditingController();
    phone.text= user1?.phoneNumber??args[0].phoneNumber;
    imageUrl=  user1?.imageUrl??args[0].imageUrl;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
  }
}