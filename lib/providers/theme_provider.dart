import 'package:evently/core/prefshelper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  initTheme() {
    bool isDark = PrefHelper.getTheme();
    if (isDark == true) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
  }

  changeTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    if (currentTheme == ThemeMode.dark) {
      PrefHelper.setTheme(true);
    } else {
      PrefHelper.setTheme(false);
    }
    notifyListeners();
  }
}
