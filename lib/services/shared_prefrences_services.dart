
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesServices {
  SharedPreferences? _prefs;

  SharedPrefrencesServices._privateConstructor();

  static final SharedPrefrencesServices instance = SharedPrefrencesServices._privateConstructor();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> saveUserDetails(String value)  async {
    _prefs = await SharedPreferences.getInstance();
    print("user2-$value");
 bool? userDetails= await _prefs!.setString("userDetails", value) ;
 print("user2-$userDetails");
   return userDetails;
  }

String? isLoginUser()  {
try{
  String? isLogin =  _prefs!.getString('userDetails');
  print("isLogin-$isLogin");
  return isLogin??"";
}catch(e){
  throw Exception(e);
}}

  Future<bool?> setFcmToken(String value) async{
    bool? fcmToken= await _prefs!.setString("fcmToken",value);
    return fcmToken;
  }

  String? getFcmToken(){
    String? getToken=_prefs!.getString("fcmToken");
    print(getToken);
    return getToken;
  }

  Future<bool> clearData() async{
    await _prefs!.clear();
    return true;
  }

}