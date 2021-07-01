import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPrefUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPrefUserNameKey = "USERNAMEKEY";
  static String sharedPrefEmailKey = "EMAILKEY";

  // saving data to shared preferences
  static Future<bool> saveUserLoggedInToSharedPref(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefUserLoggedInKey, true);
  }

  static Future<bool> saveUserNameToSharedPref(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserNameKey, username);
  }

  static Future<bool> saveEmailToSharedPref(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserLoggedInKey, email);
  }

  //getting data from shared preferences

  static Future<bool?> getUserLoggedFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefUserLoggedInKey);
  }

  static Future<String?> getUserNameFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefUserNameKey);
  }

  static Future<String?> getEmailFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefEmailKey);
  }
}
