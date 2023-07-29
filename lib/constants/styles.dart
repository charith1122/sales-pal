import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';

class AppStyles {
  // Login Screen
  static const TextStyle buttonStyle = TextStyle(
      color: Colors.white,
      // fontSize: 16,
      fontWeight: FontWeight.bold);

  static TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.SECONDARY_COLOR.withOpacity(0.5));
  static const TextStyle floatingLabelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.PRIMARY_COLOR,
      backgroundColor: AppColors.SECONDARY_COLOR);
  static const TextStyle errorTextStyle = TextStyle(
      color: /* Color.fromARGB(255, 182, 40, 30), */ AppColors.SECONDARY_COLOR,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      overflow: TextOverflow.fade);
  static const TextStyle textFieldStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColors.SECONDARY_COLOR);
  static const TextStyle textFieldStyle2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.SECONDARY_COLOR);
  static const TextStyle drawerText = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColors.SECONDARY_COLOR);
  static const TextStyle drawerText2 = TextStyle(
      fontSize: 16,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal,
      color: AppColors.SECONDARY_COLOR);
  static const TextStyle textFieldHeaderStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle textFieldHeaderStyle2 = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subHeader = TextStyle(
      fontSize: 18,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal,
      color: AppColors.SECONDARY_COLOR2);
}
