import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/apointment/new_apointment.dart';
import 'package:pros_bot/screens/apointment/rejected_appointments.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class Appointment extends StatefulWidget {
  // const Appointment({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var selectedUser;
  List<BodyOfGetAppointments> appointments = [];
  bool isLoading = true;

  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat timeFormatter = DateFormat('hh:mm a');

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getAppointments();
  }

  getAppointments() async {
    try {
      await APIs()
          .getAppointments(userId: selectedUser["body"]["id"])
          .then((value) {
        value.body.forEach((item) {
          if (item.status == 'Active') {
            appointments.add(item);
          }
        });
        print(appointments);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
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
          isLoading = true;
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(),
      /* appBar: AppBar(
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
        centerTitle: true,
        title: Text('Appointment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ), */
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: isLoading
          ? Container(
              color: AppColors.PRIMARY_COLOR,
              child: Center(
                child: SpinKitCubeGrid(
                  color: AppColors.SECONDARY_COLOR,
                  size: 50.0,
                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                ),
              ))
          : Container(
              color: AppColors.PRIMARY_COLOR,
              child: Stack(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 75),
                    child: appointments.isNotEmpty
                        ? ListView(
                            children: [
                              for (int k = 0; k < appointments.length; k++)
                                appointments[k].status == 'Active'
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color:
                                                    AppColors.SECONDARY_COLOR,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 15),
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
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: AppColors.SECONDARY_COLOR,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: size.width - 120,
                                                  child: Text(
                                                    appointments[k].prosName ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                                  appointments[
                                                                          k]
                                                                      .date)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text('Time : ' +
                                                        (appointments[k].time ??
                                                            ""))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    MaterialButton(
                                                        minWidth: 10,
                                                        onPressed: () {
                                                          updateAppointment(
                                                              id: appointments[
                                                                      k]
                                                                  .id,
                                                              status: 'OK',
                                                              prosId: appointments[
                                                                      k]
                                                                  .prospectId);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .SECONDARY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .PRIMARY_COLOR),
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .SECONDARY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Text(
                                                            'Reject',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .PRIMARY_COLOR),
                                                          ),
                                                        )),
                                                    MaterialButton(
                                                        minWidth: 10,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                NewAppointment(
                                                              id: appointments[
                                                                      k]
                                                                  .id,
                                                            ),
                                                          ));
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .SECONDARY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .PRIMARY_COLOR,
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
                  /* Positioned(
                    top: 10,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.SECONDARY_COLOR),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: FlatButton(
                        height: 50,
                        minWidth: size.width - 100,
                        onPressed: () {
                          // login(context, "");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RejectedAppointment(
                                    // type: 'NEW',
                                    ),
                            // builder: (BuildContext context) => DropDownDemo(),
                          ));
                        },
                        child: Text(
                          "Rejected Appointments",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ), */
                  Positioned(
                    bottom: 10,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                  color: AppColors.SECONDARY_COLOR, width: 2)),
                          child: FlatButton(
                            height: 50,
                            onPressed: () {
                              // login(context, "");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NewAppointment(
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
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
