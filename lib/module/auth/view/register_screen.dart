
import 'package:chat_bot_demo/module/auth/controller/register_controller.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
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
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CommonTextfield(
                    textController: controller.name,
                    hintText: 'Enter Your Name',
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Enter your name";
                      }
                      return null;
                    }, labelText: 'Name',)
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,bottom: 20),
                  child: CommonTextfield(
                    textController:controller.email,
                    hintText: 'Enter Your Email',
                    validator: (String? value){
                      if (value!.isEmpty || !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                          value)) {
                        return "Enter valid Email";
                      } else {
                        return null;
                      }
                    }, labelText: 'Email',)
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,bottom: 20),
                  child: CommonTextfield(
                    isObscure: true,
                      textController: controller.password,
                      hintText: "Enter Your Password",
                      validator:  (String? value){
                if(value!.isEmpty){
                return "Enter password";
                }
                return null;
                }, labelText: 'Password',
                  )
                ),
                Padding(
                    padding: const EdgeInsets.only(top:10,bottom: 30),
                    child: CommonTextfield(
                      isObscure: true,
                      textController: controller.confirmPassword,
                      hintText: "Confirm Your Password",
                      validator:  (String? value){
                        if(value != controller.password.text){
                          return "Password didn't match";
                        }
                        return null;
                      }, labelText: 'Confirm Password',
                    )
                ),
                CommonButton(
                    content: "Create Account",
                    onPressed: (){
                      if(controller.registerFormKey.currentState!.validate()){
                        controller.register();
                      }
                    }
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("If you have account then ",
                        style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.offAll(const LoginScreen());
                          },
                          child: const Text("CLICK HERE",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.yellow
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


