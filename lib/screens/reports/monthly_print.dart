import 'package:flutter/material.dart';
// import 'package:makepdfs/models/invoice.dart';
import 'package:printing/printing.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/report/anual_report.dart';
import 'package:pros_bot/models/report/month_report.dart';
import 'package:pros_bot/screens/reports/anual_pdf.dart';
import 'package:pros_bot/screens/reports/month_pdf.dart';
// import 'package:pros_bot/screens/reports/pdfexport.dart';
// import 'pdf/pdfexport.dart';

class MonthlyPrint extends StatelessWidget {
  final BodyOfMonthReport monthReport;
  final String year;
  final String month;
  final String name;
  // final String company;
  final String phone;

  const MonthlyPrint(
      {Key key,
      // this.plan,
      this.monthReport,
      this.year,
      this.month,
      this.name,
      // this.company,
      this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.SECONDARY_COLOR_NEW),
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        title: Text(
          'PDF Preview',
          style: TextStyle(color: AppColors.SECONDARY_COLOR_NEW),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdfMonth(
            // plan: plan,
            monthReport: monthReport,
            year: year,
            month: month,
            name: name,
            // company: company,
            phone: phone),
      ),
    );
  }
}
