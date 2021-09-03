import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/utils/sharedprefs_keys.dart';

class MemoryManagement {
  static late SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String? getuserlist() {
    return prefs.getString(SharedPrefsKeys.USERLIST);
  }

  static void setuserlist({@required String? userlist}) {
    prefs.setString(SharedPrefsKeys.USERLIST, userlist!);
  }

  //clear all values from shared preferences
  static void clearMemory() {
    prefs.clear();
  }
}
