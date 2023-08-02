import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/appointments/get_appointment.dart';
import 'package:pros_bot/screens/apointment/new_apointment.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class RejectedAppointment extends StatefulWidget {
  // const RejectedAppointment({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<RejectedAppointment> createState() => _RejectedAppointmentState();
}

class _RejectedAppointmentState extends State<RejectedAppointment> {
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
          if (item.status == 'Rejected') {
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

  updateAppointment({String id, status}) async {
    var result = await APIs().updateAppointment(id: id, status: status);

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
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: isLoading
          ? Container(
              color: AppColors.PRIMARY_COLOR_NEW,
              child: Center(
                child: SpinKitCubeGrid(
                  color: AppColors.SECONDARY_COLOR_NEW,
                  size: 50.0,
                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                ),
              ))
          : appointments.isNotEmpty
              ? Container(
                  color: AppColors.PRIMARY_COLOR_NEW,
                  child: Stack(
                    children: [
                      Container(
                        color: AppColors.PRIMARY_COLOR_NEW,
                        padding: EdgeInsets.only(
                            top: 10, left: 0, right: 0, bottom: 2),
                        child: ListView(
                          children: [
                            for (int k = 0; k < appointments.length; k++)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.SECONDARY_COLOR_NEW,
                                      width: 2),
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
                                            color:
                                                AppColors.SECONDARY_COLOR_NEW),
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: AppColors.SECONDARY_COLOR_NEW,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width - 120,
                                          child: Text(
                                            appointments[k].prosName ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors
                                                    .SECONDARY_COLOR_NEW),
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
                                              'Date : ' +
                                                  formatter.format(
                                                      DateTime.parse(
                                                          appointments[k]
                                                              .date)),
                                              style: TextStyle(
                                                  color: AppColors
                                                      .SECONDARY_COLOR_NEW),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            FlatButton(
                                                onPressed: () {
                                                  updateAppointment(
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
                                                          .SECONDARY_COLOR_NEW,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    'Restore',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .PRIMARY_COLOR_NEW),
                                                  ),
                                                )),
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
