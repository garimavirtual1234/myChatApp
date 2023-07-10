
import 'package:flutter/material.dart';


import 'firebase_services.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey=GlobalKey<FormState>();
  final TextEditingController _name= TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    focusColor: Colors.yellow,
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Name",
                  ),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10,bottom: 20),
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
                  FirebaseServices().createUser
                    (_name.text, _email.text, _password.text,context).
                  then((value) =>  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>const MyHomePage())));
                }
              }, child:
              const Text("Create Account"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text("If you have account then"),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement
                            (MaterialPageRoute(builder: (context)=> const LoginScreen()));
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
    );
  }
}


