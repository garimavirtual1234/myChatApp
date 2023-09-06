

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/module/my_profile/controller/my_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/controller/homepage_controller.dart';


class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
     return SafeArea(

        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Update Profile"),
          ),
         backgroundColor: Colors.white,
         body: GetBuilder(
           init: MyProfileController(),
           builder: (controller) {
             return SingleChildScrollView(
               child: Container(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     const SizedBox(
                       height: 20,
                     ),
                     Center(
                       child: Stack(
                         children: [

                           Container(
                             height: 100,
                             width: 100,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                               border: Border.all(color: Colors.grey)
                             ),
                             child: controller.imageUrl != ''? Center(
                            child:   ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(controller.imageUrl!,
                              height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                             ):Center(
                                 child: Image.asset("assets/images/User_icon_2.svg.png"))
                           ),
                           Positioned(
                               right:0,
                               bottom: 0,
                               child: IconButton(
                                 onPressed: (){
                                  controller.selectImageSource();
                                 },
                                 icon: const Icon(Icons.camera_alt,
                                 color: Colors.white,
                                 ),
                               )),
                         ],
                       ),
                     ),
                     Form(
                      key:controller.formKey,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                       Padding(
                       padding: const EdgeInsets.only(top:30,bottom: 20),
                       child: TextFormField(
                         enabled: false,
                           controller: controller.email,
                           decoration: const InputDecoration(
                             label: Text("Email"),
                             focusColor: Colors.yellow,
                             border: OutlineInputBorder(
                             ),
                             hintText: "Enter your Email Id",
                           ),
                           validator: (String? value){
                             if (value!.isEmpty || !RegExp(
                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                                 value)) {
                               return "Enter valid Email";
                             } else {
                               return null;
                             }
                           }
                       ),
                     ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20),
                             child: TextFormField(
                               controller: controller.name,
                               decoration: const InputDecoration(
                                 label: Text("Name"),
                                 focusColor: Colors.yellow,
                                 border: OutlineInputBorder(),
                                 hintText: "Enter Your Name",
                               ),
                               validator: (String? value){
                                 if(value!.isEmpty){
                                   return "Enter your name";
                                 }
                                 return null;
                               },
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20),
                             child: TextFormField(
                               controller: controller.phone,
                               keyboardType: TextInputType.number,
                               decoration: const InputDecoration(
                                 label: Text("Phone"),
                                 focusColor: Colors.yellow,
                                 border: OutlineInputBorder(),
                                 hintText: "Enter Your Phone Number",
                               ),
                               validator: (String? value){
                                 if(value!.isEmpty){
                                   return "Enter your valid phone number";
                                 }
                                 return null;
                               },
                             ),
                           ),
                           Center(
                             child: ElevatedButton(onPressed: (){
                               if(controller.formKey.currentState!.validate()){
                                 controller.updateProfile();
                                 Get.offAll(()=>const MyHomePage());
                                 Get.find<HomePageController>().getCurrentUserData();
                               }
                             }, child:
                             const Text("Update"),
                             ),
                           ),
                         ],
                       ),
                     )

                   ],
                 ),
               ),
             );
           }
         ),
    ),
     );
  }
}
