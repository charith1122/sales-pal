import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';

Row labelText({
  String label,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        // margin: const EdgeInsets.all(6),
        child: Text(
          label,
          style: AppStyles.textFieldHeaderStyle2,
        ),
      ),
    ],
  );
}
