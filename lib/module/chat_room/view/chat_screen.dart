import 'package:chat_bot_demo/module/chat_room/controller/chat_messages_controller.dart';
import 'package:chat_bot_demo/module/chat_room/model/message_model.dart';
import 'package:chat_bot_demo/services/firebase_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                        onPressed: controller.getImage,
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
        title: const Text("Welcome to Chat App"),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
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
                              ? Container(
                        width: MediaQuery.of(context).size.width*0.7,
                                  height: 200,
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                                  child: Image.network(chatMessages.content,
                                  fit: BoxFit.fitWidth,
                                  ))
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
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                              color: Colors.grey,
                              chatContent: chatMessages.content,
                              textColor: Colors.black, timestamp: chatMessages.timestamp,
                            )
                          : chatMessages.type == "image"
                              ? Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 200,
                          margin:
                          const EdgeInsets.only(right: 10, top: 10,bottom: 20),
                          child: Image.network(chatMessages.content,
                            fit: BoxFit.fitWidth,
                          ))
                              : const SizedBox.shrink(),
                    ],
                  ),
                  // controller.isMessageReceived(index)
                  //     ? Container(
                  //         margin: const EdgeInsets.all(10),
                  //         child: Text(chatMessages.timestamp),
                  //       )
                     // : const SizedBox.shrink()
                ],
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
                    stream: FirebaseServices().getChatMessage(controller.groupChatId!, 10),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        controller.listMessages = snapshot.data!.docs;
                        if (controller.listMessages.isNotEmpty) {
                          return ListView.builder(
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
}
