import 'package:chat_bot_demo/module/auth/controller/login_controller.dart';
import 'package:chat_bot_demo/module/auth/view/register_screen.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller){
        return Scaffold(
          backgroundColor: Colors.black,
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
                      child: CommonTextfield(
                        textController: controller.email,
                        hintText: 'Enter Your Email',
                        validator: (String? value){
                          if (value!.isEmpty || !RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                              value)) {
                            return "Enter valid Email";
                          } else {
                            return null;
                          }
                        }, labelText: 'Email',
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 30),
                      child: CommonTextfield(
                        isObscure: true,
                        textController: controller.password,
                        hintText: 'Enter Your Password',
                        validator: (String? value){
                          if(value!.isEmpty){
                            return "Enter password";
                          }
                          return null;
                        }, labelText: 'Password',
                      )
                    ),

CommonButton(content: "Login", onPressed: (){
  if(controller.formKey.currentState!.validate()){
    controller.login();
  }
}),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text("If you not have account then create one..",
                            style: TextStyle(
                              color: Colors.white
                            ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.offAll(const RegisterScreen());
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
          ),
        );
      },
    );
  }
}