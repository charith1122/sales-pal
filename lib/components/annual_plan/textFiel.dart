import 'package:flutter/material.dart';

TextFormField reportText(
    {BuildContext context,
    TextEditingController txtControl,
    Function function}) {
  return TextFormField(
    controller: txtControl,
    onTap: function,
    readOnly: true,
    style: TextStyle(fontSize: 12),
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorMaxLines: 2,
      errorStyle: TextStyle(
          color: Color.fromARGB(255, 182, 40, 30),
          fontWeight: FontWeight.w400,
          fontSize: 12,
          overflow: TextOverflow.fade),
      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
    ),
    onEditingComplete: () {
      // FocusScope.of(context).nextFocus();
      FocusScope.of(context).unfocus();
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );
}
