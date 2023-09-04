
import 'package:chat_bot_demo/module/dashboard/controller/homepage_controller.dart';
import 'package:chat_bot_demo/module/my_profile/controller/my_profile_controller.dart';
import 'package:get/get.dart';

class MyProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MyProfileController());
    Get.lazyPut(() => HomePageController());
  }

}