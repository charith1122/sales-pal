import 'package:flutter/material.dart';

Padding textField(
    {String header, Widget child, @required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff707070),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ],
    ),
  );
}
