import 'package:chat_bot_demo/register_screen.dart';
import 'package:flutter/material.dart';

import 'firebase_services.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:200,bottom: 20),
                  child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        focusColor: Colors.yellow,
                        border: OutlineInputBorder(),
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
                  padding: const EdgeInsets.only(top:10,bottom: 20),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusColor: Colors.yellow,
                      border: OutlineInputBorder(),
                      hintText: "Enter Your Password",
                    ),
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                ),

                ElevatedButton(onPressed: (){
                  if(formKey.currentState!.validate()){
                    FirebaseServices().userAuthentication().then((value) {
                      if(value==null){
                        ScaffoldMessenger.of(context).
                        showSnackBar(
                            const SnackBar(content:
                            Text("Invalid User")));
                      }else{
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>const MyHomePage()));
                      }
                    });
                  }
                }, child:
                const Text("Login"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("If you not have account then create one.."),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context)=> const RegisterScreen())
                            );
                          },
                          child: const Text("CLICK HERE",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}