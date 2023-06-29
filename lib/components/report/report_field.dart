// import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';

SizedBox reportField({String value}) {
  return SizedBox(
      height: 18,
      child: Center(child: Text(value, style: TextStyle(fontSize: 11))));
}

SizedBox reportFieldWeek({String value}) {
  return SizedBox(
      height: 30,
      child: Center(child: Text(value, style: TextStyle(fontSize: 11))));
}
