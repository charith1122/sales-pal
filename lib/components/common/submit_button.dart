import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';

SizedBox submitButton({Function submit, BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: AppColors.PRYMARY_COLOR2),
        onPressed: () {
          submit();
        },
        child: Text(
          "Submit",
          style: TextStyle(color: AppColors.PRIMARY_COLOR),
        )),
  );
}
