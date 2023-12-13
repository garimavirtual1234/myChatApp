
import 'dart:io';

import 'package:chat_bot_demo/module/dashboard/binding/homepage_binding.dart';
import 'package:chat_bot_demo/module/dashboard/view/home_screen.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:chat_bot_demo/services/shared_prefrences_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'module/auth/view/login_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
// //Messages are handled by the onBackgroundMessage handler while the app is in the background
// @pragma('vm:entry-point')
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification!.title);
// }

SharedPrefrencesServices prefs = SharedPrefrencesServices.instance;
bool isLogged=false;


Future<void> main() async{
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
   if(kIsWeb){
     await Firebase.initializeApp(
       options: FirebaseOptions(
         apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
         authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '',
         projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
         storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
         messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
         appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
         measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '',
       ),
     );

   }else{

     if(Platform.isAndroid){

       await Firebase.initializeApp();

     }else{

       await Firebase.initializeApp();

     }


   }

  await SharedPrefrencesServices.instance.init();
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
  autologin() {
   String? user = prefs.isLoginUser().toString();
    print('user-$user');
    if(user == ''){
        isLogged=true;
      print("kkk");
    }else{
      isLogged=false;
      print("null");
    }
  }
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
  autologin();
 print(isLogged.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      initialBinding: HomePageBinding(),
      title: 'ChatGPT APP',
      debugShowCheckedModeBanner: false,
      home: isLogged ?const LoginScreen(): const MyHomePage(),
      getPages: AppRoute.routes,
    );
  }
}