import 'package:chat_bot_demo/module/auth/controller/login_controller.dart';
import 'package:chat_bot_demo/module/auth/view/register_screen.dart';
import 'package:chat_bot_demo/module/utils/image_utils.dart';
import 'package:chat_bot_demo/module/utils/string_utils.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Obx(
          () => Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login icon at the top
                  const Image(image: AssetImage(loginIcon))
                      .paddingOnly(top: 140, bottom: 30),
                  // Email field
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: CommonTextfield(
                      controller: controller.email,
                      hint: enterYourEmailHint,
                      validation: (String? value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return enterYourEmailValidation;
                        }
                        return null;
                      },
                      maxLine: 1,
                    ),
                  ),
                  // Password field
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: CommonTextfield(
                      isSecureField: true,
                      controller: controller.password,
                      hint: enterYourPasswordHint,
                      validation: (String? value) {
                        if (value!.isEmpty) {
                          return enterYourPasswordValidation;
                        }
                        return null;
                      },
                      maxLine: 1,
                    ),
                  ),
                  // Login button or loading indicator
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : CommonButton(
                    content: loginButtonText,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.signIn();
                      }
                    },
                  ),
                  // "Create Account" prompt
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            noAccountText,
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(AppRoute.signUp);
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
