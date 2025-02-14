import 'package:flutter/material.dart';

import 'color-manger.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white,
        labelColor: ColorManger.lightPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManger.lightPrimary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorManger.lightPrimary,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
      textTheme: TextTheme(
          displaySmall: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: ColorManger.backGround),
          bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorManger.lightTextField),
          labelLarge: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: ColorManger.lightPrimary),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorManger.lightSecondary)),
      fontFamily: "Inter",
      scaffoldBackgroundColor: ColorManger.backGround,
      colorScheme: ColorScheme.light(
          outline: Colors.white,
          onTertiaryContainer: ColorManger.lightTextField,
          onSecondaryContainer: ColorManger.lightTextField,
          primary: ColorManger.lightPrimary,
          secondary: ColorManger.lightSecondary,
          tertiary: ColorManger.lightTeritary,
          onPrimary: ColorManger.darkSecondary,
          inversePrimary: Colors.white,
          onPrimaryFixedVariant: ColorManger.lightPrimary),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorManger.lightSecondary,
            fontSize: 30),
        color: Colors.transparent,
        centerTitle: true,
      ));
  static ThemeData darkTheme = ThemeData(
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManger.backGroundDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorManger.backGroundDark,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
      textTheme: TextTheme(
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: ColorManger.backGround),
          bodySmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          labelLarge: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: ColorManger.darkPrimary),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorManger.darkSecondary)),
      fontFamily: "Inter",
      scaffoldBackgroundColor: ColorManger.backGroundDark,
      colorScheme: ColorScheme.dark(
          outline: ColorManger.backGroundDark,
          onTertiaryContainer: Colors.white,
          onSecondaryContainer: ColorManger.lightPrimary,
          primary: ColorManger.darkPrimary,
          secondary: ColorManger.darkSecondary,
          tertiary: ColorManger.darkTeritary,
          onPrimary: ColorManger.lightSecondary,
          inversePrimary: ColorManger.lightPrimary,
          onPrimaryFixedVariant: Colors.white),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: ColorManger.lightPrimary),
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorManger.darkPrimary,
            fontSize: 30),
        color: Colors.transparent,
        centerTitle: true,
      ));
}
