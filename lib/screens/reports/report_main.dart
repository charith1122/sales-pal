import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/reports/reports.dart';
import 'package:pros_bot/screens/reports/weekly_report.dart';

class ReportMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportMainState();
}

class ReportMainState extends State<ReportMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR_NEW,
          /* leading: IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {}
              // scaffoldKey.currentState.openDrawer(),
              ), */
          centerTitle: true,
          title: Text('Reports',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.home_filled,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  );
                }
                // scaffoldKey.currentState.openDrawer(),
                )
          ],
        ),
        body: Container(
          color: AppColors.PRIMARY_COLOR_NEW,
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.SECONDARY_COLOR_NEW,
                tabs: <Widget>[
                  Tab(
                    text: 'Annual',
                  ),
                  Tab(
                    text: 'Monthly',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Reports(),
                      WeeklyReports(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: AppColors.PRIMARY_COLOR_NEW,
            body: Center(
                child: Text(
              'There will be some changes',
              style:
                  TextStyle(fontSize: 21, color: AppColors.SECONDARY_COLOR_NEW),
            ))));
  }
}
