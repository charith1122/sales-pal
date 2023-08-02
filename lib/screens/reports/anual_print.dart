import 'package:flutter/material.dart';
// import 'package:makepdfs/models/invoice.dart';
import 'package:printing/printing.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/report/anual_report.dart';
import 'package:pros_bot/screens/reports/anual_pdf.dart';
// import 'package:pros_bot/screens/reports/pdfexport.dart';
// import 'pdf/pdfexport.dart';

class AnnualPrint extends StatelessWidget {
  final List<BodyOfGetAnnualPlans> plan;
  final BodyOfAnualReport anualReport;
  final String year;
  final String name;
  // final String company;
  final String phone;

  const AnnualPrint(
      {Key key,
      this.plan,
      this.anualReport,
      this.year,
      this.name,
      // this.company,
      this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        title: Text(
          'PDF Preview',
          style: TextStyle(color: AppColors.SECONDARY_COLOR_NEW),
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(
            plan: plan,
            anualReport: anualReport,
            year: year,
            name: name,
            // company: company,
            phone: phone),
      ),
    );
  }
}
