import 'package:shared_preferences/shared_preferences.dart';

class ThemePresistance {
  //* Store Theme history

  Future<void> storeTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isDark", isDark);
  }

  //* Load theme
  Future<bool> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isDark") ?? false;
  }
}
