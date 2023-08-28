import 'package:chat_bot_demo/module/auth/controller/login_controller.dart';
import 'package:chat_bot_demo/module/auth/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller){
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top:200,bottom: 20),
                      child: TextFormField(
                          controller: controller.email,
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
                        controller:controller.password,
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
                      if(controller.formKey.currentState!.validate()){
                        controller.login();
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
                                Get.offAll(const RegisterScreen());
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
      },
    );
  }
}