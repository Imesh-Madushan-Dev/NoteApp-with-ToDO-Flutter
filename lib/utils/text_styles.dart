import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';

class TextStyles {
  static const TextStyle appTitle = TextStyle(
    fontSize: 28,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  // Sub title
  static const TextStyle appSubTitle = TextStyle(
    fontSize: 24,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  // Description
  static const TextStyle appDescription = TextStyle(
    fontSize: 20,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  // Description small
  static const TextStyle appDescriptionSmall = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBody = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
  );
  static const TextStyle appButton = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
  );
}
