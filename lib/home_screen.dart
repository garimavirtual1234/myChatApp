import 'package:chat_bot_demo/chat_screen.dart';
import 'package:chat_bot_demo/firebase_services.dart';
import 'package:chat_bot_demo/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title:  const Text("Welcome To My ChatApp"),
                actions:  [
                  InkWell(
                    onTap: (){
                      FirebaseServices().logOut().then((value) =>
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=> const LoginScreen())
                          ));
                    },
                      child: const Text("logout"))
          ],
        ),
        body:Container(
          padding: const EdgeInsets.all(15),
          child: FutureBuilder(
            future: FirebaseServices().readUsers(),
            builder: (context,snapshot) {
    if(snapshot.hasData){
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (BuildContext context,int index){
    DocumentSnapshot products = snapshot.data!.docs[index];
    return Card(
    child: ListTile(
      onTap: (){
        print("${snapshot.data!.docs[index]}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ChatScreen(
               targetUser: products['id'],
              // chatRoomModel: null,
              // firebaseUser: null,
            )));
      },
    title: Text(products['name']),
    subtitle: const Text("last message"),
    ),
    );
    },
    );
    }else{
      return const Text("no data present");
    }
    }
          )

    ));
  }


}