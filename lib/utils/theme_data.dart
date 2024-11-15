import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().primaryColor,
      scaffoldBackgroundColor: AppColors.kBgColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.kWhiteColor,
      ),
      // app bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kBgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kWhiteColor),
      ),

      // floating Buton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.kFloatingButton,
      ));
}
