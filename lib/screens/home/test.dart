import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';

class MyTestUi extends StatefulWidget {
  @override
  State<MyTestUi> createState() => _MyTestUiState();
}

class _MyTestUiState extends State<MyTestUi> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR_NEW, title: Text('Test')),
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: Container(
          color: AppColors.PRIMARY_COLOR_NEW,
          padding: EdgeInsets.only(top: 6, left: 0, right: 0, bottom: 2),
          child: ListView(
            children: [
              // Prospecting
              Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    SizedBox(
                      width: 60,
                      child: Text('0001'),
                    ),
                    Text('Shiran Kularathna')
                  ]),
                ),
              ),
              // Interview and Sales interview
              Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: IntrinsicHeight(
                    child: Row(children: [
                      SizedBox(
                        width: 60,
                        child: Text('0001'),
                      ),
                      VerticalDivider(
                        thickness: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Shiran Kularathna',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date : 2022/04/05'),
                              SizedBox(
                                width: 50,
                              ),
                              Text('Time : 11.10 AM')
                            ],
                          ),
                          Row(
                            children: [
                              FlatButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text('OK'),
                                  )),
                              FlatButton(
                                  onPressed: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text('Reject'),
                                  ))
                            ],
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              // NOP
              Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    SizedBox(
                      width: 60,
                      child: Text('0001'),
                    ),
                    Text('Shiran Kularathna'),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('NOP'),
                        )),
                  ]),
                ),
              ),
              // NOP details
              Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: [
                        Spacer(),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87),
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('0001'))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                        Text('Shiran Kularathna')
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Policy Number : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                        Text('4526/AC/124')
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Commencement Date : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                        Text('2021/10/26')
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Premium : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                        Text('LKR 1500,000.00')
                      ],
                    ),
                  ]),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.purple[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Prospecting',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              '15',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
