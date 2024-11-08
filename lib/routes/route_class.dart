

import 'package:chat_bot_demo/module/auth/binding/authBinding.dart';
import 'package:chat_bot_demo/module/auth/view/login_screen.dart';
import 'package:chat_bot_demo/module/auth/view/register_screen.dart';
import 'package:chat_bot_demo/module/chat_room/binding/chat_screen_binding.dart';
import 'package:chat_bot_demo/module/chat_room/view/chat_screen.dart';
import 'package:chat_bot_demo/module/dashboard/binding/homepage_binding.dart';

import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/module/my_profile/binding/my_profile_binding.dart';
import 'package:chat_bot_demo/module/my_profile/view/my_profile_screen.dart';
import 'package:chat_bot_demo/module/welcome/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute{
  static const splash = '/splash';
  static const String signUp= "/signUp";
  static const String login = "/login";
  static const String home= "/home";
  static const String chatScreen= "/chatScreen";
  static const String myProfile= "/myProfile";


  static List<GetPage> routes = [
    GetPage(name: splash,
        page: () => const SplashScreen(),
    ),
    GetPage(name: login,
        page: () => const LoginScreen(),
      binding: AuthBinding()
    ),
    GetPage(name: signUp,
        page: () => const RegisterScreen(),
        binding: AuthBinding()
    ),
    GetPage(name: home,
        page:()=> const MyHomePage(),
    binding: HomePageBinding()
    ),
    GetPage(name: chatScreen,
        page: ()=> const ChatScreen(),
      binding: ChatScreenBinding()
    ),
    GetPage(
      name: myProfile,
        page: ()=> const MyProfile(),
      binding: MyProfileBinding()
    )

  ];
}