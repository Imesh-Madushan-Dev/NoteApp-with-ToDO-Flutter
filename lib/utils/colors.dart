import 'package:flutter/material.dart';

class AppColors {
  // primary Colors

  static const Color kBgColor = Color(0xff202326);
  static const Color kFloatingButton = Colors.indigoAccent;
  static const Color kCardColor = Color(0xff2F3235);
  static const Color kWhiteColor = Colors.white;

  // Gradient Color
  static const int kgradientStart = 0xff01f0ff;
  static const int kgradientEnd = 0xff4441ED;

  static LinearGradient kPrimaryGradient = const LinearGradient(
    colors: [
      Color(kgradientStart),
      Color(kgradientEnd),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
