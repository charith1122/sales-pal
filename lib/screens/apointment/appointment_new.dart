import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/screens/apointment/appointment.dart';
import 'package:pros_bot/screens/apointment/appointment_done.dart';
import 'package:pros_bot/screens/apointment/rejected_appointments.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/reports/reports.dart';
import 'package:pros_bot/screens/reports/weekly_report.dart';

class AppointmentMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppointmentNewState();
}

class AppointmentNewState extends State<AppointmentMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
          title: Text('Appointments',
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
              TabBar(
                indicatorColor: AppColors.SECONDARY_COLOR,
                tabs: <Widget>[
                  Tab(
                    text: 'Active',
                  ),
                  Tab(
                    text: 'Rejected',
                  ),
                  Tab(
                    text: 'Done',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Appointment(),
                      RejectedAppointment(),
                      DoneAppointment(),
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
