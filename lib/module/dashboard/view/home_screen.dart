
import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:chat_bot_demo/module/auth/view/login_screen.dart';
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
                title:   const Text("Welcome to My ChatApp"),
                actions:  [
                  InkWell(
                      onTap: (){
                       controller.loggingOut();
                      },
                      child: const Text("logout"))
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
                                print("${snapshot.data!.docs[index]}");
                                Get.to(()=>const ChatScreen(),arguments: ["${products["id"]}"]);
                              },
                              leading: const CircleAvatar(
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
                      return const Text("no data present");
                    }
                  }
              ));
        });
  }
}