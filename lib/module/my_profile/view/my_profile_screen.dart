

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/module/my_profile/controller/my_profile_controller.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
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
            backgroundColor: Colors.black,
            leading: IconButton(
              color: Colors.yellow, onPressed: () { Get.back() ;}, icon: const Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            title: const Text("Update Profile",
            style: TextStyle(
              color: Colors.yellow
            ),
            ),
          ),
         backgroundColor: Colors.black,
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
                               border: Border.all(color: Colors.yellow)
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
                       child: CommonTextfield(
                         isEnabled: false,
                         textController:controller.email ,
                         hintText: "Enter your Email Id",
                         validator: (String? value) {  },
                         labelText: "Email",)

                     ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20),
                             child:
                             CommonTextfield(
                               textController: controller.name,
                               hintText: 'Enter Your Name',
                               validator: (String? value){
                                 if(value!.isEmpty){
                                   return "Enter your name";
                                 }
                                 return null;
                               },
                               labelText: 'Name',
                             )

                           ),
                           Padding(
                             padding: const EdgeInsets.only(bottom: 20),
                             child: CommonTextfield(
                               keyboardType: TextInputType.number,
                                 textController: controller.phone,
                                 hintText: "Enter Your Phone Number",
                                 validator: (String? value){
                                   if(value!.isEmpty){
                                     return "Enter your valid phone number";
                                   }
                                   return null;
                                 },
                                 labelText: "Phone"
                             )

                           ),
                           CommonButton(content:"Update", onPressed:  (){
               if(controller.formKey.currentState!.validate()){
               controller.updateProfile();
               Get.offAll(()=>const MyHomePage());
               Get.find<HomePageController>().getCurrentUserData();
               }
               })

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
