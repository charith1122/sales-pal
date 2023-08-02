import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';

InkWell menuTileCategoryContainer(
    {Size size,
    Function function,
    String title = "",
    String image = "",
    IconData icon1,
    Color color1}) {
  return InkWell(
    onTap: function,
    child: Column(
      children: [
        Container(
          height: 120,
          width: 100,
          child: Center(
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Container homeTile({
  Size size,
  String name,
  String value,
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(5),
    width: size.width / 4.9,
    height: 65,
    decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR_NEW,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              // 'Prospecting',
              name,
              style: TextStyle(
                  fontSize: 9.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
        Row(
          children: [
            Spacer(),
            Text(
              // '15',
              value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ],
    ),
  );
}
