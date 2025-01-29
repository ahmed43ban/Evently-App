import 'package:flutter/material.dart';

import 'color-manger.dart';

class AppStyle {
  static ThemeData lightTheme =ThemeData(
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Colors.white
      ),
        titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: ColorManger.lightPrimary
        ),
      titleSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: ColorManger.lightSecondary
      )
    ),
    fontFamily: "Inter",
      scaffoldBackgroundColor: ColorManger.backGround,
      colorScheme: ColorScheme.light(
        primary: ColorManger.lightPrimary,
        secondary: ColorManger.lightSecondary,
        tertiary: ColorManger.lightTeritary,
        onPrimary: ColorManger.darkSecondary
      ),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
      )
  );
  static ThemeData darkTheme=ThemeData(
    textTheme: TextTheme(
        labelLarge: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white
        ),
      titleMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: ColorManger.darkPrimary
      ),
        titleSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: ColorManger.darkSecondary
        )
    ),
      fontFamily: "Inter",
      scaffoldBackgroundColor: ColorManger.backGroundDark,
      colorScheme: ColorScheme.dark(
          primary: ColorManger.darkPrimary,
          secondary: ColorManger.darkSecondary,
          tertiary: ColorManger.darkTeritary,
          onPrimary: ColorManger.lightSecondary
      ),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
      )
  );
}
