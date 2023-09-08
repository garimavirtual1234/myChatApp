


import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
import 'package:chat_bot_demo/module/my_profile/view/my_profile_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../chat_room/view/chat_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageController(),
        builder: (controller){
          return  Scaffold(
              appBar: AppBar(
                title:   Text("Welcome ${controller.user1?.name??''}"),
                actions:  [
                  IconButton(onPressed: (){
                   controller.loggingOut();
                  },
                      icon: const Icon(Icons.logout)
                  ),
                  controller.user1?.imageUrl != ''? InkWell(
                    onTap: (){
                      Get.to(()=>const MyProfile(),arguments: [controller.user1]);
                    },
                    child: Container(
                     margin: const EdgeInsets.all(6),
                      height: 45,
                      width: 45,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                              controller.user1?.imageUrl??"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                  ):
                  IconButton(onPressed: (){
                   Get.to(()=>const MyProfile(),arguments: [controller.user1]);
                  },
                      icon: const Icon(Icons.person)
                  ),
                ],
              ),
              body:

            ListView.builder(
                        itemCount: controller.users.length,
                        itemBuilder: (BuildContext context,int index){
                          //DocumentSnapshot products = snapshot.data!.docs[index];
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: (){
                                //print("${snapshot.data!.docs[index]}");
                                Get.to(()=>const ChatScreen(),arguments: ["${
                                 //   products["id"]}","${products['name']
                                    controller.users[index].id}","${controller.users[index].name}"
                                ]);
                              },
                              leading:
                            //  products["image"]
                               controller.users[index].imageUrl   != ''?
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                    child:
                                        Image.network(
                                            controller.users[index].imageUrl??
                                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                                          //  products['image'],
                                            filterQuality: FilterQuality.high,
                                            fit:BoxFit.fill
                                        ),

                                        ),
                              ):
                              const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                              title: controller.users[index].id != controller.user1?.id?Text(
                                  controller.users[index].name??""
                                  //products['name']
                              ):Text(
                                  "${controller.users[index].name??""} (You)"
                                //products['name']
                              ),
                             subtitle:  Text(controller.users[index].userLastMessage??'',
                             maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                             ),
                              trailing:  Text(controller.users[index].lastMessageTime??'',
                                style: const TextStyle(
                                    color: Colors.black54,
                                  fontSize: 12
                                ),
                              ),

                            ),
                          );
                        },
                      )

          );
        });
  }
}