


import 'package:chat_bot_demo/module/dashboard/binding/homepage_binding.dart';

import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:chat_bot_demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'module/utils/app_theme.dart';


//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
// //Messages are handled by the onBackgroundMessage handler while the app is in the background
// @pragma('vm:entry-point')
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification!.title);
// }


bool isLogged=false;


Future<void> main() async{
  await dotenv.load(fileName: ".env");
   WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);



  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken.toString());
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);


  // NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      initialBinding: HomePageBinding(),
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splash,
      getPages: AppRoute.routes,
    );
  }
}