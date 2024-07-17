import 'package:shared_preferences/shared_preferences.dart';

class Localdb {
  static late SharedPreferences prefs;
  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }
  static const String NAME = "name";
  static const String LOGGEDIN = "loggedIn";
  static const String LIKED = "liked";
  static const String LIKEDDATA = "likeddata";
}