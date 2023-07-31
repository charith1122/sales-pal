import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/sales_interview/new_sales_interview.dart';
import 'package:pros_bot/screens/sales_interview/rejected_interviews.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class SalesInterview extends StatefulWidget {
  // const SalesInterview({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<SalesInterview> createState() => _AppointmentState();
}

class _AppointmentState extends State<SalesInterview> {
  var selectedUser;
  List<BodyOfGetAppointments> appointments = [];
  List<BodyOfGetAppointments> pendingAppointments = [];
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
    getInterviews();
  }

  getInterviews() async {
    try {
      await APIs()
          .getInterviews(userId: selectedUser["body"]["id"])
          .then((value) {
        value.body.forEach((item) {
          if (item.status == 'Active') {
            appointments.add(item);
          } else if (item.status == 'Pending') {
            pendingAppointments.add(item);
          }
        });
        setState(() {
          isLoading = false;
        });
        print(pendingAppointments);
        print(appointments);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  updateInterview({String id, status}) async {
    var result = await APIs().updateInterviews(id: id, status: status);

    if (result.done != null) {
      if (result.done) {
        appointments.clear();
        setState(() {
          isLoading = true;
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
    return Scaffold(
      // drawer: Drawer(),
      /*  appBar: AppBar(
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
        title: Text('Sales Interview',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ), */
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: isLoading
          ? Container(
              // color: AppColors.PRIMARY_COLOR,
              child: Center(
              child: SpinKitCubeGrid(
                color: AppColors.SECONDARY_COLOR,
                size: 50.0,
                // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            ))
          : Container(
              // color: AppColors.PRIMARY_COLOR,
              child: Stack(
              children: [
                appointments.length > 0 /* + pendingAppointments.length > 0 */
                    ? Container(
                        padding: EdgeInsets.only(
                            top: 0, left: 0, right: 0, bottom: 70),
                        child: ListView(
                          children: [
                            for (int k = 0; k < appointments.length; k++)
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.SECONDARY_COLOR,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(15)),
                                child: IntrinsicHeight(
                                  child: Row(children: [
                                    SizedBox(
                                      width: 45,
                                      child: Text(
                                        // (k + 1).toString().padLeft(4, '0'),
                                        appointments[k].prosNum.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
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
                                          width: size.width - 110,
                                          child: Text(
                                            appointments[k].prosName ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              appointments[k].date != null
                                                  ? 'Date : ' +
                                                      formatter.format(
                                                          DateTime.parse(
                                                              appointments[k]
                                                                  .date))
                                                  : '',
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            /*  Text(appointments[k].time != null
                                                ? 'Time : ' +
                                                    (appointments[k].time)
                                                : '') */
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            MaterialButton(
                                                minWidth: 30,
                                                onPressed: () {
                                                  updateInterview(
                                                      id: appointments[k].id,
                                                      status: 'OK');
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .SECONDARY_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .PRIMARY_COLOR),
                                                  ),
                                                )),
                                            MaterialButton(
                                                minWidth: 30,
                                                onPressed: () {
                                                  updateInterview(
                                                      id: appointments[k].id,
                                                      status: 'Rejected');
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .SECONDARY_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .PRIMARY_COLOR),
                                                  ),
                                                )),
                                            MaterialButton(
                                                minWidth: 30,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        NewInterviews(
                                                      id: appointments[k].id,
                                                    ),
                                                  ));
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .SECONDARY_COLOR,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .PRIMARY_COLOR),
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
                        child: Text('No Appointments'),
                      ),
                /* Positioned(
                  top: 10,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: AppColors.SECONDARY_COLOR, width: 2),
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
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
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
                          color: AppColors.PRYMARY_COLOR2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
