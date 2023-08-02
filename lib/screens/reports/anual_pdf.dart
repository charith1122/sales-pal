import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pros_bot/components/report/report_field.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/report/anual_report.dart';

Future<Uint8List> makePdf(
    {List<BodyOfGetAnnualPlans> plan,
    BodyOfAnualReport anualReport,
    String year,
    String name,
    // String company,
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

  totalAnbp(int i) {
    int sum = 0;
    if (plan.length < i + 1) {
      return 0;
    } else {
      for (int j = 0; j <= i; j++) {
        sum += (int.parse(plan[j].anbp));
      }
      return sum;
    }
  }

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
                Text('Anual Report - ' + year)
              ]),
              Spacer(),
              Column(children: [
                Text(name),
                // Text(company),
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
                        'Business Plan - ' + year,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width - 124,
                            child: Table(
                              border: TableBorder.all(
                                  // color: AppColors.SECONDARY_COLOR
                                  ),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(75),
                                // 1: FlexColumnWidth(25),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 40,
                                          child: Center(child: Text('Month'))),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('Pros:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('App:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('S.I:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('F.Up')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('NOP')),
                                    ),
                                  ],
                                ),
                                // January
                                for (int i = 0; i < 12; i++)
                                  TableRow(
                                    children: [
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].month
                                              : months[i]),
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].pros
                                              : '0'),
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].app
                                              : '0'),
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].sale
                                              : '0'),
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].follow
                                              : '0'),
                                      reportField(
                                          value: plan.length > 0
                                              ? plan[i].nop
                                              : '0'),
                                    ],
                                  ),
                                //February
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              children: [
                                Table(
                                    border: TableBorder.all(
                                        // color: AppColors.SECONDARY_COLOR
                                        ),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 20,
                                                child: Center(
                                                    child: Text('ANBP:'))),
                                          ),
                                        ],
                                      ),
                                    ]),
                                Table(
                                    border: TableBorder.all(
                                        // color: AppColors.SECONDARY_COLOR
                                        ),
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 20,
                                                child: Center(
                                                    child: Text('Month'))),
                                          ),
                                          SizedBox(
                                            child: Center(child: Text('Total')),
                                          ),
                                        ],
                                      ),
                                      //january
                                      for (int j = 0; j < 12; j++)
                                        TableRow(
                                          children: [
                                            reportField(
                                                value: plan.length > 0
                                                    ? plan[j].anbp
                                                    : '0'),
                                            SizedBox(
                                                child: Center(
                                                    child: Text(totalAnbp(j)
                                                        .toString()))),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: PdfColors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Business Review - ' + year,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width - 124,
                            child: Table(
                              border: TableBorder.all(
                                  // color: AppColors.SECONDARY_COLOR
                                  ),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(75),
                                // 1: FlexColumnWidth(25),
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
                                          height: 40,
                                          child: Center(child: Text('Month'))),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('Pros:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('App:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('S.I:')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('F.Up')),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: Center(child: Text('NOP')),
                                    ),
                                  ],
                                ),
                                // January
                                TableRow(
                                  children: [
                                    reportField(value: 'January'),
                                    reportField(
                                        value:
                                            anualReport.rprtJanPros.toString()),
                                    reportField(
                                      value: anualReport.rprtJanApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtJanSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                //February
                                TableRow(
                                  children: [
                                    reportField(value: 'February'),
                                    reportField(
                                      value: anualReport.rprtFebPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtFebApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtFebSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                //March
                                TableRow(
                                  children: [
                                    reportField(value: 'March'),
                                    reportField(
                                      value: anualReport.rprtMarPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtMarApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtMarSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                //April
                                TableRow(
                                  children: [
                                    reportField(value: 'April'),
                                    reportField(
                                      value:
                                          anualReport.rprtAprlPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtAprlApp.toString(),
                                    ),
                                    reportField(
                                      value:
                                          anualReport.rprtAprlSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                //May
                                TableRow(
                                  children: [
                                    reportField(value: 'May'),
                                    reportField(
                                      value: anualReport.rprtMayPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtMayApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtMaySale.toString(),
                                    ),
                                   
                                  ],
                                ),
                                //June
                                TableRow(
                                  children: [
                                    reportField(value: 'June'),
                                    reportField(
                                      value: anualReport.rprtJunPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtJunApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtJunSale.toString(),
                                    ),
                                   
                                  ],
                                ),
                                //July
                                TableRow(
                                  children: [
                                    reportField(value: 'July'),
                                    reportField(
                                      value: anualReport.rprtJulPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtJulApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtJulSale.toString(),
                                    ),
                                   
                                  ],
                                ),
                                //August
                                TableRow(
                                  children: [
                                    reportField(value: 'August'),
                                    reportField(
                                      value: anualReport.rprtAugPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtAugApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtAugSale.toString(),
                                    ),
                                   
                                  ],
                                ),
                                // September
                                TableRow(
                                  children: [
                                    reportField(value: 'September'),
                                    reportField(
                                      value: anualReport.rprtSepPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtSepApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtSepSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                // October
                                TableRow(
                                  children: [
                                    reportField(value: 'October:'),
                                    reportField(
                                      value: anualReport.rprtOctPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtOctApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtOctSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                // November
                                TableRow(
                                  children: [
                                    reportField(value: 'November'),
                                    reportField(
                                      value: anualReport.rprtNovPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtNovApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtNovSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                                // December
                                TableRow(
                                  children: [
                                    reportField(value: 'December'),
                                    reportField(
                                      value: anualReport.rprtDecPros.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtDecApp.toString(),
                                    ),
                                    reportField(
                                      value: anualReport.rprtDecSale.toString(),
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              children: [
                                Table(
                                    border: TableBorder.all(
                                        // color: AppColors.SECONDARY_COLOR
                                        ),
                                    // defaultVerticalAlignment:
                                    //     SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 20,
                                                child: Center(
                                                    child: Text('ANBP:'))),
                                          ),
                                        ],
                                      ),
                                    ]),
                                Table(
                                    border: TableBorder.all(
                                        // color: AppColors.SECONDARY_COLOR
                                        ),
                                    // defaultVerticalAlignment:
                                    // SizedBoxVerticalAlignment.middle,
                                    children: <TableRow>[
                                      TableRow(
                                        children: [
                                          SizedBox(
                                            child: Container(
                                                height: 20,
                                                child: Center(
                                                    child: Text('Month'))),
                                          ),
                                          SizedBox(
                                            child: Center(child: Text('Total')),
                                          ),
                                        ],
                                      ),
                                      //january
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtJanAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                                      (anualReport.rprtJanAnbp *
                                                              12)
                                                          .toString()))),
                                        ],
                                      ),
                                      //Feb
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtFebAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      //March
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtMarAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // April
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtAprlAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // May
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtMayAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // june
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtJunAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // july
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtJulAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // aug
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtAugAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAugAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // sep
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtSepAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAugAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtSepAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // oct
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtOctAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAugAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtSepAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtOctAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // nov
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtNovAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAugAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtSepAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtOctAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtNovAnbp *
                                                              12)
                                                      .toString()))),
                                        ],
                                      ),
                                      // dec
                                      TableRow(
                                        children: [
                                          SizedBox(
                                              child: Container(
                                            height: 18,
                                            child: Center(
                                              child: Text(
                                                (anualReport.rprtDecAnbp * 12)
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                              child: Center(
                                                  child: Text((anualReport
                                                                  .rprtJanAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtFebAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMarAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAprlAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtMayAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJunAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtJulAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtAugAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtSepAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtOctAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtNovAnbp *
                                                              12 +
                                                          anualReport
                                                                  .rprtDecAnbp *
                                                              12)
                                                      .toString()))),
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
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
