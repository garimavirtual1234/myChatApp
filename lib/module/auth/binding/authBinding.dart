
import 'package:chat_bot_demo/module/auth/controller/login_controller.dart';
import 'package:chat_bot_demo/module/auth/controller/register_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    
  }

}