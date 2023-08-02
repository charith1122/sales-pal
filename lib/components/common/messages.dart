/**
 * wrote for pop up toasts
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pros_bot/constants/app_colors.dart';

successMessage({String message}) {
  Fluttertoast.showToast(
    webShowClose: false,
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.SECONDARY_COLOR_NEW,
    textColor: Colors.green[800],
    fontSize: 14.0,
  );
}

errorMessage({String message}) {
  Fluttertoast.showToast(
    webShowClose: false,
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.SECONDARY_COLOR_NEW,
    textColor: Colors.red[800],
    fontSize: 14.0,
  );
}
