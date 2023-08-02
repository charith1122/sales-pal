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

class DoneAppointment extends StatefulWidget {
  // const DoneAppointment({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<DoneAppointment> createState() => _DoneAppointmentState();
}

class _DoneAppointmentState extends State<DoneAppointment> {
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
          if (item.status == 'OK') {
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
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: isLoading
          ? Container(
              color: AppColors.PRIMARY_COLOR_NEW,
              child: Center(
                child: SpinKitCubeGrid(
                  color: AppColors.SECONDARY_COLOR_NEW,
                  size: 50.0,
                ),
              ))
          : Container(
              color: AppColors.PRIMARY_COLOR_NEW,
              child: Stack(
                children: [
                  Container(
                    child: appointments.isNotEmpty
                        ? ListView(
                            children: [
                              for (int k = 0; k < appointments.length; k++)
                                appointments[k].status == 'OK'
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: AppColors
                                                    .SECONDARY_COLOR_NEW,
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
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .SECONDARY_COLOR_NEW),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color:
                                                  AppColors.SECONDARY_COLOR_NEW,
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
                                                            FontWeight.bold,
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
                                                                  appointments[
                                                                          k]
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
                ],
              )),
    );
  }
}
