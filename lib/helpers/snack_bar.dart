import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class AppHelpers {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFloatingButton,
        content: Text(
          message,
          style: TextStyles.appButton,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
