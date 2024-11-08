
import 'package:chat_bot_demo/module/utils/app_theme.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:chat_bot_demo/services/shared_prefrences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/custom_text.dart';

class ApplicationUtils {

  static showSnackBar(
      {required String? titleText, required String? messageText}) {
    return
      Get.showSnackbar(
          GetSnackBar(
              title: titleText,
              message: messageText,
              duration: const Duration(seconds: 3)));
  }

  static void logout() {
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          backgroundColor: Colors.transparent,
          child: PopScope(
            canPop:  true,
            child: Container(

              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomizedTextWidget(
                      style: TextStyle(color: Colors.black,fontSize: 18,),
                      textValue: "Logout",
                    ),
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomizedTextWidget(
                      textAlign:TextAlign.center,
                      style: TextStyle(color: Colors.grey,
                        fontSize: 15,
                      ),
                      textValue: "Are you sure want to logout?",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: CustomizedTextWidget(
                                                style: TextStyle(color: Colors.white,
                                                  fontSize: 16,),
                                                textValue: "Close")),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            final SharedPrefrencesServices mPrefrence = SharedPrefrencesServices();
                            mPrefrence.clearData();
                            try{
                              Get.offAllNamed(AppRoute.login);


                            }catch(ex){

                              throw Exception(ex);

                            }


                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    shape: BoxShape.rectangle,
                                    color: CustomTheme.lightThemeColor,

                                  ),
                                  child:   Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: CustomizedTextWidget(
                                                style: TextStyle(  color: Colors.white,
                                                  fontSize: 16,),
                                                textValue: "Logout")),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }

}
