import 'package:flutter/material.dart';
import 'package:pros_bot/screens/to_do_list/new_to_do.dart';

InkWell todoCard(
    {Function function,
    Function okFunction,
    Function rejectFunction,
    String title = "",
    BuildContext context,
    String date,
    String time,
    String reason,
    String number}) {
  return InkWell(
    onTap: function,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 45,
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            VerticalDivider(
              thickness: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Date : ' + date),
                Text('Time : ' + time),
                Text('Reason : ' + reason),
                Row(
                  children: [
                    FlatButton(
                        onPressed: () {
                          // okFunction();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    FlatButton(
                        onPressed: () {
                          // rejectFunction();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Reject',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                )
              ],
            ),
            VerticalDivider(
              thickness: 2,
            ),
            SizedBox(
              width: 45,
              child: Center(
                child: IconButton(
                  iconSize: 36,
                  color: Colors.grey[700],
                  icon: const Icon(Icons.double_arrow_outlined),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => NewToDo(
                        id: 'EDIT',
                      ),
                    ));
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}


/* , */