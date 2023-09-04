
import 'package:chat_bot_demo/module/auth/view/login_screen.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';



// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
// //Messages are handled by the onBackgroundMessage handler while the app is in the background
// @pragma('vm:entry-point')
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification!.title);
// }

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await  Firebase.initializeApp();

  //FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//  final fcmToken = await FirebaseMessaging.instance.getToken();
//   FirebaseMessaging.instance.onTokenRefresh.listen((event) {
//     print(fcmToken);
//   }).onError((error){
//     print("error to generate fcm token - $error");
//   });

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