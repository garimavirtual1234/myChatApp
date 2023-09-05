import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesServices {

  saveUserDetails(value)  async {
  final SharedPreferences prefrences = await SharedPreferences.getInstance();
 var userDetails= prefrences.setString("userDetails", value.toString());
 print("user-$userDetails");
   return userDetails;
  }

  isLoginUser() async{
    final SharedPreferences preferences= await SharedPreferences.getInstance();
    var isLogin = preferences.getString('userDetails');
    print("isLogin-$isLogin");
    return isLogin;
  }
}