import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/screens/apointment/new_apointment.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/sales_interview/new_sales_interview.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class RejectedInterviews extends StatefulWidget {
  // const RejectedInterviews({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<RejectedInterviews> createState() => _RejectedInterviewsState();
}

class _RejectedInterviewsState extends State<RejectedInterviews> {
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
    getInterviews();
  }

  getInterviews() async {
    try {
      await APIs()
          .getInterviews(userId: selectedUser["body"]["id"])
          .then((value) {
        value.body.forEach((item) {
          if (item.status == 'Rejected' || item.status == 'Remove') {
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
      /* appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,

        // leading: IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       size: 30,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {}
        //     // scaffoldKey.currentState.openDrawer(),
        //     ),
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
        title: Text('Rejected Interviews',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        // automaticallyImplyLeading: false,
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
          : appointments.isNotEmpty
              ? Container(
                  color: AppColors.PRIMARY_COLOR,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 0, right: 0, bottom: 2),
                        child: ListView(
                          children: [
                            for (int k = 0; k < appointments.length; k++)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.SECONDARY_COLOR,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(10),
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
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.SECONDARY_COLOR),
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
                                          width: size.width - 115,
                                          child: Text(
                                            appointments[k].prosName ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.SECONDARY_COLOR),
                                          ),
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
                                              style: TextStyle(
                                                  color: AppColors
                                                      .SECONDARY_COLOR),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              appointments[k].time != null
                                                  ? 'Time : ' +
                                                      appointments[k].time
                                                  : '',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .SECONDARY_COLOR),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            FlatButton(
                                                onPressed: () {
                                                  updateInterview(
                                                      id: appointments[k].id,
                                                      status: 'Active');
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
                                                    'Restore',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .PRIMARY_COLOR),
                                                  ),
                                                )),
                                            /* FlatButton(
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
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )) */
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ))
              : Center(
                  child: Text('No Appointments'),
                ),
    );
  }
}
