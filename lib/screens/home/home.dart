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

/*     messageManipulation() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  } */

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

      /* Drawer(
          backgroundColor: AppColors.PRIMARY_COLOR,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  width: size.width / 2,
                  height: size.width / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/pros_bot_logo.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(),
                    ));
                  },
                  child: Text(
                    'Profile',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'LinkedIn',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Facebook',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'YouTube',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Web',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Contact',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Payments(),
                    ));
                  },
                  child: Text(
                    'Payment',
                    style: AppStyles.drawerText,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {
                    removeUserAuthPref(key: "userAuth");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainSplashScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: AppStyles.drawerText,
                  ),
                ),
              ])), */
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
        actions: [
          /*  requsts > 0
              ? IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // removeUserAuthPref(key: "userAuth");
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LeaderRequest()),
                    );
                  }
                  // scaffoldKey.currentState.openDrawer(),
                  )
              : Container(), */
          /*  FlatButton(
            minWidth: 20,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Payments(),
              ));
            },
            child: Container(
              width: 40,
              // height: size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/11.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ), */
        ],
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.PRIMARY_COLOR),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            height: size.height * 0.2,
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
                  style:
                      TextStyle(color: AppColors.PRYMARY_COLOR2, fontSize: 16),
                ),
                Spacer()
              ],
            )),
          ),
          SizedBox(
            height: 15,
          ),
          homeMenuButton(
              context: context,
              prefixImage: AssetImage("assets/logos/inter2.png"),
              title: "Prospecting",
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
              prefixImage: AssetImage("assets/logos/inter2.png"),
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
          /*  Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                // for (int i = 0; i < tiles.length; i++)
                homeTile(
                  size: size,
                  name: 'Prospects',
                  value: pros.toString(),
                ),
                homeTile(
                  size: size,
                  name: 'Appointment',
                  value: appoint.toString() +
                      ' | ' +
                      appointOk.toString() +
                      ' | ' +
                      appointR.toString(),
                ),
                homeTile(
                  size: size,
                  name: 'Sales \nInterview',
                  value: sales.toString() +
                      ' | ' +
                      salesOk.toString() +
                      ' | ' +
                      salesR.toString(),
                ),
                /*  homeTile(
                  size: size,
                  name: 'Follow \nUp',
                  value: follows.toString(),
                ),
                homeTile(
                  size: size,
                  name: 'NOP',
                  value: nop.toString(),
                ), */
                InkWell(
                  onTap: () {
                    /*  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Dob(),
                    )); */
                  },
                  child: homeTile(
                    size: size,
                    name: 'DOB',
                    value: dob.toString(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*   Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Premium(),
                    )); */
                  },
                  child: homeTile(
                    size: size,
                    name: 'Premium',
                    value: premium.toString(),
                  ),
                ),
                homeTile(
                  size: size,
                  name: 'To Do List',
                  value: todos.toString(),
                ),

                SizedBox(
                  width: size.width,
                  height: 15,
                ),

                /* Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                ), */
                selectedUser == null ||
                        selectedUser["body"]["job_role"] != "Team Leader"
                    ? Container()
                    : Container(
                        width: size.width,
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: AppColors.SECONDARY_COLOR,
                                width: 2)),
                        child: FlatButton(
                          height: 50,
                          onPressed: () {
                            // login(context, "");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LeaderBoard(
                                      // id: null,
                                      ),
                              // builder: (BuildContext context) => DropDownDemo(),
                            ));
                          },
                          child: Text(
                            "Leader's Dashboard",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                /* Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                ) */
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),

            child: Column(
              // alignment: WrapAlignment.spaceEvenly,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    menuTileCategoryContainer(
                      size: size,
                      title: "Prospecting",
                      icon1: Icons.person_search,
                      image: "assets/icons/06.png",
                      color1: Colors.green[800],
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Prospecting(),
                        ));
                      },
                    ),
                    menuTileCategoryContainer(
                      size: size,
                      title: "Appointment",
                      icon1: Icons.pending_actions_outlined,
                      image: "assets/icons/02.png",
                      color1: Colors.orange[700],
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AppointmentMain(),
                        ));
                      },
                    ),
                    menuTileCategoryContainer(
                      size: size,
                      title: "Sales \nInterview",
                      icon1: Icons.people,
                      image: "assets/icons/12.png",
                      color1: Colors.blue,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              // SalesInterview(),
                              SalesInterviewMain(),
                        ));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*  menuTileCategoryContainer(
                      size: size,
                      title: "Follow Up",
                      icon1: Icons.file_copy_outlined,
                      image: "assets/icons/03.png",
                      color1: Colors.pink,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => FollowUp(),
                        ));
                      },
                    ), */
                    /* menuTileCategoryContainer(
                      size: size,
                      title: "NOP",
                      icon1: Icons.restore_page,
                      image: "assets/icons/04.png",
                      color1: Colors.cyan,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => NOPList(),
                        ));
                      },
                    ), */
                    menuTileCategoryContainer(
                      size: size,
                      title: "Anual Plan",
                      image: "assets/icons/01.png",
                      icon1: Icons.moving,
                      color1: Colors.purple,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AnualPlan(),
                        ));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    menuTileCategoryContainer(
                      size: size,
                      title: "To Do \nList",
                      icon1: Icons.playlist_add_check,
                      image: "assets/icons/09.png",
                      color1: Colors.red,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ToDoList(),
                        ));
                      },
                    ),
                    menuTileCategoryContainer(
                      size: size,
                      title: "Reports",
                      icon1: Icons.request_page,
                      image: "assets/icons/07.png",
                      color1: Colors.black54,
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ReportMain(),
                        ));
                      },
                    ),
                    /*  menuTileCategoryContainer(
                      size: size,
                      title: "Detail \nSources",
                      icon1: Icons.file_present,
                      image: "assets/icons/13.png",
                      color1: Colors.yellow[900],
                      function: () {
                        /*  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => DetailResources(),
                    )); */
                      },
                    ), */
                  ],
                ),
              ],
            ),
            // alignment: WrapAlignment.spaceEvenly,
          ), */
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  SendUser().saveDeviceToken();
                },
                child: Text(
                  'Add',
                  style: AppStyles.drawerText,
                ),
              ),
              TextButton(
                onPressed: () {
                  SendUser().deleteDeviceToken();
                },
                child: Text(
                  'remov',
                  style: AppStyles.drawerText,
                ),
              ),
            ],
          ) */
        ],
      ),
    );
  }
}
