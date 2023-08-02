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

class PendingSalesInterview extends StatefulWidget {
  // const PendingSalesInterview({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<PendingSalesInterview> createState() => _PendingSalesInterviewState();
}

class _PendingSalesInterviewState extends State<PendingSalesInterview> {
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
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: isLoading
          ? Container(
              child: Center(
              child: SpinKitCubeGrid(
                color: AppColors.SECONDARY_COLOR_NEW,
                size: 50.0,
              ),
            ))
          : Container(
              child: Stack(
              children: [
                /* appointments.length + */ pendingAppointments.length > 0
                    ? Container(
                        // padding: EdgeInsets.only(
                        //     top: 70, left: 0, right: 0, bottom: 70),
                        child: ListView(
                          children: [
                            for (int j = 0; j < pendingAppointments.length; j++)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.SECONDARY_COLOR_NEW,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: IntrinsicHeight(
                                  child: Row(children: [
                                    SizedBox(
                                      width: 45,
                                      child: Text(
                                        // (j + 1).toString().padLeft(4, '0'),
                                        pendingAppointments[j]
                                            .prosNum
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: AppColors.SECONDARY_COLOR_NEW,
                                    ),
                                    Container(
                                      width: size.width - 107,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            pendingAppointments[j].prosName !=
                                                    null
                                                ? pendingAppointments[j]
                                                        .prosName +
                                                    ' (Pending)'
                                                : '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          NewInterviews(
                                                        id: pendingAppointments[
                                                                j]
                                                            .id,
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
                                                            .SECONDARY_COLOR_NEW,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Schedule',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .PRIMARY_COLOR_NEW),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text('No Appointments'),
                      ),
              ],
            )),
    );
  }
}
