
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesServices {

  setUserId(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString("userId", userId);
    return isSaved;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    return userId ?? "";
  }


  Future<bool> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }

}