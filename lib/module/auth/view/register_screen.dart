
import 'package:chat_bot_demo/module/auth/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RegisterController(),
        builder: (controller){
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: controller.name,
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
                    controller: controller.password,
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
                  if(controller.registerFormKey.currentState!.validate()){
                    controller.register();
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
                            Get.offAll(const LoginScreen());
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
    });
  }
}


