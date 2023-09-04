
import 'dart:io';

import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
import 'package:chat_bot_demo/module/my_profile/view/my_profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
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
                              controller.user1?.imageUrl??"https://commons.wikimedia.org/wiki/File:Sample_User_Icon.png",
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
              body:FutureBuilder(
                  future: controller.readUsers(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context,int index){
                          DocumentSnapshot products = snapshot.data!.docs[index];
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: (){
                                //print("${snapshot.data!.docs[index]}");
                                Get.to(()=>const ChatScreen(),arguments: ["${products["id"]}","${products['name']}"]);
                              },
                              leading: products["image"] != ''?
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                    child:
                                        Image.network(products['image'],
                                            fit:BoxFit.fill
                                        ),

                                        ),
                              ):
                              const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                              title: Text(products['name']),
                             // subtitle: const Text("last message"),
                             //  trailing: const Text("12:30 P.M",
                             //    style: TextStyle(
                             //        color: Colors.black54
                             //    ),
                             //  ),
                            ),
                          );
                        },
                      );
                    }else{
                      return const Center(child: Text("no data present"));
                    }
                  }
              ));
        });
  }
}