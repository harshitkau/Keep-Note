import 'package:shared_preferences/shared_preferences.dart';

class DarkTheme {
  static const Theme_status = "ThemeStatus";
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Theme_status, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(Theme_status) ?? false;
  }
}
