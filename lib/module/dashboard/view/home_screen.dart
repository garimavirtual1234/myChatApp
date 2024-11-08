import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../my_profile/view/my_profile_screen.dart';
import '../../utils/image_utils.dart';
import '../../utils/string_utils.dart';
import '../controller/homepage_controller.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomePageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "$welcomeMessage ${controller.user1?.name ?? ''}!!",
              style: const TextStyle(color: Colors.yellow),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  controller.loggingOut();
                },
                icon: const Icon(Icons.logout, color: Colors.yellow),
                tooltip: logoutTooltip,
              ),
              controller.user1?.imageUrl != ''
                  ? InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.myProfile, arguments: [controller.user1]);
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      controller.user1?.imageUrl ?? defaultProfileImageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
                  : IconButton(
                onPressed: () {
                  Get.to(() => const MyProfile(), arguments: [controller.user1]);
                },
                icon: const Icon(Icons.person, color: Colors.yellow),
                tooltip: profileTooltip,
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 100,
                color: const Color.fromRGBO(23, 23, 23, 1),
                child: ListTile(
                  onTap: () {
                    Get.toNamed(AppRoute.chatScreen, arguments: [
                      controller.users[index].id,
                      controller.users[index].name
                    ]);
                  },
                  leading: controller.users[index].imageUrl != ''
                      ? SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        controller.users[index].imageUrl ?? defaultProfileImageUrl,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                      : const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.person),
                  ),
                  title: controller.users[index].id != controller.user1?.id
                      ? Text(
                    controller.users[index].name ?? "",
                    style: const TextStyle(color: Colors.white),
                  )
                      : Text(
                    "${controller.users[index].name ?? ""} $youText",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    controller.users[index].userLastMessage ?? messageNotAvailable,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    controller.users[index].lastMessageTime ?? timeNotAvailable,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
