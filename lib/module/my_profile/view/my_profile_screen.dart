

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/module/my_profile/controller/my_profile_controller.dart';
import 'package:chat_bot_demo/module/utils/image_utils.dart';
import 'package:chat_bot_demo/module/utils/string_utils.dart';
import 'package:chat_bot_demo/widget/common_button.dart';
import 'package:chat_bot_demo/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/controller/homepage_controller.dart';




class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            color: Colors.yellow,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: const Text(
            updateProfileTitle,
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        backgroundColor: Colors.black,
        body: GetBuilder(
          init: MyProfileController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.yellow),
                            ),
                            child: controller.imageUrl != ''
                                ? Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  controller.imageUrl!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                                : Center(child: Image.asset(userIcon)),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {
                                controller.selectImageSource();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: CommonTextfield(
                              enable: false,
                              controller: controller.email,
                              hint: enterYourEmailHint,
                              validation: (String? value) {}, // No validation for email in profile
                              maxLine: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CommonTextfield(
                              controller: controller.name,
                              hint: enterYourNameHint,
                              validation: (String? value) {
                                if (value!.isEmpty) {
                                  return invalidNameValidation;
                                }
                                return null;
                              },
                              maxLine: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CommonTextfield(
                              inputType: TextInputType.number,
                              controller: controller.phone,
                              hint: enterYourPhoneHint,
                              validation: (String? value) {
                                if (value!.isEmpty) {
                                  return invalidPhoneValidation;
                                }
                                return null;
                              },
                              maxLine: 1,
                            ),
                          ),
                          CommonButton(
                            content: updateButtonText,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateProfile();
                                Get.offAll(() => const MyHomePage());
                                Get.find<HomePageController>().getCurrentUserData();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
