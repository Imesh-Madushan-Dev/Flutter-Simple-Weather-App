import 'package:flutter/material.dart';
import 'package:weather_api/services/theme_presistance.dart';
import 'package:weather_api/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _laodTheme();
  }
  ThemeData _themeData = ThemeDataModes().lightTheme;

  final ThemePresistance _themePresistance = ThemePresistance();

  // get Theme Data getter
  ThemeData get getThemeData => _themeData;
  //setter theme data
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  //Load theme from shared pref
  Future<void> _laodTheme() async {
    bool isDark = await _themePresistance.loadTheme();
    setThemeData =
        isDark ? ThemeDataModes().darkTheme : ThemeDataModes().lightTheme;
  }

  //toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData =
        isDark ? ThemeDataModes().darkTheme : ThemeDataModes().lightTheme;
    await _themePresistance.storeTheme(isDark);
    notifyListeners();
  }
}
