import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pros_bot/components/report/report_field.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/report/anual_report.dart';
import 'package:pros_bot/models/report/month_report.dart';

Future<Uint8List> makePdfMonth(
    {BodyOfMonthReport monthReport,
    String year,
    String month,
    String name,
    String company,
    String phone}) async {
  final pdf = Document(title: '2023-01-26');
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/img/pros_bot_logo_black.png'))
          .buffer
          .asUint8List());

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'Decemeber'
  ];

  /* totalAnbp(int i) {
    int sum = 0;
    if (plan.length < i + 1) {
      return 0;
    } else {
      for (int j = 0; j <= i; j++) {
        sum += (int.parse(plan[j].anbp));
      }
      return sum;
    }
  } */

  pdf.addPage(
    Page(
      build: (context) {
        return ListView(
          children: [
            Row(children: [
              SizedBox(width: 30),
              Column(children: [
                SizedBox(
                  height: 40,
                  // width: 150,
                  child: Image(imageLogo),
                ),
                Text('Monthly Report - ' +
                    months[int.parse(month) - 1] +
                    ' - ' +
                    year)
              ]),
              Spacer(),
              Column(children: [
                Text(name),
                Text(company),
                Text(phone),
              ]),
              SizedBox(width: 30),
            ]),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: PdfColors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Business Plan - ' +
                            year +
                            ' - ' +
                            months[int.parse(month) - 1],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: size.width - 124,
                            child: Table(
                              border: TableBorder.all(color: PdfColors.black),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(50),
                                1: FixedColumnWidth(40),
                                2: FixedColumnWidth(40),
                                3: FixedColumnWidth(40),
                                4: FixedColumnWidth(40),
                                5: FixedColumnWidth(40),
                              },
                              // defaultVerticalAlignment:
                              //     SizedBoxVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          height: 60,
                                          child: Center(child: Text('Week'))),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('Pros:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('App:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('S.I:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('F.Up')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('NOP')),
                                    ),
                                  ],
                                ),
                                // First
                                TableRow(
                                  children: [
                                    reportFieldWeek(
                                      value: '1st',
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthPros) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthApp) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthSale) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthFup) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthNop) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                  ],
                                ),
                                // second
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '2nd'),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthPros) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthApp) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthSale) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthFup) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthNop) *
                                              2 /
                                              9)
                                          .ceil()
                                          .toString(),
                                    ),
                                  ],
                                ),
                                //third
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '3rd'),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthPros) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthApp) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthSale) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthFup) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthNop) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                  ],
                                ),
                                //4th
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '4th'),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthPros) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthApp) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthSale) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthFup) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthNop) *
                                              2 /
                                              9)
                                          .floor()
                                          .toString(),
                                    ),
                                  ],
                                ),
                                //5th
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '5th'),
                                    reportFieldWeek(
                                      value: (int.parse(monthReport.monthPros) -
                                              (((int.parse(monthReport
                                                                  .monthPros) *
                                                              2 /
                                                              9)
                                                          .ceil() *
                                                      2) +
                                                  ((int.parse(monthReport
                                                                  .monthPros) *
                                                              2 /
                                                              9)
                                                          .floor() *
                                                      2)))
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value:
                                          /* (int.parse(monthReport.monthApp) -
                                                  int.parse(monthReport.monthApp) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthReport.monthApp) -
                                                  (((int.parse(monthReport
                                                                      .monthApp) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthReport
                                                                      .monthApp) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                    ),
                                    reportFieldWeek(
                                      value:
                                          /* (int.parse(monthReport.monthSale) -
                                                  int.parse(monthReport.monthSale) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthReport.monthSale) -
                                                  (((int.parse(monthReport
                                                                      .monthSale) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthReport
                                                                      .monthSale) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                    ),
                                    reportFieldWeek(
                                      value:
                                          /* (int.parse(monthReport.monthFup) -
                                                  int.parse(monthReport.monthFup) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthReport.monthFup) -
                                                  (((int.parse(monthReport
                                                                      .monthFup) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthReport
                                                                      .monthFup) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                    ),
                                    reportFieldWeek(
                                      value:
                                          /*  (int.parse(monthReport.monthNop) -
                                                  int.parse(monthReport.monthNop) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthReport.monthNop) -
                                                  (((int.parse(monthReport
                                                                      .monthNop) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthReport
                                                                      .monthNop) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                    ),
                                  ],
                                ),
                                // total
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: 'Total'),
                                    reportFieldWeek(
                                      value: monthReport.monthPros,
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.monthApp,
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.monthSale,
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.monthFup,
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.monthNop,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 180,
                            child: Column(
                              children: [
                                Table(
                                    border:
                                        TableBorder.all(color: PdfColors.black),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          reportFieldWeek(value: 'ANBP'),
                                        ],
                                      ),
                                    ]),
                                Table(
                                    border:
                                        TableBorder.all(color: PdfColors.black),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: 'Month',
                                          ),
                                          reportFieldWeek(value: 'Total'),
                                        ],
                                      ),
                                      //january
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      //Feb
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      //March
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    3 *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      // April
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) *
                                                    2 *
                                                    4 /
                                                    9)
                                                .floor()
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      // May
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (int.parse(
                                                        monthReport.monthAnbp) -
                                                    int.parse(monthReport
                                                            .monthAnbp) *
                                                        4 *
                                                        2 /
                                                        9)
                                                .floor()
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                            value: monthReport.monthAnbp,
                                          ),
                                        ],
                                      ),
                                      // Total
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: monthReport.monthAnbp,
                                          ),
                                          reportFieldWeek(
                                            value: monthReport.monthAnbp,
                                          )
                                        ],
                                      ),
                                    ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                /* SizedBox(
                  height: 150,
                  width: 150,dsdsdsdsdsdsdsdsdsdsji
                  child: Image(imageLogo),
                ) */
              ],
            ),
            SizedBox(height: 20),
            // Review
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: PdfColors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Business Review - ' +
                            year +
                            ' - ' +
                            months[int.parse(month) - 1],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: size.width - 124,
                            child: Table(
                              border: TableBorder.all(color: PdfColors.black),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(50),
                                1: FixedColumnWidth(40),
                                2: FixedColumnWidth(40),
                                3: FixedColumnWidth(40),
                                4: FixedColumnWidth(40),
                                5: FixedColumnWidth(40),
                              },
                              // defaultVerticalAlignment:
                              // SizedBoxVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(
                                  children: [
                                    SizedBox(
                                      child: Container(
                                          height: 60,
                                          child: Center(child: Text('Week'))),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('Pros:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('App:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('S.I:')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('F.Up')),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Center(child: Text('NOP')),
                                    ),
                                  ],
                                ),
                                // First
                                TableRow(
                                  children: [
                                    reportFieldWeek(
                                      value: '1st',
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.firstPros.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.firstApp.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.firstSale.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.firstFup.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.firstNop.toString(),
                                    ),
                                  ],
                                ),
                                // second
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '2nd'),
                                    reportFieldWeek(
                                      value: monthReport.secondPros.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.secondApp.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.secondSale.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.secondFup.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.secondNop.toString(),
                                    ),
                                  ],
                                ),
                                //third
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '3rd'),
                                    reportFieldWeek(
                                      value: monthReport.thirdPros.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.thirdApp.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.thirdSale.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.thirdFup.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.thirdNop.toString(),
                                    ),
                                  ],
                                ),
                                //4th
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '4th'),
                                    reportFieldWeek(
                                      value: monthReport.forthPros.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.forthApp.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.forthSale.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.forthFup.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.forthNop.toString(),
                                    ),
                                  ],
                                ),
                                //5th
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: '5th'),
                                    reportFieldWeek(
                                      value: monthReport.fifthPros.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.fifthApp.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.fifthSale.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.fifthFup.toString(),
                                    ),
                                    reportFieldWeek(
                                      value: monthReport.fifthNop.toString(),
                                    ),
                                  ],
                                ),
                                // total
                                TableRow(
                                  children: [
                                    reportFieldWeek(value: 'Total'),
                                    reportFieldWeek(
                                      value: (monthReport.firstPros +
                                              monthReport.secondPros +
                                              monthReport.thirdPros +
                                              monthReport.forthPros +
                                              monthReport.fifthPros)
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (monthReport.firstApp +
                                              monthReport.secondApp +
                                              monthReport.thirdApp +
                                              monthReport.forthApp +
                                              monthReport.fifthApp)
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (monthReport.firstSale +
                                              monthReport.secondSale +
                                              monthReport.thirdSale +
                                              monthReport.forthSale +
                                              monthReport.fifthSale)
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (monthReport.firstFup +
                                              monthReport.secondFup +
                                              monthReport.thirdFup +
                                              monthReport.forthFup +
                                              monthReport.fifthFup)
                                          .toString(),
                                    ),
                                    reportFieldWeek(
                                      value: (monthReport.firstNop +
                                              monthReport.secondNop +
                                              monthReport.thirdNop +
                                              monthReport.forthNop +
                                              monthReport.fifthNop)
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 180,
                            child: Column(
                              children: [
                                Table(
                                    border:
                                        TableBorder.all(color: PdfColors.black),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    columnWidths: const <int, TableColumnWidth>{
                                      // 0: FixedColumnWidth(40),
                                      // 1: FixedColumnWidth(40),
                                    },
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 30,
                                                child: Center(
                                                    child: Text('ANBP'))),
                                          ),
                                        ],
                                      ),
                                    ]),
                                Table(
                                    border:
                                        TableBorder.all(color: PdfColors.black),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 30,
                                                child: Center(
                                                    child: Text('Weekly'))),
                                          ),
                                          SizedBox(
                                            child: Center(child: Text('Total')),
                                          ),
                                        ],
                                      ),
                                      //1st wk
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (monthReport.firstAnbp * 12)
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                              value:
                                                  (monthReport.firstAnbp * 12)
                                                      .toString())
                                        ],
                                      ),
                                      //2nd
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (monthReport.secondAnbp * 12)
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                              value: (monthReport.firstAnbp *
                                                          12 +
                                                      monthReport.secondAnbp *
                                                          12)
                                                  .toString()),
                                        ],
                                      ),
                                      //3rd
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (monthReport.thirdAnbp * 12)
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                              value: (monthReport.firstAnbp *
                                                          12 +
                                                      monthReport.secondAnbp *
                                                          12 +
                                                      monthReport.thirdAnbp *
                                                          12)
                                                  .toString()),
                                        ],
                                      ),
                                      // 4th
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (monthReport.forthAnbp * 12)
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                              value:
                                                  (monthReport.firstAnbp * 12 +
                                                          monthReport
                                                                  .secondAnbp *
                                                              12 +
                                                          monthReport
                                                                  .thirdAnbp *
                                                              12 +
                                                          monthReport
                                                                  .forthAnbp *
                                                              12)
                                                      .toString()),
                                        ],
                                      ),
                                      // 5th
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value: (monthReport.fifthAnbp * 12)
                                                .toString(),
                                          ),
                                          reportFieldWeek(
                                              value:
                                                  (monthReport.firstAnbp * 12 +
                                                          monthReport
                                                                  .secondAnbp *
                                                              12 +
                                                          monthReport
                                                                  .thirdAnbp *
                                                              12 +
                                                          monthReport
                                                                  .forthAnbp *
                                                              12 +
                                                          monthReport
                                                                  .fifthAnbp *
                                                              12)
                                                      .toString()),
                                        ],
                                      ),
                                      // total
                                      TableRow(
                                        children: [
                                          reportFieldWeek(
                                            value:
                                                ((monthReport.firstAnbp * 12 +
                                                        monthReport.secondAnbp *
                                                            12 +
                                                        monthReport.thirdAnbp *
                                                            12 +
                                                        monthReport.forthAnbp *
                                                            12 +
                                                        monthReport.fifthAnbp *
                                                            12)
                                                    .toString()),
                                          ),
                                          reportFieldWeek(
                                              value:
                                                  (monthReport.firstAnbp * 12 +
                                                          monthReport
                                                                  .secondAnbp *
                                                              12 +
                                                          monthReport
                                                                  .thirdAnbp *
                                                              12 +
                                                          monthReport
                                                                  .forthAnbp *
                                                              12 +
                                                          monthReport
                                                                  .fifthAnbp *
                                                              12)
                                                      .toString()),
                                        ],
                                      ),
                                    ]),
                              ],
                            ),
                          )
                        ],
                      ),
                      // Text(invoice.address),
                    ],
                  ),
                ),
                /* SizedBox(
                  height: 150,
                  width: 150,dsdsdsdsdsdsdsdsdsdsji
                  child: Image(imageLogo),
                ) */
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('.........................'),
                    SizedBox(height: 5),
                    Text('Advisor')
                  ],
                ),
                Column(
                  children: [
                    Text('.........................'),
                    SizedBox(height: 5),
                    Text('Field Manager')
                  ],
                ),
                Column(
                  children: [
                    Text('.........................'),
                    SizedBox(height: 5),
                    Text('RDM')
                  ],
                )
              ],
            )
          ],
        );
      },
    ),
  );

  return pdf.save();
}
