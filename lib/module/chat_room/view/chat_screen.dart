import 'package:chat_bot_demo/module/chat_room/controller/chat_messages_controller.dart';
import 'package:chat_bot_demo/module/chat_room/model/message_model.dart';

import 'package:chat_bot_demo/services/firebase_services.dart';
import 'package:chewie/chewie.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';


import '../../../widget/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Widget _buildChatBox() {
    return Row(
      children: [
        GetBuilder(
            init: ChatMessageController(),
            builder: (controller) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: openDialog,
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: openDialogForVideo,
                        icon: const Icon(
                          Icons.video_camera_front_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)
                            )
                          ),

                          cursorColor: Colors.yellow,
                      textInputAction: TextInputAction.send,
                      controller: controller.textController,
                      style:const TextStyle(
              color:Colors.white
              ),
                      onSubmitted: (value) {
                        controller.onSendMessage(
                            controller.textController.text, "text");
                      },
                    )),
                    IconButton(
                      onPressed: () {
                        controller.onSendMessage(
                            controller.textController.text, "text");
                      },
                      icon: const Icon(Icons.send_rounded,
                      color: Colors.white,
                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        // Get.lazyPut<HomePageController>(()=>HomePageController());
        // Get.find<HomePageController>().users.removeRange(0, Get.find<HomePageController>().users.length );
        // Get.find<HomePageController>().fetch();
        Get.back();
      return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.yellow, onPressed: () { Get.back(); },
          ),
          backgroundColor: Colors.black,
          title:GetBuilder(
            init: ChatMessageController(),
            builder: (controller) {
              return  Text(controller.args[1]??"",style: const TextStyle(
                color: Colors.yellow
              ),);
            }
          ),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [buildListMessage(), _buildChatBox()],
            ),
          ),
        ),
      ),
    );
  }

  //chat bubbles
  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    return GetBuilder(
        init: ChatMessageController(),
        builder: (controller) {
          if (documentSnapshot != null) {
            ChatMessages chatMessages =
                ChatMessages.fromDocument(documentSnapshot);
            if (chatMessages.idFrom == FirebaseAuth.instance.currentUser!.uid) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  chatMessages.type == "text"
                      ? MessageBubble(
                          chatContent: chatMessages.content,
                          color: Colors.yellow,
                          textColor: Colors.black, timestamp:chatMessages.timestamp ,
                        )
                      : chatMessages.type == "video"?
                  Container(
                      margin:  const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                      height: 300,
                      width: 300,
                      child: Chewie(
                          controller: ChewieController(
                            videoPlayerController:  VideoPlayerController.networkUrl(
                              Uri.parse(chatMessages.content),
                            ),
                            aspectRatio: 5 / 8,
                            autoInitialize: true,
                            autoPlay: false,
                            looping: true,
                            errorBuilder: (context, errorMessage) {
                              return Center(
                                child: Text(
                                  errorMessage,
                                  style: const TextStyle(color: Colors.white,

                                  ),
                                ),
                              );
                            },
                          )
                      )

                  )
                      :chatMessages.type == "image"
                          ? Stack(
                            children: [
                              Container(
                    width: MediaQuery.of(context).size.width*0.7,
                                  height: 200,
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                                  child: Image.network(chatMessages.content,
                                  fit: BoxFit.contain,
                                  )),
                            Positioned(
                              right: 20,
                               bottom: 30,
                               child: Text( DateFormat('hh:mm a').format(
                                 DateTime.fromMillisecondsSinceEpoch(
                                   int.parse(chatMessages.timestamp),
                                 ),),
                                 style: const TextStyle(
                                     color:Colors.black,
                                   fontSize: 10,
                                   fontWeight: FontWeight.bold
                                 ),
                               ),
                             ),

                            ],
                          )
                          : const SizedBox.shrink(),
                ],
              );
            } else {
              return SizedBox(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    chatMessages.type == "text"
                        ? MessageBubble(
                            color: Colors.grey.shade300,
                            chatContent: chatMessages.content,
                            textColor: Colors.black, timestamp: chatMessages.timestamp,
                          )
                        : chatMessages.type == "video"?  Container(
                      height: 300,
                    width: 300,
                    margin:  const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                           child: Chewie(
                               controller: ChewieController(
                             videoPlayerController:  VideoPlayerController.networkUrl(
                               Uri.parse(chatMessages.content),
                             ),
                             aspectRatio: 5 / 8,
                             autoInitialize: true,
                             autoPlay: false,
                             looping: true,
                             errorBuilder: (context, errorMessage) {
                               return Center(
                                 child: Text(
                                   errorMessage,
                                   style: const TextStyle(color: Colors.white),
                                 ),
                               );
                             },
                           )
                           )

                        ):chatMessages.type == "image"
                            ? Stack(
                              children: [
                                Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: 200,
                        margin:
                        const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                        child: Image.network(chatMessages.content,
                          fit: BoxFit.contain,
                        )),
                                Positioned(
                                  right: 20,
                                  bottom: 30,
                                  child: Text( DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(chatMessages.timestamp),
                                    ),),
                                    style: const TextStyle(
                                        color:Colors.white,
                                        fontSize: 10
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : const SizedBox.shrink(),
                  ],
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget buildListMessage() {

    return GetBuilder(
      init: ChatMessageController(),
      builder: (controller) {
        if (FirebaseAuth.instance.currentUser!.uid.hashCode <= controller.args[0].hashCode) {
          print("hascode-${FirebaseAuth.instance.currentUser!.uid.hashCode}");
          controller.groupChatId = '${FirebaseAuth.instance.currentUser!.uid}-${controller.args[0]}';
        } else {
          print("hascode-${FirebaseAuth.instance.currentUser!.uid.hashCode}");
          controller.groupChatId = '${controller.args[0]}-${FirebaseAuth.instance.currentUser!.uid}';
        }
        return Expanded(
            child:
           // controller.groupChatId != null?
            // FirebaseFirestore.instance
            //         .collection('chats')
            //         .doc(controller.currentUser)
            //         .collection("messages")
            //         .id
            //         .isNotEmpty
            //     ?
                // FirebaseFirestore.instance.collection('messages').
                // doc("groupChatId")
                //     .id.isNotEmpty?
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices().getChatMessage(controller.groupChatId!, 100),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        controller.listMessages = snapshot.data!.docs;
                        if (controller.listMessages.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              itemCount: snapshot.data?.docs.length,
                              reverse: true,
                              itemBuilder: (context, index) =>
                                buildItem(index, snapshot.data?.docs[index]));
                        } else {
                          return const Center(child: Text("No Messages..."));
                        }
                      } else {
                         return const Center(
                             child: SizedBox(
                                 height: 20,
                                 width: 20,
                                 child: CircularProgressIndicator()));
                      }
                    }));
                // : const Center(
                //     child: Text("Start messages"),
                //   ));
      },
    );
  }
  openDialog() {
    Get.dialog(
      GetBuilder(
        init: ChatMessageController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Select Image From",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed:(){
                                controller.getImage(ImageSource.camera);
                                Get.back();
                              }, child: const Text("Camera")),
                              const SizedBox(width: 10),
                            ElevatedButton(onPressed: (){
          controller.getImage(ImageSource.gallery);
          Get.back();
          }, child: const Text("Gallery"))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  openDialogForVideo() {
    Get.dialog(
      GetBuilder(
          init: ChatMessageController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Material(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Select Video From",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed:(){
                                  controller.getVideo(ImageSource.camera);
                                  Get.back();
                                }, child: const Text("Camera")),
                                const SizedBox(width: 10),
                                ElevatedButton(onPressed: (){
                                  controller.getVideo(ImageSource.gallery);
                                  Get.back();
                                }, child: const Text("Gallery"))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
