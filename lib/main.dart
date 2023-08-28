
import 'package:chat_bot_demo/module/auth/view/login_screen.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'ChatGPT APP',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      getPages: AppRoute.routes,
    );
  }
}