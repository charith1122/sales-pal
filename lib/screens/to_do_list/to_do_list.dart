import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/todo/todo_card.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/screens/apointment/new_apointment.dart';
// import 'package:pros_bot/models/appo/get_appointment.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/sales_interview/new_sales_interview.dart';
import 'package:pros_bot/screens/to_do_list/new_to_do.dart';
import 'package:pros_bot/screens/to_do_list/picker.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key key}) : super(key: key);

  // final String title;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  var selectedUser;
  List<BodyOfGetAppointments> todos = [];
  List<BodyOfGetAppointments> appointments = [];
  List<BodyOfGetAppointments> salesInterviews = [];
  bool isLoading = true;
  bool isSalesLoading = true;
  bool isAppointLoading = true;
  // bool isLoadingOnScreen = false;

  // TextEditingController startDate = TextEditingController();
  // TextEditingController endDate = TextEditingController();

  String startDate = '';
  String endDate = '';

  DateTime selectedDate = DateTime.now();

  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat timeFormatter = DateFormat('hh:mm a');

  @override
  void initState() {
    super.initState();

    startDate = formatter.format(DateTime.now());
    endDate = formatter.format(DateTime.now());
    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getTodo();
    getAppointments();
    getInterviews();
  }

  //function of date selector
  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate,
      firstDate: DateTime(-100),
      lastDate: DateTime(5000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.SECONDARY_COLOR_NEW, // <-- SEE HERE
              onPrimary: Color.fromARGB(255, 255, 255, 255), // <-- SEE HERE
              onSurface: AppColors.SECONDARY_COLOR_NEW, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.SECONDARY_COLOR_NEW, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      DateTime dt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      DateFormat formatter = DateFormat('yyyy-MM-dd EEEE hh:mm a');
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

      String formatted = formatter.format(dt);

      String dateFormatted = dateFormatter.format(dt);
      if (type == 'START') {
        startDate = dateFormatted;
      } else if (type == 'END') {
        endDate = dateFormatted;
      } else {}
      EasyLoading.show();

      getTodo();
      getAppointments();
      getInterviews();

      var duration = Duration(seconds: 2);
      return Timer(duration, () {
        selectedDate = DateTime.now();
      });
    }
  }

  getTodo() async {
    try {
      await APIs()
          .getTodosByDate(
              userId: selectedUser["body"]["id"],
              start: startDate,
              end: endDate)
          .then((value) {
        todos.clear();

        value.body.isNotEmpty
            ? value.body.forEach((item) {
                if (item.status == 'Active') {
                  todos.add(item);
                }
              })
            : () {};
        print(todos);
      });
    } catch (e) {
      // errorMessage(message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
      EasyLoading.dismiss();
    });
  }

  getInterviews() async {
    try {
      await APIs()
          .getInterviewsByDate(
              userId: selectedUser["body"]["id"],
              start: startDate,
              end: endDate)
          .then((value) {
        salesInterviews.clear();

        value.body.forEach((item) {
          if (item.status == 'Active') {
            salesInterviews.add(item);
          }
        });
        print(salesInterviews);
      });
    } catch (e) {
      // errorMessage(message: 'Something went wrong');
    }
    setState(() {
      isSalesLoading = false;
      EasyLoading.dismiss();
    });
  }

  getAppointments() async {
    try {
      await APIs()
          .getAppointmentByDate(
              userId: selectedUser["body"]["id"],
              start: startDate,
              end: endDate)
          .then((value) {
        appointments.clear();

        value.body.forEach((item) {
          if (item.status == 'Active') {
            appointments.add(item);
          }
        });
        print(appointments);
      });
    } catch (e) {
      // errorMessage(message: 'Something went wrong');
    }
    setState(() {
      isAppointLoading = false;
      EasyLoading.dismiss();
    });
  }

  updateTodo({String id, status}) async {
    var result = await APIs().updateTodo(id: id, status: status);

    if (result.done != null) {
      if (result.done) {
        todos.clear();
        setState(() {
          isLoading = true;
        });
        getTodo();
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
      }
    } else {
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
    }
  }

  updateAppointment({String id, status, prosId}) async {
    var result = await APIs().updateAppointment(
        id: id,
        status: status,
        prosId: prosId,
        userId: selectedUser["body"]["id"]);

    if (result.done != null) {
      if (result.done) {
        appointments.clear();
        setState(() {
          isAppointLoading = true;
        });
        getAppointments();
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
      }
    } else {
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
    }
  }

  updateInterview({String id, status}) async {
    var result = await APIs().updateInterviews(id: id, status: status);

    if (result.done != null) {
      if (result.done) {
        appointments.clear();
        setState(() {
          isSalesLoading = true;
        });
        getInterviews();
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
      }
    } else {
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // drawer: Drawer(),
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
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.home_filled,
                    size: 30,
                    color: Colors.black,
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
            centerTitle: true,
            title: Text('To Do List',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.SECONDARY_COLOR_NEW)),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: AppColors.PRIMARY_COLOR_NEW,
          body: Container(
            color: AppColors.PRIMARY_COLOR_NEW,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.SECONDARY_COLOR_NEW,
                            borderRadius: BorderRadius.circular(20)),
                        width: size.width / 3,
                        child: FlatButton(
                            onPressed: () {
                              _selectDate(context, 'START');
                            },
                            child: Text(
                              startDate,
                              style:
                                  TextStyle(color: AppColors.PRIMARY_COLOR_NEW),
                            )),
                      ),
                      Text('-'),
                      // Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.SECONDARY_COLOR_NEW,
                            borderRadius: BorderRadius.circular(20)),
                        width: size.width / 3,
                        child: FlatButton(
                            onPressed: () {
                              _selectDate(context, 'END');
                            },
                            child: Text(
                              endDate,
                              style:
                                  TextStyle(color: AppColors.PRIMARY_COLOR_NEW),
                            )),
                      ),
                    ],
                  ),
                ),
                /*   TabBar(
                  labelColor: AppColors.PRYMARY_COLOR2,
                  unselectedLabelColor: AppColors.SECONDARY_COLOR_NEW,
                  indicatorColor: AppColors.PRYMARY_COLOR2,
                  tabs: <Widget>[
                    Tab(
                      text: 'To Do',
                    ),
                    Tab(
                      text: 'Appointments',
                    ),
                    Tab(
                      text: 'S. Interviews',
                    )
                  ],
                ), */
                Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        isAppointLoading
                            ? Container(
                                color: AppColors.PRIMARY_COLOR_NEW,
                                child: Center(
                                  child: SpinKitCubeGrid(
                                    color: AppColors.SECONDARY_COLOR_NEW,
                                    size: 50.0,
                                    // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                                  ),
                                ))
                            : Container(
                                color: AppColors.PRIMARY_COLOR_NEW,
                                padding: EdgeInsets.only(
                                    top: 6, left: 0, right: 0, bottom: 2),
                                child: Stack(
                                  children: [
                                    todos.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 75),
                                            child: ListView(
                                              children: [
                                                for (int i = 0;
                                                    i < todos.length;
                                                    i++)
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 15),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .SECONDARY_COLOR_NEW,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: IntrinsicHeight(
                                                      child: Row(children: [
                                                        SizedBox(
                                                          width: 45,
                                                          child: Text(
                                                            // (i + 1).toString().padLeft(4, '0'),
                                                            ((i + 1)
                                                                .toString()
                                                                .padLeft(
                                                                    2, '0')),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .SECONDARY_COLOR_NEW),
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color: AppColors
                                                              .SECONDARY_COLOR_NEW,
                                                          thickness: 2,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.width -
                                                                      120,
                                                              child: Text(
                                                                todos[i].prosName ??
                                                                    todos[i]
                                                                        .note,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .SECONDARY_COLOR_NEW),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            /* Text(
                                                              'Reason :- ' +
                                                                      todos[i]
                                                                          .reason ??
                                                                  "",
                                                            ), */
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Date : ' +
                                                                      formatter.format(
                                                                          DateTime.parse(
                                                                              todos[i].date)),
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .SECONDARY_COLOR_NEW),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  'Time : ' +
                                                                      (todos[i]
                                                                          .time),
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .SECONDARY_COLOR_NEW),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      updateTodo(
                                                                        id: todos[i]
                                                                            .id,
                                                                        status:
                                                                            'OK',
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              6,
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .SECONDARY_COLOR_NEW,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.PRIMARY_COLOR_NEW),
                                                                      ),
                                                                    )),
                                                                /* FlatButton(
                                                    onPressed: () {
                                                      updateTodo(
                                                          id: todos[i].id,
                                                          status: 'Rejected');
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 6,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .SECONDARY_COLOR_NEW,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                      child: Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .PRIMARY_COLOR_NEW),
                                                      ),
                                                    )), */
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                NewToDo(
                                                                          id: todos[i]
                                                                              .id,
                                                                        ),
                                                                      ));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              6,
                                                                          horizontal:
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .SECONDARY_COLOR_NEW,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          Text(
                                                                        'Edit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.PRIMARY_COLOR_NEW),
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )
                                        : Center(
                                            child: Text('No Todos'),
                                          ),
                                    Positioned(top: 10, child: Container()),
                                    Positioned(
                                      bottom: 10,
                                      width: size.width,
                                      // right: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 50),
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColors.PRIMARY_COLOR_NEW,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                border: Border.all(
                                                    color: AppColors
                                                        .SECONDARY_COLOR_NEW,
                                                    width: 2)),
                                            child: FlatButton(
                                              height: 50,
                                              onPressed: () {
                                                // login(context, "");
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          NewToDo(
                                                    id: null,
                                                  ),
                                                  // builder: (BuildContext context) => DropDownDemo(),
                                                ));
                                              },
                                              child: Text(
                                                "Add +",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      AppColors.PRYMARY_COLOR2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                        Container(
                          padding: EdgeInsets.only(
                              top: 0, left: 0, right: 0, bottom: 75),
                          child: appointments.isNotEmpty
                              ? ListView(
                                  children: [
                                    for (int k = 0;
                                        k < appointments.length;
                                        k++)
                                      appointments[k].status == 'Active'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .SECONDARY_COLOR_NEW,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 15),
                                              padding: const EdgeInsets.all(10),
                                              child: IntrinsicHeight(
                                                child: Row(children: [
                                                  SizedBox(
                                                    width: 45,
                                                    child: Text(
                                                      appointments[k]
                                                          .prosNum
                                                          .toString(),
                                                      /* (k + 1)
                                                    .toString()
                                                    .padLeft(4, '0'), */
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    thickness: 2,
                                                    color: AppColors
                                                        .SECONDARY_COLOR_NEW,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width - 120,
                                                        child: Text(
                                                          appointments[k]
                                                              .prosName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .SECONDARY_COLOR_NEW),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Date : ' +
                                                                formatter.format(
                                                                    DateTime.parse(
                                                                        appointments[k]
                                                                            .date)),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          /*  Text('Time : ' +
                                                              (appointments[k]
                                                                      .time ??
                                                                  "")) */
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          MaterialButton(
                                                              minWidth: 10,
                                                              onPressed: () {
                                                                updateAppointment(
                                                                    id: appointments[
                                                                            k]
                                                                        .id,
                                                                    status:
                                                                        'OK',
                                                                    prosId: appointments[
                                                                            k]
                                                                        .prospectId);
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 6,
                                                                    horizontal:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .SECONDARY_COLOR_NEW,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Text(
                                                                  'OK',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .PRIMARY_COLOR_NEW),
                                                                ),
                                                              )),
                                                          MaterialButton(
                                                              // color: Colors.amber,
                                                              minWidth: 10,
                                                              onPressed: () {
                                                                updateAppointment(
                                                                    id: appointments[
                                                                            k]
                                                                        .id,
                                                                    status:
                                                                        'Rejected',
                                                                    prosId: appointments[
                                                                            k]
                                                                        .prospectId);
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 6,
                                                                    horizontal:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .SECONDARY_COLOR_NEW,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Text(
                                                                  'Reject',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .PRIMARY_COLOR_NEW),
                                                                ),
                                                              )),
                                                          MaterialButton(
                                                              minWidth: 10,
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                        MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      NewAppointment(
                                                                    id: appointments[
                                                                            k]
                                                                        .id,
                                                                    todo: true,
                                                                  ),
                                                                ));
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 6,
                                                                    horizontal:
                                                                        10),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .SECONDARY_COLOR_NEW,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Text(
                                                                  'Edit',
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .PRIMARY_COLOR_NEW,
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ]),
                                              ),
                                            )
                                          : Container(),
                                  ],
                                )
                              : Center(
                                  child: Text('No Appointments'),
                                ),
                        ),
                        isSalesLoading
                            ? Container(
                                // color: AppColors.PRIMARY_COLOR_NEW,
                                child: Center(
                                child: SpinKitCubeGrid(
                                  color: AppColors.SECONDARY_COLOR_NEW,
                                  size: 50.0,
                                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                                ),
                              ))
                            : Container(
                                // color: AppColors.PRIMARY_COLOR_NEW,
                                child: Stack(
                                children: [
                                  salesInterviews.length >
                                          0 /* + pendingAppointments.length > 0 */
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              bottom: 70),
                                          child: ListView(
                                            children: [
                                              for (int k = 0;
                                                  k < salesInterviews.length;
                                                  k++)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .SECONDARY_COLOR_NEW,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: IntrinsicHeight(
                                                    child: Row(children: [
                                                      SizedBox(
                                                        width: 45,
                                                        child: Text(
                                                          // (k + 1).toString().padLeft(4, '0'),
                                                          salesInterviews[k]
                                                              .prosNum
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      VerticalDivider(
                                                        thickness: 2,
                                                        color: AppColors
                                                            .SECONDARY_COLOR_NEW,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width -
                                                                110,
                                                            child: Text(
                                                              salesInterviews[k]
                                                                      .prosName ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                salesInterviews[k]
                                                                            .date !=
                                                                        null
                                                                    ? 'Date : ' +
                                                                        formatter
                                                                            .format(DateTime.parse(salesInterviews[k].date))
                                                                    : '',
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              /*   Text(salesInterviews[
                                                                              k]
                                                                          .time !=
                                                                      null
                                                                  ? 'Time : ' +
                                                                      (salesInterviews[
                                                                              k]
                                                                          .time)
                                                                  : '') */
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              MaterialButton(
                                                                  minWidth: 30,
                                                                  onPressed:
                                                                      () {
                                                                    updateInterview(
                                                                        id: salesInterviews[k]
                                                                            .id,
                                                                        status:
                                                                            'OK');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            6,
                                                                        horizontal:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .SECONDARY_COLOR_NEW,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Text(
                                                                      'OK',
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.PRIMARY_COLOR_NEW),
                                                                    ),
                                                                  )),
                                                              MaterialButton(
                                                                  minWidth: 30,
                                                                  onPressed:
                                                                      () {
                                                                    updateInterview(
                                                                        id: salesInterviews[k]
                                                                            .id,
                                                                        status:
                                                                            'Rejected');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            6,
                                                                        horizontal:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .SECONDARY_COLOR_NEW,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Text(
                                                                      'Reject',
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.PRIMARY_COLOR_NEW),
                                                                    ),
                                                                  )),
                                                              MaterialButton(
                                                                  minWidth: 30,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          NewInterviews(
                                                                        id: salesInterviews[k]
                                                                            .id,
                                                                        todo:
                                                                            true,
                                                                      ),
                                                                    ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            6,
                                                                        horizontal:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors
                                                                            .SECONDARY_COLOR_NEW,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Text(
                                                                      'Edit',
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.PRIMARY_COLOR_NEW),
                                                                    ),
                                                                  ))
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                                  ),
                                                )
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Text('No Sales Interviews'),
                                        ),
                                  /* Positioned(
                  top: 10,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: AppColors.SECONDARY_COLOR_NEW, width: 2),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: FlatButton(
                      height: 50,
                      minWidth: size.width - 100,
                      onPressed: () {
                        // login(context, "");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => RejectedInterviews(
                              // type: 'NEW',
                              ),
                          // builder: (BuildContext context) => DropDownDemo(),
                        ));
                      },
                      child: Text(
                        "Rejected Interviews",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.SECONDARY_COLOR_NEW,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ), */
                                  /*  Positioned(
                  bottom: 10,
                  width: size.width,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR_NEW,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                            color: AppColors.SECONDARY_COLOR_NEW, width: 2)),
                    child: FlatButton(
                      height: 50,
                      onPressed: () {
                        // login(context, "");
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => NewInterviews(
                            id: null,
                          ),
                          // builder: (BuildContext context) => DropDownDemo(),
                        ));
                      },
                      child: Text(
                        "Add +",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ) */
                                ],
                              )),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}
