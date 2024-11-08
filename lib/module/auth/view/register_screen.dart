
import 'package:chat_bot_demo/module/auth/controller/register_controller.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/string_utils.dart';
import 'login_screen.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerFormKey=GlobalKey<FormState>();
    return
      Obx(()=> Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key:registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CommonTextfield(
                  controller: controller.name,
                    hint: enterYourNameHint,
                    validation: (String? value) {
                      if (value!.isEmpty) {
                        return enterYourNameValidation;
                      }
                      return null;
                    }, maxLine: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: CommonTextfield(
                    controller: controller.email,
                    hint: enterYourEmailHint,
                    validation: (String? value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return enterYourEmailValidation;
                      } else {
                        return null;
                      }
                    }, maxLine: 1,
                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: CommonTextfield(
                    isSecureField: true,
                    controller: controller.password,
                    hint: enterYourPasswordHint,
                    validation: (String? value) {
                      if (value!.isEmpty) {
                        return enterPasswordValidation;
                      }
                      return null;
                    }, maxLine: 1,
                 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: CommonTextfield(
                  isSecureField: true,
                   controller: controller.confirmPassword,
                    hint: confirmPasswordHint,
                    validation: (String? value) {
                      if (value != controller.password.text) {
                        return passwordMismatchError;
                      }
                      return null;
                    }, maxLine: 1, 
                  
                  ),
                ),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                  color: Colors.yellow,
                )
                    : CommonButton(
                  content: createAccountButton,
                  onPressed: () {
                    if (registerFormKey.currentState!.validate()) {
                      controller.createUser();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          alreadyHaveAccount,
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed(AppRoute.login);
                          },
                          child: const Text(
                            clickHereText,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    ));

  }
}


