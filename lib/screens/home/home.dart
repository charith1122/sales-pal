import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/components/common/buttons.dart';
import 'package:pros_bot/components/common/drawer.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/main.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/models/home/analyse_data.dart';
import 'package:pros_bot/screens/anual_plan/anual_plan.dart';
import 'package:pros_bot/screens/apointment/appointment.dart';
import 'package:pros_bot/screens/apointment/appointment_new.dart';
import 'package:pros_bot/screens/detail_sources/detail_sources.dart';
import 'package:pros_bot/screens/follow_up/follow_up.dart';
import 'package:pros_bot/screens/home/profile.dart';
import 'package:pros_bot/screens/leaderboard/leaderboard.dart';
import 'package:pros_bot/screens/leaderboard/request.dart';
import 'package:pros_bot/screens/nop/nop.dart';
import 'package:pros_bot/screens/nop/nop_list.dart';
import 'package:pros_bot/screens/payment/payments.dart';
import 'package:pros_bot/screens/prospecting/prospecting.dart';
import 'package:pros_bot/screens/reports/report_main.dart';
import 'package:pros_bot/screens/reports/reports.dart';
import 'package:pros_bot/screens/sales_interview/sales_interview.dart';
import 'package:pros_bot/screens/sales_interview/sales_interview_main.dart';
import 'package:pros_bot/screens/to_do_list/to_do_list.dart';
import 'package:pros_bot/screens/today/dob.dart';
import 'package:pros_bot/screens/today/premium.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/firebase.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

import 'notification.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BodyOfGetAppointments> appointments = [];
  AnalyseData analyseData;
  var selectedUser;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer timer;

  int pros = 0;
  int appoint = 0;
  int appointOk = 0;
  int appointR = 0;
  int sales = 0;
  int salesOk = 0;
  int salesR = 0;
  int follows = 0;
  int nop = 0;
  int premium = 0;
  int todos = 0;
  int dob = 0;
  int requsts = 0;
  DateTime today = DateTime.now();
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';
  String userName = "";

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    super.initState();

    getuser();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    if (selectedUser != null) {
      setState(() {
        userName = selectedUser["body"]["name"];
      });
    }
    // getAnalyse();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getAnalyse());
  }

  getAnalyse() async {
    try {
      await APIs()
          .getAnalyse(userId: selectedUser["body"]["id"])
          .then((value) async {
        if (value.done != null) {
          analyseData = new AnalyseData.fromJson(value.toJson());
          if (analyseData.done == true) {
            setState(() {
              pros = analyseData.body.prospects;
              appoint = analyseData.body.appointments;
              appointOk = analyseData.body.okAppointments;
              appointR = analyseData.body.rejectAppointments;
              sales = analyseData.body.salesInterviews;
              salesOk = analyseData.body.okSalesInterviews;
              salesR = analyseData.body.rejectSalesInterviews;
              follows = analyseData.body.followUps;
              nop = analyseData.body.nop;
              todos = analyseData.body.todos;
              premium = analyseData.body.premium;
              requsts = analyseData.body.requsts;
              dob = analyseData.body.dob;
            });
            // login(mobileNo: analyseData.body.contactNo);
          } else {
            await EasyLoading.dismiss();
            // errorMessage(message: value.message);
          }
        } else {
          await EasyLoading.dismiss();
          // errorMessage(message: value.message);
        }
        // print(appointments);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: myDrawer(context: context, size: size),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.PRYMARY_COLOR2,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }
            //
            ),
        actions: [],
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.PRIMARY_COLOR_NEW),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: today.hour >= 1 && today.hour <= 12
                      ? AssetImage("assets/img/morning.png")
                      : today.hour >= 12 && today.hour <= 16
                          ? AssetImage("assets/img/afternoon.png")
                          : today.hour >= 16 && today.hour <= 21
                              ? AssetImage("assets/img/Evening.png")
                              : today.hour >= 21 && today.hour <= 24
                                  ? AssetImage("assets/img/night.png")
                                  : AssetImage(""),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            height: size.width * 0.4,
            width: size.width,
            child: Center(
                child: Column(
              children: [
                Spacer(),
                Text("Hey, " +
                    userName +
                    " " +
                    (today.hour >= 1 && today.hour <= 12
                        ? "Good Morning"
                        : today.hour >= 12 && today.hour <= 16
                            ? "Good Afternoon"
                            : today.hour >= 16 && today.hour <= 21
                                ? "Good Evening"
                                : today.hour >= 21 && today.hour <= 24
                                    ? "Good Night"
                                    : "")),
                Text(
                  "Today is " +
                      (today.weekday == 1
                          ? "Monday"
                          : today.weekday == 2
                              ? "Tuesday"
                              : today.weekday == 3
                                  ? "Wednesday"
                                  : today.weekday == 4
                                      ? "Thursday"
                                      : today.weekday == 5
                                          ? "Friday"
                                          : today.weekday == 6
                                              ? "Saturday"
                                              : "Sunday") +
                      ",  " +
                      (today.month == 1
                          ? "January"
                          : today.month == 2
                              ? "February"
                              : today.month == 3
                                  ? "March"
                                  : today.month == 4
                                      ? "April"
                                      : today.month == 5
                                          ? "May"
                                          : today.month == 6
                                              ? "june"
                                              : today.month == 7
                                                  ? "July"
                                                  : today.month == 8
                                                      ? "Auguest"
                                                      : today.month == 9
                                                          ? "September"
                                                          : today.month == 10
                                                              ? "October"
                                                              : today.month ==
                                                                      11
                                                                  ? "November"
                                                                  : today.month ==
                                                                          12
                                                                      ? "December"
                                                                      : "") +
                      "  " +
                      today.day.toString() +
                      ",  " +
                      today.year.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                )
                // Spacer()
              ],
            )),
          ),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/inter2.png"),
              title: "Customers",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      Prospecting(),
                ));
              }),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/To do list.png"),
              title: "To Do",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      ToDoList(),
                ));
              }),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/appoi.png"),
              title: "Appointment",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      AppointmentMain(),
                ));
              }),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/img/interview.png"),
              title: "Sales Interview",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      SalesInterviewMain(),
                ));
              }),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/planner.png"),
              title: "Anual Plan",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      AnualPlan(),
                ));
              }),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/appoi.png"),
              title: "Report",
              submit: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      // SalesInterview(),
                      ReportMain(),
                ));
              }),
        ],
      ),
    );
  }
}
