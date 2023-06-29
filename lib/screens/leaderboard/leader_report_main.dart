import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/leaderboard/leader_reports.dart';
import 'package:pros_bot/screens/leaderboard/leader_weekly_report.dart';
import 'package:pros_bot/screens/reports/reports.dart';
import 'package:pros_bot/screens/reports/weekly_report.dart';

class LeaderReportMain extends StatefulWidget {
  final String id;
  final String name;
  final String company;
  final String regNo;
  final String contact;

  const LeaderReportMain(
      {Key key, this.id, this.name, this.company, this.regNo, this.contact})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => LeaderReportMainState();
}

class LeaderReportMainState extends State<LeaderReportMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR,
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
          title: Text('Reports of Member',
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
          color: AppColors.PRIMARY_COLOR,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Column(children: [
                  Text(widget.name),
                  widget.company != "" ? Text(widget.company) : Container(),
                  widget.regNo != "" ? Text(widget.regNo) : Container(),
                ]),
              ),
              TabBar(
                indicatorColor: AppColors.SECONDARY_COLOR,
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
                      LeaderReports(
                        id: widget.id,
                        name: widget.name,
                        regNo: widget.regNo,
                        company: widget.company,
                        contact: widget.contact,
                      ),
                      LeaderWeeklyReports(
                        id: widget.id,
                        name: widget.name,
                        regNo: widget.regNo,
                        company: widget.company,
                        contact: widget.contact,
                      ),
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
            backgroundColor: AppColors.PRIMARY_COLOR,
            body: Center(
                child: Text(
              'There will be some changes',
              style: TextStyle(fontSize: 21, color: AppColors.SECONDARY_COLOR),
            ))));
  }
}
