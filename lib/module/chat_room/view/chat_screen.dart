import 'package:chat_bot_demo/module/chat_room/controller/chat_messages_controller.dart';
import 'package:chat_bot_demo/module/chat_room/model/message_model.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


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
                        ),
                      ),
                    ),
                    Flexible(
                        child: TextField(
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.text,
                      controller: controller.textController,
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
                      icon: const Icon(Icons.send_rounded),
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
    return Scaffold(
      appBar: AppBar(
        title:GetBuilder(
          init: ChatMessageController(),
          builder: (controller) {
            return  Text(controller.args[1]??"");
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
                          color: Colors.blue,
                          textColor: Colors.white, timestamp:chatMessages.timestamp ,
                        )
                      : chatMessages.type == "image"
                          ? Stack(
                            children: [
                              Container(
                    width: MediaQuery.of(context).size.width*0.7,
                                  height: 200,
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                                  child: Image.network(chatMessages.content,
                                  fit: BoxFit.fitWidth,
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
                  // controller.isMessageSent(index)
                  //     ? Container(
                  //         clipBehavior: Clip.hardEdge,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20)),
                  //         child: const Icon(Icons.person))
                  //     : Container(
                  //         width: 35,
                  //       ),
                  // controller.isMessageSent(index)
                  //     ? Icon(Icons.ti)
                  //     : const SizedBox.shrink()
                ],
              );
            } else {
              return SizedBox(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // controller.isMessageReceived(index)
                    //     ? Container(
                    //         clipBehavior: Clip.hardEdge,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: const Icon(Icons.person_2_outlined),
                    //       )
                    //     : Container(
                    //         width: 35,
                    //       ),
                    chatMessages.type == "text"
                        ? MessageBubble(
                            color: Colors.grey.shade300,
                            chatContent: chatMessages.content,
                            textColor: Colors.black, timestamp: chatMessages.timestamp,
                          )
                        : chatMessages.type == "image"
                            ? Stack(
                              children: [
                                Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: 200,
                        margin:
                        const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                        child: Image.network(chatMessages.content,
                          fit: BoxFit.fitWidth,
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
}
