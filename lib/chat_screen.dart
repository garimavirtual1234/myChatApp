import 'package:chat_bot_demo/chatRoomModel.dart';
import 'package:chat_bot_demo/firebase_services.dart';
import 'package:chat_bot_demo/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,
required this.targetUser,
    // required this.chatRoomModel,
    // required this.firebaseUser,
   //  required this.userModel
  });
  final String targetUser;
 //  final UserModel userModel;
  // final ChatRoomModel chatRoomModel;
  // final User firebaseUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  final TextEditingController _controller = TextEditingController();


  Widget _buildChatBox() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration.collapsed(
                hintText: "Enter message here"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {

              },
            ),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    var name = FirebaseServices().getUserData(widget.targetUser);
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Welcome to Chat App"),
      ),
        body : SafeArea(
        child: Container(
           padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Flexible(child:
              ListView.builder(
                reverse: true,
                itemBuilder: (context,index){
                  
                },
              )),
             Card(
               color: Colors.grey[300],
                 child: _buildChatBox()),

            ],
          ),
        ),
      ),
    );
  }


}