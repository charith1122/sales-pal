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

SizedBox homeMenuButton(
    {Function submit,
    BuildContext context,
    String title,
    AssetImage prefixImage}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.width * 0.15,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: AppColors.BUTTON_BG),
        onPressed: () {
          submit();
        },
        child: Row(
          children: [
            SizedBox(height: 30, width: 30, child: Image(image: prefixImage)),
            Spacer(),
            Text(
              title,
              style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: 20),
            ),
            /*  Spacer(),
            Container(), */
            Spacer()
          ],
        )),
  );
}