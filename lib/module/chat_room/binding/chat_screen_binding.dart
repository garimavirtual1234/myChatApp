
import 'package:chat_bot_demo/module/chat_room/controller/chat_messages_controller.dart';
import 'package:get/get.dart';

class ChatScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ChatMessageController());
  }

}