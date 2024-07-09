import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.redAccent,
      primaryColorLight: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      useMaterial3: true,
      textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.primaryColor)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle:
              MaterialStateTextStyle.resolveWith((states) => TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              )))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          shadowColor: Colors.grey
      ),

      appBarTheme:  AppBarTheme(
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),

      ));

  static final dark = ThemeData(
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
      ),
      primaryColorLight: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.redAccent,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      useMaterial3: true,
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.primaryColor)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle:
              MaterialStateTextStyle.resolveWith((states) => TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              )))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
          shadowColor: Colors.grey
      ),
      appBarTheme:  AppBarTheme(
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ));
}
