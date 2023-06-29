import 'package:flutter/material.dart';

class DatePickerContainer extends StatefulWidget {
  final Widget child;
  DatePickerContainer({this.child});
  @override
  _DatePickerContainerState createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        /* boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.1,
            spreadRadius: 0.1,
          )
        ], */
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*  SizedBox(
              height: 15.0,
            ), */
            widget.child,
            /* SizedBox(
              height: 10,
            ), */
          ],
        ),
      ),
    );
  }
}
