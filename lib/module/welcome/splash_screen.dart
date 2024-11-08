


import 'dart:async';


import 'package:chat_bot_demo/module/utils/image_utils.dart';
import 'package:chat_bot_demo/routes/route_class.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../services/shared_prefrences_services.dart';
import '../utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  final SharedPrefrencesServices _prefs = SharedPrefrencesServices();

  @override
  void initState() {
    super.initState();
    autoLogin();
  }


  autoLogin() async {
    String? userDetail = await _prefs.getUserId();
    if (userDetail != '') {
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed(AppRoute.home);
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed(AppRoute.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
             appIcon,
              height: 150,
              width: 150,

            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CircularProgressIndicator(
               color: CustomTheme.lightThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}